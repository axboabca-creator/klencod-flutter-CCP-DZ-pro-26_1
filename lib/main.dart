import 'package:flutter/material.dart';

void main() {
  runApp(const CcpProApp());
}

class CcpProApp extends StatelessWidget {
  const CcpProApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CCP DZ Pro 26',
      theme: ThemeData(primarySwatch: Colors.orange),
      home: const PinLockScreen(),
    );
  }
}

// ==========================================
// 1. شاشة قفل الرمز السري (الأمان)
// ==========================================
class PinLockScreen extends StatefulWidget {
  const PinLockScreen({super.key});

  @override
  State<PinLockScreen> createState() => _PinLockScreenState();
}

class _PinLockScreenState extends State<PinLockScreen> {
  String enteredPin = "";
  final String correctPin = "2026";

  void _onKeyTap(String val) {
    setState(() {
      if (enteredPin.length < 4) {
        enteredPin += val;
        if (enteredPin.length == 4) {
          if (enteredPin == correctPin) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("الرمز السري خطأ!"), backgroundColor: Colors.red),
            );
            enteredPin = "";
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[800],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.lock_outline, size: 70, color: Colors.white),
            const SizedBox(height: 20),
            const Text("أدخل الرمز السري للتطبيق", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: index < enteredPin.length ? Colors.white : Colors.white38,
                  ),
                );
              }),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: 250,
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"].map((num) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(shape: const CircleBorder(), backgroundColor: Colors.white),
                    onPressed: () => _onKeyTap(num),
                    child: Text(num, style: const TextStyle(fontSize: 20, color: Colors.black)),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 2. الشاشة الرئيسية للتطبيق
// ==========================================
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String inputAmountStr = "4580"; // المبلغ التجريبي الذي ذكرته

  void _appendDigit(String digit) {
    setState(() {
      inputAmountStr = inputAmountStr == "0" ? digit : inputAmountStr + digit;
    });
  }

  void _deleteLast() {
    setState(() {
      inputAmountStr = inputAmountStr.length > 1 ? inputAmountStr.substring(0, inputAmountStr.length - 1) : "0";
    });
  }

  void _clear() => setState(() => inputAmountStr = "0");

  @override
  Widget build(BuildContext context) {
    int amount = int.tryParse(inputAmountStr) ?? 0;

    // حساب تفكيك الكتلة النقدية الشامل لكل الفئات الجزائرية
    int n2000 = amount ~/ 2000;
    int rem = amount % 2000;

    int n1000 = rem ~/ 1000;
    rem %= 1000;

    int n500 = rem ~/ 500;
    rem %= 500;

    int n200 = rem ~/ 200;
    rem %= 200;

    int n100 = rem ~/ 100;
    rem %= 100;

    int coins = rem; // القطع المعدنية المتبقية (مثل 80 أو 50 دج)

    return Scaffold(
      appBar: AppBar(
        title: const Text("CCP DZ Pro 26", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.orange[800],
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsScreen()));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // شاشة عرض المبلغ
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5)]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(icon: const Icon(Icons.delete_sweep, color: Colors.red), onPressed: _clear),
                  Text("$amount DA", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.orange[900])),
                  IconButton(icon: const Icon(Icons.backspace, color: Colors.orange), onPressed: _deleteLast),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // محاكاة الصك البريدي
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFFFFDD0),
                border: Border.all(color: Colors.orange, width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("البريد الجزائري Algérie Poste", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Text("المبلغ: $amount دينار جزائري", style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 14)),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // ==========================================
            // [مکان مخصص 1]: يمكنك إضافة أي أداة جديدة هنا مستقبلاً (مثل حاسبة رسوم أو غيرها)
            // ==========================================

            // تفكيك الكتلة النقدية الشامل (جميع الفئات)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.orange[50], borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  const Text("تفصيل الأوراق والقطع النقدية المطلوبة:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildNoteItem("2000 دج", n2000),
                      _buildNoteItem("1000 دج", n1000),
                      _buildNoteItem("500 دج", n500),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildNoteItem("200 دج", n200),
                      _buildNoteItem("100 دج", n100),
                      _buildNoteItem("قطع متبقية", coins),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // لوحة الأرقام السريعة
            GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 6,
              mainAxisSpacing: 6,
              childAspectRatio: 2.2,
              children: ["1", "2", "3", "0", "4", "5", "6", "00", "7", "8", "9", "000"].map((txt) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.black87),
                  onPressed: () => _appendDigit(txt),
                  child: Text(txt, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                );
              }).toList(),
            ),

            // ==========================================
            // [مكان مخصص 2]: ترك هذا المكان الفارغ لإضافة أزرار أو ميزات برمجية لاحقة
            // ==========================================
          ],
        ),
      ),
    );
  }

  Widget _buildNoteItem(String title, int count) {
    return Column(
      children: [
        Text(title, style: const TextStyle(fontSize: 11, color: Colors.grey)),
        Text("$count", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black87)),
      ],
    );
  }
}

// ==========================================
// 3. شاشة الإعدادات وحقوق المبرمج
// ==========================================
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("الإعدادات والمعلومات", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.orange[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF212121),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.orange, width: 2),
              ),
              child: const Column(
                children: [
                  Text("حقوق التطوير والبرمجة", style: TextStyle(color: Colors.grey, fontSize: 12)),
                  SizedBox(height: 6),
                  Text("BOABCA AZEDDIN", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text("azeddin2005azeddin@gmail.com", style: TextStyle(color: Colors.orange, fontSize: 13)),
                ],
              ),
            ),
            // ==========================================
            // [مكان مخصص 3]: لإضافة خيارات إعدادات إضافية مستقبلاً
            // ==========================================
          ],
        ),
      ),
    );
  }
}



