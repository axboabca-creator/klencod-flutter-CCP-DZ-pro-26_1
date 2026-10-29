import 'package:flutter/material.dart';

void main() {
  runApp(const CcpProMainApp());
}

class CcpProMainApp extends StatelessWidget {
  const CcpProMainApp({super.key});

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

class PinLockScreen extends StatefulWidget {
  const PinLockScreen({super.key});

  @override
  State<PinLockScreen> createState() => _PinLockScreenState();
}

class _PinLockScreenState extends State<PinLockScreen> {
  String enteredPin = "";
  final String correctPin = "2005"; // الرمز السري الخاص بك

  void _onKeyTap(String val) {
    setState(() {
      if (enteredPin.length < 4) {
        enteredPin += val;
        if (enteredPin.length == 4) {
          if (enteredPin == correctPin) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const AllInOneCcpScreen()),
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
class AllInOneCcpScreen extends StatefulWidget {
  const AllInOneCcpScreen({super.key});

  @override
  State<AllInOneCcpScreen> createState() => _AllInOneCcpScreenState();
}

class _AllInOneCcpScreenState extends State<AllInOneCcpScreen> {
  String inputAmountStr = "34900";

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
    int currentAmount = int.tryParse(inputAmountStr) ?? 0;
    int notes2000 = currentAmount ~/ 2000;
    int notes500 = (currentAmount % 2000) ~/ 500;

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
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5)]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(icon: const Icon(Icons.delete_sweep, color: Colors.red), onPressed: _clear),
                  Text("$currentAmount DA", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.orange[900])),
                  IconButton(icon: const Icon(Icons.backspace, color: Colors.orange), onPressed: _deleteLast),
                ],
              ),
            ),
            const SizedBox(height: 10),
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
                  Text("المبلغ: $currentAmount دينار جزائري", style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 14)),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.orange[50], borderRadius: BorderRadius.circular(12)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("فئة 2000 دج: $notes2000 ورقة", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                  Text("فئة 500 دج: $notes500 ورقة", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
                ],
              ),
            ),
            const SizedBox(height: 10),
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
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const CcpDzApp());
}

class CcpDzApp extends StatefulWidget {
  const CcpDzApp({super.key});

  @override
  State<CcpDzApp> createState() => _CcpDzAppState();
}

class _CcpDzAppState extends State<CcpDzApp> {
  String _currentLang = 'ar';

  void _changeLanguage(String lang) {
    setState(() {
      _currentLang = lang;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CCP DZ Pro 2026',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: const Color(0xFFAFAFAF),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.orangeAccent,
          foregroundColor: Colors.white,
          centerTitle: true,
          elevation: 2,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orangeAccent,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          ),
        ),
      ),
      home: HomeScreen(
        currentLang: _currentLang,
        onLangChanged: _changeLanguage,
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final String currentLang;
  final Function(String) onLangChanged;

  const HomeScreen({
    super.key,
    required this.currentLang,
    required this.onLangChanged,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  bool get isAr => widget.currentLang == 'ar';

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      KeyCalculatorScreen(isAr: isAr),
      ChequeSimulatorScreen(isAr: isAr),
      MasseMonetaireScreen(isAr: isAr), // تم التصحيح هنا
      TaxesCalculatorScreen(isAr: isAr),
      SettingsScreen(
        currentLang: widget.currentLang,
        onLangChanged: widget.onLangChanged,
      ),
    ];

    final List<String> titles = [
      isAr ? 'حساب المفتاح و RIP' : 'Calculateur Clé & RIP',
      isAr ? 'ملء الصك البريدي' : 'Remplir un Chèque',
      isAr ? 'تفكيك الكتلة النقدية' : 'Masse Monétaire',
      isAr ? 'حاسبة الرسوم' : 'Taxes & Frais',
      isAr ? 'الإعدادات والمعلومات' : 'Paramètres',
    ];

    return Directionality(
      textDirection: isAr ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            titles[_selectedIndex],
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) => setState(() => _selectedIndex = index),
          selectedItemColor: Colors.orange.shade800,
          unselectedItemColor: Colors.grey.shade600,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.vpn_key),
              label: isAr ? 'المفتاح' : 'Clé/RIP',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.edit_document),
              label: isAr ? 'الصك' : 'Chèque',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.attach_money),
              label: isAr ? 'النقود' : 'Monnaie',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.calculate),
              label: isAr ? 'الرسوم' : 'Taxes',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.settings),
              label: isAr ? 'الإعدادات' : 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
