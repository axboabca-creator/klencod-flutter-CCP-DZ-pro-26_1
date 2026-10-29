import 'package:flutter/material.dart';

void main() => runApp(const CcpProApp());

class CcpProApp extends StatelessWidget {
  const CcpProApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CCP DZ Pro 26',
      theme: ThemeData(primarySwatch: Colors.orange),
      home: const CcpHomePage(),
    );
  }
}

class CcpHomePage extends StatefulWidget {
  const CcpHomePage({super.key});

  @override
  State<CcpHomePage> createState() => _CcpHomePageState();
}

class _CcpHomePageState extends State<CcpHomePage> {
  String amountStr = "0";

  void _add(String val) => setState(() => amountStr = amountStr == "0" ? val : amountStr + val);
  void _backspace() => setState(() => amountStr = amountStr.length > 1 ? amountStr.substring(0, amountStr.length - 1) : "0");
  void _clear() => setState(() => amountStr = "0");

  @override
  Widget build(BuildContext context) {
    int amount = int.tryParse(amountStr) ?? 0;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("CCP DZ Pro 26", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.orange[800],
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // شاشة عرض المبلغ
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(icon: const Icon(Icons.delete_forever, color: Colors.red), onPressed: _clear),
                  Text("$amount DA", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.orange[900])),
                  IconButton(icon: const Icon(Icons.backspace, color: Colors.orange), onPressed: _backspace),
                ],
              ),
            ),
            const SizedBox(height: 10),
            // لوحة مفاتيح سريعة
            Expanded(
              flex: 2,
              child: GridView.count(
                crossAxisCount: 4,
                crossAxisSpacing: 6,
                mainAxisSpacing: 6,
                children: ["1", "2", "3", "0", "4", "5", "6", "00", "7", "8", "9", "000"].map((txt) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.black),
                    onPressed: () => _add(txt),
                    child: Text(txt, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  );
                }).toList(),
              ),
            ),
            const Divider(),
            // عرض الكتلة النقدية البسيطة
            Expanded(
              flex: 2,
              child: ListView(
                children: [
                  Text("الأوراق النقدية المطلوبة:", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[700])),
                  ListTile(
                    leading: const Icon(Icons.money, color: Colors.green),
                    title: const Text("فئة 2000 دج"),
                    trailing: Text("${amount ~/ 2000} ورقة", style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  ListTile(
                    leading: const Icon(Icons.money, color: Colors.blue),
                    title: const Text("فئة 500 دج"),
                    trailing: Text("${(amount % 2000) ~/ 500} ورقة", style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class ChequeSimulatorScreen extends StatelessWidget {
  final int amount;
  const ChequeSimulatorScreen({super.key, required this.amount});

  // دالة تحويل مبسطة للحروف
  String getAmountInWords(int val) {
    if (val == 34900) return "أربعة وثلاثون ألفاً وتسعمائة دينار جزائري";
    return "$val دينار جزائري";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFDD0), // لون يشبه الصك البريدي
        border: Border.all(color: Colors.orange, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("البريد الجزائري Algérie Poste", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              Text("DA # $amount #", style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 20),
          Text("مبلغ قدره: ${getAmountInWords(amount)}", style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
          const SizedBox(height: 15),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("لأمر: أنا شخصياً", style: TextStyle(fontWeight: FontWeight.bold)),
              Text("التوقيع / Signature", style: TextStyle(fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String selectedLanguage = "العربية (Arabic)";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("الإعدادات والمعلومات", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.orange[800],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // --- قسم إعدادات لغة التطبيق ---
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.language, color: Colors.orange),
                      SizedBox(width: 8),
                      Text("لغة التطبيق / Langue", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const Divider(),
                  RadioListTile<String>(
                    title: const Text("العربية (Arabic)"),
                    value: "العربية (Arabic)",
                    groupValue: selectedLanguage,
                    activeColor: Colors.orange,
                    onChanged: (val) {
                      setState(() {
                        selectedLanguage = val!;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text("Français (الفرنسية)"),
                    value: "Français",
                    groupValue: selectedLanguage,
                    activeColor: Colors.orange,
                    onChanged: (val) {
                      setState(() {
                        selectedLanguage = val!;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // --- قسم حقوق التطوير والمبرمج ---
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF212121),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.orange, width: 2),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.orange,
                    radius: 25,
                    child: const Icon(Icons.code, color: Colors.white, size: 30),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "حقوق التطوير والبرمجة",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "BOABCA AZEDDIN",
                    style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 1.2),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "azeddin2005azeddin@gmail.com",
                    style: TextStyle(color: Colors.orange[300], fontSize: 13),
                  ),
                  const Divider(color: Colors.grey, height: 25),
                  const Text(
                    "تطبيق خدمات البريد الجزائري CCP DZ Pro 26",
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.verified, color: Colors.green, size: 16),
                      const SizedBox(width: 5),
                      Text("الإصدار 1.0.0 الاحترافي", style: TextStyle(color: Colors.grey[400], fontSize: 12)),
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
}
class MainAppScreen extends StatelessWidget {
  const MainAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CCP DZ Pro 26 - لوحة التحكم", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.orange[800],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const ReverseFeeCalculatorWidget(),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange, minimumSize: const Size(double.infinity, 50)),
              onPressed: () {
                generateAndExportChequePdf("أربعة وثلاثون ألفاً وتسعمائة دينار", "34900");
              },
              icon: const Icon(Icons.picture_as_pdf, color: Colors.white),
              label: const Text("تصدير وطباعة الصك كملف PDF", style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class AllInOneCcpScreen extends StatefulWidget {
  const AllInOneCcpScreen({super.key});

  @override
  State<AllInOneCcpScreen> createState() => _AllInOneCcpScreenState();
}

class _AllInOneCcpScreenState extends State<AllInOneCcpScreen> {
  String inputAmountStr = "34900"; // مبلغ افتراضي للتجربة

  // دالة لتحديث المبلغ عبر لوحة المفاتيح المصغرة
  void _appendDigit(String digit) {
    setState(() {
      if (inputAmountStr == "0") {
        inputAmountStr = digit;
      } else {
        inputAmountStr += digit;
      }
    });
  }

  void _deleteLast() {
    setState(() {
      if (inputAmountStr.length > 1) {
        inputAmountStr = inputAmountStr.substring(0, inputAmountStr.length - 1);
      } else {
        inputAmountStr = "0";
      }
    });
  }

  void _clear() => setState(() => inputAmountStr = "0");

  @override
  Widget build(BuildContext context) {
    int currentAmount = int.tryParse(inputAmountStr) ?? 0;
    int notes2000 = currentAmount ~/ 2000;
    int notes500 = (currentAmount % 2000) ~/ 500;

    return Scaffold(
      appBar: AppBar(
        title: const Text("CCP DZ Pro 26 - الشاشة الشاملة", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.orange[800],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // --- 1. قسم إدخال وعرض المبلغ ---
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(icon: const Icon(Icons.delete_sweep, color: Colors.red), onPressed: _clear, tooltip: "مسح الكل"),
                  Text("$currentAmount DA", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.orange[900])),
                  IconButton(icon: const Icon(Icons.backspace, color: Colors.orange), onPressed: _deleteLast, tooltip: "حذف رقم"),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // --- 2. محاكاة الصك البريدي التفاعلي (يوضح كل شيء بصرياً) ---
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFFFFDD0), // لون الصك البريدي
                border: Border.all(color: Colors.orange, width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("البريد الجزائري Algérie Poste", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.black54)),
                        child: Text("DA # $currentAmount #", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text("مبلغ قدره بالحروف:", style: TextStyle(fontSize: 11, color: Colors.grey)),
                  Text(
                    currentAmount == 34900 ? "أربعة وثلاثون ألفاً وتسعمائة دينار" : "$currentAmount دينار جزائري",
                    style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("لأمر: أنا شخصياً", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                      Text("التوقيع / Signature", style: TextStyle(fontSize: 11)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // --- 3. تفكيك الكتلة النقدية (مع عدد الأوراق) ---
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.orange.shade200),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      const Text("فئة 2000 دج", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                      const SizedBox(height: 4),
                      Text("$notes2000 ورقة", style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 16)),
                    ],
                  ),
                  const VerticalDivider(color: Colors.orange),
                  Column(
                    children: [
                      const Text("فئة 500 دج", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                      const SizedBox(height: 4),
                      Text("$notes500 ورقة", style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 16)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // --- 4. لوحة الأرقام السريعة للإدخال الفوري ---
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
          ],
        ),
      ),
    );
  }
}