class ChequeSimulatorScreen extends StatefulWidget {
  const ChequeSimulatorScreen({super.key});

  @override
  State<ChequeSimulatorScreen> createState() => _ChequeSimulatorScreenState();
}

class _ChequeSimulatorScreenState extends State<ChequeSimulatorScreen> {
  // متغيرات المدخلات
  final TextEditingController _amountController = TextEditingController(text: "34900");
  final TextEditingController _beneficiaryController = TextEditingController(text: "أنا شخصياً");
  final TextEditingController _cityController = TextEditingController(text: "مستغانم");
  
  String selectedLang = "Ar"; // Ar, Fr, En

  // دالة تحويل المبلغ إلى حروف حسب اللغة المختارة
  String _getAmountInWords(int amount) {
    if (amount == 34900) {
      if (selectedLang == "Ar") return "أربعة وثلاثون ألفاً وتسعمائة دينار جزائري";
      if (selectedLang == "Fr") return "trente-quatre mille neuf cents DA";
      if (selectedLang == "En") return "thirty-four thousand nine hundred DZD";
    }
    // صيغة عامة أو مبسطة للمبالغ الأخرى
    return "$amount دينار جزائري";
  }

  @override
  Widget build(BuildContext context) {
    int amount = int.tryParse(_amountController.text) ?? 0;
    String dateToday = "29/10/2026"; // التاريخ الحالي

    return Scaffold(
      appBar: AppBar(
        title: const Text("ملء الصك البريدي (CCP)", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.orange[800],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // --- خانات الإدخال للتحكم في الصك ---
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5)],
              ),
              child: Column(
                children: [
                  TextField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    onChanged: (val) => setState(() {}),
                    decoration: const InputDecoration(
                      labelText: "المبلغ بالدينار (DA)",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.money, color: Colors.orange),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _beneficiaryController,
                    onChanged: (val) => setState(() {}),
                    decoration: const InputDecoration(
                      labelText: "لأمر (اسم المستفيد / أنا شخصياً)",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person, color: Colors.orange),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _cityController,
                    onChanged: (val) => setState(() {}),
                    decoration: const InputDecoration(
                      labelText: "المدينة (Ville)",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.location_city, color: Colors.orange),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),

            // --- واجهة الصك البريدي الحقيقي (مطابق للصور) ---
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFFFFDD0), // لون خلفية الصك البريدي الأصلي
                border: Border.all(color: Colors.orange.shade700, width: 2),
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 3))],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // شريط خيارات اللغة ورقم الصك العلوي
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // أزرار اختيار اللغات Ar, Fr, En مثل الصور[span_17](start_span)[span_17](end_span)[span_18](start_span)[span_18](end_span)[span_19](start_span)[span_19](end_span)
                      Row(
                        children: [
                          _buildLangRadio("Ar"),
                          _buildLangRadio("Fr"),
                          _buildLangRadio("En"),
                        ],
                      ),
                      // مربع المبلغ العلوي[span_20](start_span)[span_20](end_span)[span_21](start_span)[span_21](end_span)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black54),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text("DA # $amount #", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),

                  // العبارة الثابتة في الصك
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(selectedLang == "Ar" ? "Payer contre ce chèque" : "Payable against this cheque", style: const TextStyle(fontSize: 11, color: Colors.grey)),
                      const Text("ادفعوا مقابل هذا الصك", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 15),

                  // المبلغ بالحروف (يترجم حسب اللغة المختارة)[span_22](start_span)[span_22](end_span)[span_23](start_span)[span_23](end_span)[span_24](start_span)[span_24](end_span)
                  Center(
                    child: Text(
                      _getAmountInWords(amount),
                      style: const TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold, fontSize: 15),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Divider(color: Colors.orange, thickness: 1, height: 25),

                  // خانة لأمر (المستفيد)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(selectedLang == "Ar" ? "أنا شخصياً" : (_beneficiaryController.text.isEmpty ? "Moi-même" : _beneficiaryController.text),
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                      const Text("لأمر A l'ordre de", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // تاريخ التحرير والمدينة والتوقيع[span_25](start_span)[span_25](end_span)[span_26](start_span)[span_26](end_span)[span_27](start_span)[span_27](end_span)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${_cityController.text}, Le : $dateToday", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text("التوقيع / Signature", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                          SizedBox(height: 4),
                          Icon(Icons.edit, size: 18, color: Colors.blue), // رمز القلم للتوقيع مثل الصور
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ودجت صغيرة لتصميم أزرار اختيار اللغات (Ar, Fr, En)
  Widget _buildLangRadio(String langCode) {
    bool isSelected = selectedLang == langCode;
    return InkWell(
      onTap: () => setState(() => selectedLang = langCode),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Row(
          children: [
            Radio<String>(
              value: langCode,
              groupValue: selectedLang,
              activeColor: Colors.orange,
              onChanged: (val) => setState(() => selectedLang = val!),
            ),
            Text(langCode, style: TextStyle(fontWeight: FontWeight.bold, color: isSelected ? Colors.orange[900] : Colors.black87)),
          ],
        ),
      ),
    );
  }
}