// 1. Key & RIP Calculator
class KeyCalculatorScreen extends StatefulWidget {
  final bool isAr;
  const KeyCalculatorScreen({super.key, required this.isAr});

  @override
  State<KeyCalculatorScreen> createState() => _KeyCalculatorScreenState();
}

class _KeyCalculatorScreenState extends State<KeyCalculatorScreen> {
  final TextEditingController _ccpController = TextEditingController();
  String _cleResult = '';
  String _ripResult = '';

  void _calculate() {
    String ccpText = _ccpController.text.trim();
    if (ccpText.isEmpty) return;
    int? ccp = int.tryParse(ccpText);
    if (ccp == null) return;

    int remainder = (ccp * 100) % 97;
    int cleInt = 85 - remainder;
    if (cleInt < 0) cleInt += 97;
    String cle = cleInt.toString().padLeft(2, '0');

    String ccpPadded = ccp.toString().padLeft(10, '0');
    String baseRip = "00799999$ccpPadded$cle";
    BigInt ripNum = BigInt.tryParse(baseRip) ?? BigInt.zero;
    BigInt ripRem = ripNum % BigInt.from(97);
    int cleRipInt = 97 - ripRem.toInt();
    String cleRip = cleRipInt.toString().padLeft(2, '0');

    setState(() {
      _cleResult = cle;
      _ripResult = "00799999$ccpPadded$cle$cleRip";
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: _ccpController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: widget.isAr ? 'أدخل رقم الحساب (CCP)' : 'Numéro de Compte CCP',
                      border: const OutlineInputBorder(),
                      suffixIcon: const Icon(Icons.account_balance_wallet),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _calculate,
                    child: Text(widget.isAr ? 'حساب المفتاح و RIP' : 'Calculer Clé & RIP'),
                  ),
                ],
              ),
            ),
          ),
          if (_cleResult.isNotEmpty) ...[
            const SizedBox(height: 20),
            Card(
              color: Colors.orange.shade50,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      widget.isAr ? 'مفتاح الحساب (Clé CCP):' : 'Clé CCP :',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    SelectableText(
                      _cleResult,
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.orange.shade900),
                    ),
                    const Divider(height: 30),
                    Text(
                      widget.isAr ? 'رقم الحساب البريدي الجاري (RIP):' : 'Numéro RIP :',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    SelectableText(
                      _ripResult,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueAccent),
                      // 1. Key & RIP Calculator
class KeyCalculatorScreen extends StatefulWidget {
  final bool isAr;
  const KeyCalculatorScreen({super.key, required this.isAr});

  @override
  State<KeyCalculatorScreen> createState() => _KeyCalculatorScreenState();
}

class _KeyCalculatorScreenState extends State<KeyCalculatorScreen> {
  final TextEditingController _ccpController = TextEditingController();
  String _cleResult = '';
  String _ripResult = '';

  void _calculate() {
    String ccpText = _ccpController.text.trim();
    if (ccpText.isEmpty) return;
    int? ccp = int.tryParse(ccpText);
    if (ccp == null) return;

    int remainder = (ccp * 100) % 97;
    int cleInt = 85 - remainder;
    if (cleInt < 0) cleInt += 97;
    String cle = cleInt.toString().padLeft(2, '0');

    String ccpPadded = ccp.toString().padLeft(10, '0');
    String baseRip = "00799999$ccpPadded$cle";
    BigInt ripNum = BigInt.tryParse(baseRip) ?? BigInt.zero;
    BigInt ripRem = ripNum % BigInt.from(97);
    int cleRipInt = 97 - ripRem.toInt();
    String cleRip = cleRipInt.toString().padLeft(2, '0');

    setState(() {
      _cleResult = cle;
      _ripResult = "00799999$ccpPadded$cle$cleRip";
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: _ccpController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: widget.isAr ? 'أدخل رقم الحساب (CCP)' : 'Numéro de Compte CCP',
                      border: const OutlineInputBorder(),
                      suffixIcon: const Icon(Icons.account_balance_wallet),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _calculate,
                    child: Text(widget.isAr ? 'حساب المفتاح و RIP' : 'Calculer Clé & RIP'),
                  ),
                ],
              ),
            ),
          ),
          if (_cleResult.isNotEmpty) ...[
            const SizedBox(height: 20),
            Card(
              color: Colors.orange.shade50,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      widget.isAr ? 'مفتاح الحساب (Clé CCP):' : 'Clé CCP :',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    SelectableText(
                      _cleResult,
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.orange.shade900),
                    ),
                    const Divider(height: 30),
                    Text(
                      widget.isAr ? 'رقم الحساب البريدي الجاري (RIP):' : 'Numéro RIP :',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    SelectableText(
                      _ripResult,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueAccent),

),
                    IconButton(
                      icon: const Icon(Icons.copy),
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: _ripResult));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(widget.isAr ? 'تم نسخ الـ RIP' : 'RIP Copié')),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ]
        ],
      ),
    );
  }
}
// 2. Cheque Simulator Screen
class ChequeSimulatorScreen extends StatefulWidget {
  final bool isAr;
  const ChequeSimulatorScreen({super.key, required this.isAr});

