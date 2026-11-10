import 'package:flutter/material.dart';
import 'scanner_screen.dart';
import 'unit_details_screen.dart';
import 'timer_screen.dart';
import 'profile_screen.dart'; // استدعاء شاشة الملف الشخصي

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List> units = [
      {'title': 'كمية التحرك والصواريخ', 'icon': Icons.rocket_launch},
      {'title': 'التيار المتردد', 'icon': Icons.electric_bolt},
      {'title': 'الإلكترونيات', 'icon': Icons.memory},
      {'title': 'الفيزياء الحديثة', 'icon': Icons.biotech},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('منهج الفيزياء - 3 ثانوي'),
        actions: [
          IconButton(
            icon: const Icon(Icons.timer, size: 28),
            tooltip: 'مؤقت التركيز',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TimerScreen()),
              );
            },
          ),
          // زر الملف الشخصي الجديد
          IconButton(
            icon: const Icon(Icons.person, size: 28),
            tooltip: 'الملف الشخصي',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
          ),
          const SizedBox(width: 5),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            alignment: Alignment.centerRight,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'مرحباً بك يا بطل!', 
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)
                ),
                SizedBox(height: 5),
                Text(
                  'اختر الوحدة للبدء بالمذاكرة التفاعلية', 
                  style: TextStyle(fontSize: 15, color: Colors.white70)
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, 
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 0.85,
              ),
              itemCount: units.length,
              itemBuilder: (context, index) {
                return _buildUnitCard(context, units[index]['title'], units[index]['icon'], index + 1);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context, 
            MaterialPageRoute(builder: (context) => const ScannerScreen())
          );
        },
        backgroundColor: const Color(0xFFD4AF37),
        icon: const Icon(Icons.qr_code_scanner, color: Color(0xFF0A1128)),
        label: const Text(
          'مسح كود التجربة', 
          style: TextStyle(color: Color(0xFF0A1128), fontWeight: FontWeight.bold, fontSize: 16)
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildUnitCard(BuildContext context, String title, IconData icon, int unitNumber) {
    return Card(
      color: const Color(0xFF121B38),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UnitDetailsScreen(
                unitTitle: title,
                unitNumber: unitNumber,
              ),
            ),
          );
        },
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: const Color(0xFF0A1128),
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFD4AF37), width: 2),
                ),
                child: Icon(icon, size: 40, color: const Color(0xFFD4AF37)),
              ),
              const SizedBox(height: 15),
              Text(
                'الوحدة $unitNumber',
                style: const TextStyle(color: Color(0xFFD4AF37), fontSize: 13, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}