import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'quiz_screen.dart'; 

class ModelViewerScreen extends StatelessWidget {
  final String modelName;
  const ModelViewerScreen({super.key, required this.modelName});

  @override
  Widget build(BuildContext context) {
    // الكود الأصلي الذي يقرأ من الهاتف (معطل مؤقتاً)
    // String modelPath = 'assets/models/$modelName.glb';
    
    // رابط مباشر لمجسم 3D من الإنترنت (لغرض التجربة فقط)
    const String tempOnlineModel = 'https://modelviewer.dev/shared-assets/models/Astronaut.glb';

    return Scaffold(
      appBar: AppBar(
        title: const Text('المجسم التفاعلي (تجريبي)'),
      ),
      body: Stack(
        children: [
          ModelViewer(
            src: tempOnlineModel, // نستخدم الرابط المؤقت هنا
            alt: 'مجسم ثلاثي الأبعاد للتجربة',
            ar: false,
            autoRotate: true,
            cameraControls: true,
            backgroundColor: const Color(0xFF0A1128),
            disableZoom: false,
          ),
          
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      // نمرر اسم التجربة الفعلي لكي يظهر الاختبار الصحيح
                      builder: (context) => QuizScreen(experimentName: modelName),
                    ),
                  );
                },
                icon: const Icon(Icons.quiz, color: Color(0xFF0A1128)),
                label: const Text(
                  'اختبر فهمك للتجربة',
                  style: TextStyle(
                    color: Color(0xFF0A1128),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD4AF37),
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 10,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}