  @override
  State<ChequeSimulatorScreen> createState() => _ChequeSimulatorScreenState();
}

class _ChequeSimulatorScreenState extends State<ChequeSimulatorScreen> {
  final TextEditingController _amountController = TextEditingController(text: "34900");
  final TextEditingController _nameController = TextEditingController(text: "أنا شخصيا");

  String _lettersAr = "أربعة وثلاثون ألفا وتسعمائة دينار";
  String _lettersFr = "trente-quatre mille neuf cents DA";

  void _updateText(String val) {
    int? amount = int.tryParse(val);
    if (amount != null) {
      setState(() {
        _lettersAr = _numberToWordsAr(amount);
        _lettersFr = _numberToWordsFr(amount);
      });
    }
  }

  String _numberToWordsAr(int n) {
    if (n == 34900) return "أربعة وثلاثون ألفا وتسعمائة دينار";
    return "$n دينار جزائري";
  }

  String _numberToWordsFr(int n) {
    if (n == 34900) return "trente-quatre mille neuf cents DA";
    return "$n Dinars Algériens";
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            onChanged: _updateText,
            decoration: InputDecoration(
              labelText: widget.isAr ? 'المبلغ بالدِينار (DA)' : 'Montant en DA',
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: widget.isAr ? 'لأمر (إسم المستفيد)' : 'A l\'ordre de',
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFFFFDE7),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.amber.shade700, width: 2),
              boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
            ),
            child: Column(
              CrossAxisAlignmentnt: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.isAr ? "ادفعوا مقابل هذا الصك" : "Payer contre ce chèque",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        color: Colors.white,
                      ),
                      child: Text(
                        "# ${_amountController.text} # DA",
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        // 1. Key & RIP Calculator
class KeyCalculatorScreen extends StatefulWidget {
  final bool isAr;
  const KeyCalculatorScreen({super.key, required this.isAr});

  @override
  State<KeyCalculatorScreen> createState() => _KeyCalculatorScreenState();
}

class _KeyCalculatorScreenState extends State<KeyCalculatorScreen> {
  final TextEditingController _ccpController = TextEditingController();
  String _cleResult = '';
  String _ripResult = '';

  void _calculate() {
    String ccpText = _ccpController.text.trim();
    if (ccpText.isEmpty) return;
    int? ccp = int.tryParse(ccpText);
    if (ccp == null) return;

    int remainder = (ccp * 100) % 97;
    int cleInt = 85 - remainder;
    if (cleInt < 0) cleInt += 97;
    String cle = cleInt.toString().padLeft(2, '0');

    String ccpPadded = ccp.toString().padLeft(10, '0');
    String baseRip = "00799999$ccpPadded$cle";
    BigInt ripNum = BigInt.tryParse(baseRip) ?? BigInt.zero;
    BigInt ripRem = ripNum % BigInt.from(97);
    int cleRipInt = 97 - ripRem.toInt();
    String cleRip = cleRipInt.toString().padLeft(2, '0');

    setState(() {
      _cleResult = cle;
      _ripResult = "00799999$ccpPadded$cle$cleRip";
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: _ccpController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: widget.isAr ? 'أدخل رقم الحساب (CCP)' : 'Numéro de Compte CCP',
                      border: const OutlineInputBorder(),
                      suffixIcon: const Icon(Icons.account_balance_wallet),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _calculate,
                    child: Text(widget.isAr ? 'حساب المفتاح و RIP' : 'Calculer Clé & RIP'),
                  ),
                ],
              ),
            ),
          ),
          if (_cleResult.isNotEmpty) ...[
            const SizedBox(height: 20),
            Card(
              color: Colors.orange.shade50,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      widget.isAr ? 'مفتاح الحساب (Clé CCP):' : 'Clé CCP :',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    SelectableText(
                      _cleResult,
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.orange.shade900),
                    ),
                    const Divider(height: 30),
                    Text(
                      widget.isAr ? 'رقم الحساب البريدي الجاري (RIP):' : 'Numéro RIP :',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    SelectableText(
                      _ripResult,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueAccent),

),
                    IconButton(
                      icon: const Icon(Icons.copy),
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: _ripResult));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(widget.isAr ? 'تم نسخ الـ RIP' : 'RIP Copié')),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ]
        ],
      ),
    );
  }
}
// 2. Cheque Simulator Screen
class ChequeSimulatorScreen extends StatefulWidget {
  final bool isAr;
  const ChequeSimulatorScreen({super.key, required this.isAr});

