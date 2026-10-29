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
      home: const PinLockScreen(), // تبدأ بشاشة الرمز السري للأمان
    );
  }
}

// ==========================================
// 1. شاشة قفل الرمز السري
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