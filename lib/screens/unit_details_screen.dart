import 'package:flutter/material.dart';
import 'model_viewer_screen.dart';

class UnitDetailsScreen extends StatelessWidget {
  final String unitTitle;
  final int unitNumber;

  const UnitDetailsScreen({
    super.key,
    required this.unitTitle,
    required this.unitNumber,
  });

  @override
  Widget build(BuildContext context) {
    // تحديد الدروس والمجسمات بناءً على رقم الوحدة في المنهج اليمني
    List> experiments = [];
    
    switch (unitNumber) {
      case 1: // كمية التحرك والصواريخ
        experiments = [
          {'title': 'مبدأ عمل الصاروخ ذو ذات الدفع', 'model': 'rocket'},
          {'title': 'حركة الأقمار الصناعية', 'model': 'satellite'},
        ];
        break;
      case 2: // التيار المتردد
        experiments = [
          {'title': 'المولد الكهربائي (الدينامو)', 'model': 'dynamo'},
          {'title': 'المحول الكهربائي', 'model': 'transformer'},
          {'title': 'دائرة الرنين', 'model': 'resonance'},
        ];
        break;
      case 3: // الإلكترونيات
        experiments = [
          {'title': 'أنبوبة أشعة المهبط (CRT)', 'model': 'crt'},
          {'title': 'الوصلة الثنائية (الدايود)', 'model': 'diode'},
          {'title': 'الترانزستور (pnp - npn)', 'model': 'transistor'},
        ];
        break;
      case 4: // الفيزياء الحديثة
        experiments = [
          {'title': 'أنبوبة كوليدج (أشعة إكس)', 'model': 'xray'},
          {'title': 'الخلية الكهروضوئية', 'model': 'photoelectric'},
        ];
        break;
      default:
        experiments = [
          {'title': 'تجربة عامة', 'model': 'test'},
        ];
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('الوحدة $unitNumber: $unitTitle'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(15),
        itemCount: experiments.length,
        itemBuilder: (context, index) {
          return Card(
            color: const Color(0xFF121B38),
            elevation: 4,
            margin: const EdgeInsets.only(bottom: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: const BorderSide(color: Color(0xFFD4AF37), width: 1),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(15),
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Color(0xFF0A1128),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.view_in_ar, color: Color(0xFFD4AF37)),
              ),
              title: Text(
                experiments[index]['title']!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: const Padding(
                padding: EdgeInsets.only(top: 5),
                child: Text(
                  'اضغط لعرض المجسم التفاعلي 3D',
                  style: TextStyle(color: Colors.white70),
                ),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, color: Color(0xFFD4AF37), size: 18),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ModelViewerScreen(
                      modelName: experiments[index]['model']!,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}