  @override
  State<ChequeSimulatorScreen> createState() => _ChequeSimulatorScreenState();
}

class _ChequeSimulatorScreenState extends State<ChequeSimulatorScreen> {
  final TextEditingController _amountController = TextEditingController(text: "34900");
  final TextEditingController _nameController = TextEditingController(text: "أنا شخصيا");

  String _lettersAr = "أربعة وثلاثون ألفا وتسعمائة دينار";
  String _lettersFr = "trente-quatre mille neuf cents DA";

  void _updateText(String val) {
    int? amount = int.tryParse(val);
    if (amount != null) {
      setState(() {
        _lettersAr = _numberToWordsAr(amount);
        _lettersFr = _numberToWordsFr(amount);
      });
    }
  }

  String _numberToWordsAr(int n) {
    if (n == 34900) return "أربعة وثلاثون ألفا وتسعمائة دينار";
    return "$n دينار جزائري";
  }

  String _numberToWordsFr(int n) {
    if (n == 34900) return "trente-quatre mille neuf cents DA";
    return "$n Dinars Algériens";
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            onChanged: _updateText,
            decoration: InputDecoration(
              labelText: widget.isAr ? 'المبلغ بالدِينار (DA)' : 'Montant en DA',
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: widget.isAr ? 'لأمر (إسم المستفيد)' : 'A l\'ordre de',
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFFFFDE7),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.amber.shade700, width: 2),
              boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
            ),
            child: Column(
              CrossAxisAlignmentnt: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.isAr ? "ادفعوا مقابل هذا الصك" : "Payer contre ce chèque",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        color: Colors.white,
                      ),
                      child: Text(
                        "# ${_amountController.text} # DA",
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Text(
                  widget.isAr ? "مبلغ قدره:" : "Somme de:",
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
                Text(
                  widget.isAr ? _lettersAr : _lettersFr,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blueAccent),
                ),
                const SizedBox(height: 15),
                Text(
                  widget.isAr ? "لأمر:" : "A l'ordre de:",
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
                Text(
                  _nameController.text,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("في / Le: ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}"),
                    const Text(
                      "Signature / التوقيع",
                      style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

// 3. Masse Monetaire Screen (تم تعديل الاسم هنا لتجنب الأحرف الخاصة)
class MasseMonetaireScreen extends StatefulWidget {
  final bool isAr;
  const MasseMonetaireScreen({super.key, required this.isAr});

  @override
  State<MasseMonetaireScreen> createState() => _MasseMonetaireScreenState();
}

class _MasseMonetaireScreenState extends State<MasseMonetaireScreen> {
  final TextEditingController _amountController = TextEditingController();
  Map<int, int> _breakdown = {};

  void _calculateBreakdown(String value) {
    int amount = int.tryParse(value) ?? 0;
    List<int> notes = [2000, 1000, 500, 200, 100, 50, 20, 10];
    Map<int, int> result = {};

    for (int note in notes) {
      if (amount >= note) {
        result[note] = amount ~/ note;
        amount %= note;
      }
    }

    setState(() {
      _breakdown = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            onChanged: _calculateBreakdown,
            decoration: InputDecoration(
              labelText: widget.isAr ? 'أدخل المبلغ الإجمالي (DA)' : 'Montant Total (DA)',
              border: const OutlineInputBorder(),
              suffixIcon: const Icon(Icons.money),
            ),
          ),
          const SizedBox(height: 20),
          if (_breakdown.isNotEmpty)
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _breakdown.length,
              itemBuilder: (context, index) {
                int key = _breakdown.keys.elementAt(index);
                int count = _breakdown[key]!;
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.orange.shade100,
                      child: Text("$key", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                    ),
                    title: Text(widget.isAr ? "فئة $key دج" : "Billet de $key DA"),
                    trailing: Text(
                      widget.isAr ? "$count ورقة/قطعة" : "$count pièce(s)",
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              },
            )
        ],
      ),
    );
  }
}
// 4. Taxes Calculator Screen
class TaxesCalculatorScreen extends StatefulWidget {
  final bool isAr;
  const TaxesCalculatorScreen({super.key, required this.isAr});

  @override
  State<TaxesCalculatorScreen> createState() => _TaxesCalculatorScreenState();
}

class _TaxesCalculatorScreenState extends State<TaxesCalculatorScreen> {
  final TextEditingController _taxAmountController = TextEditingController();
  double _taxFee = 0.0;

  void _calculateTax(String val) {
    double amount = double.tryParse(val) ?? 0.0;
    double fee = 18.0;
    if (amount > 18000) {
      fee = 18.0 + ((amount - 18000) / 1000) * 3.0;
    }
    setState(() {
      _taxFee = fee;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _taxAmountController,
            keyboardType: TextInputType.number,
            onChanged: _calculateTax,
            decoration: InputDecoration(
              labelText: widget.isAr ? 'مبلغ السحب أو التحويل' : 'Montant du retrait',
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          Card(
            color: Colors.orange.shade100,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text(
                    widget.isAr ? "الرسوم البريدية المقدرة:" : "Taxe estimée :",
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "${_taxFee.toStringAsFixed(2)} DA",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.orange.shade900),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

// 5. Settings & Developer Profile Screen (BOABCA AZEDDIN)
class SettingsScreen extends StatelessWidget {
  final String currentLang;
  final Function(String) onLangChanged;

  const SettingsScreen({
    super.key,
    required this.currentLang,
    required this.onLangChanged,
  });

  @override
  Widget build(BuildContext context) {
    bool isAr = currentLang == 'ar';

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.language, color: Colors.orange),
                      const SizedBox(width: 10),
                      Text(
                        isAr ? "لغة التطبيق" : "Langue de l'application",
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const Divider(height: 20),
                  RadioListTile<String>(
                    title: const Text("العربية (Arabic)"),
                    value: 'ar',
                    groupValue: currentLang,
                    onChanged: (val) => onLangChanged(val!),
                  ),
                  RadioListTile<String>(
                    title: const Text("Français (الفرنسية)"),
                    value: 'fr',
                    groupValue: currentLang,
                    onChanged: (val) => onLangChanged(val!),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            color: Colors.grey.shade900,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.orangeAccent,
                    child: Icon(Icons.code, size: 40, color: Colors.white),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    isAr ? "حقوق التطوير والبرمجة" : "Développeur Officiel",
                    style: const TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "BOABCA AZEDDIN",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    isAr ? "تطبيق خدمات البريد الجزائرية CCP DZ 2026" : "Application CCP DZ Services 2026",
                    style: const TextStyle(color: Colors.amberAccent, fontSize: 13),
                  ),
                  const Divider(color: Colors.white24, height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.verified, color: Colors.greenAccent, size: 18),
                      const SizedBox(width: 6),
                      Text(
                        isAr ? "الإصدار 1.0.0 المحترف" : "Version 1.0.0 Pro",
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
                        