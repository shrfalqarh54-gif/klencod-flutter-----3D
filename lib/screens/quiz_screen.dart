import 'package:flutter/material.dart';
import '../services/storage_service.dart';

class QuizScreen extends StatefulWidget {
  final String experimentName;
  const QuizScreen({super.key, required this.experimentName});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  int _score = 0;
  bool _isAnswered = false;
  late List> _questions;

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  // قاعدة بيانات الأسئلة حسب التجربة
  void _loadQuestions() {
    final Map<String, List>> quizDatabase = {
      'rocket': [
        {'question': 'تعتمد فكرة عمل الصاروخ على قانون:', 'options': ['نيوتن الأول', 'حفظ كمية التحرك', 'الجاذبية', 'الديناميكا'], 'correctAnswerIndex': 1},
        {'question': 'السرعة التي ينفلت بها الصاروخ من جاذبية الأرض تسمى:', 'options': ['سرعة الإفلات', 'السرعة المدارية', 'السرعة الزاوية', 'السرعة الحدية'], 'correctAnswerIndex': 0},
      ],
      'dynamo': [
        {'question': 'يحول المولد الكهربائي (الدينامو) الطاقة الحركية إلى طاقة:', 'options': ['حرارية', 'كيميائية', 'كهربائية', 'مغناطيسية'], 'correctAnswerIndex': 2},
        {'question': 'تعتمد فكرة الدينامو على ظاهرة:', 'options': ['التأثير الكهروضوئي', 'الحث الكهرومغناطيسي', 'التأثير الحراري', 'أشعة إكس'], 'correctAnswerIndex': 1},
      ],
      'crt': [
        {'question': 'في أنبوبة أشعة المهبط، تنبعث الإلكترونات من:', 'options': ['المصعد (الأنود)', 'المهبط (الكاثود)', 'الشبكة', 'ألواح الانحراف'], 'correctAnswerIndex': 1},
        {'question': 'تستخدم ألواح الانحراف في أنبوبة المهبط لـ:', 'options': ['تسريع الإلكترونات', 'توجيه الشعاع الإلكتروني', 'توليد الحرارة', 'إضاءة الشاشة'], 'correctAnswerIndex': 1},
      ],
      'xray': [
        {'question': 'تسمى الأشعة السينية (أشعة إكس) بأشعة:', 'options': ['الفرملة', 'المهبط', 'ألفا', 'بيتا'], 'correctAnswerIndex': 0},
        {'question': 'في أنبوبة كوليدج، الهدف يصنع من مادة:', 'options': ['درجة انصهارها منخفضة', 'درجة انصهارها عالية جداً', 'سائلة', 'غازية'], 'correctAnswerIndex': 1},
      ],
      // أسئلة افتراضية لأي مجسم لم نضف أسئلته بعد
      'test': [
        {'question': 'هل استوعبت التجربة بشكل جيد؟', 'options': ['نعم', 'لا', 'إلى حد ما', 'أحتاج مراجعة'], 'correctAnswerIndex': 0},
      ]
    };

    // جلب الأسئلة الخاصة بالمجسم الحالي، وإذا لم توجد نظهر الأسئلة الافتراضية
    _questions = quizDatabase[widget.experimentName] ?? quizDatabase['test']!;
  }

  void _answerQuestion(int selectedIndex) {
    if (_isAnswered) return;
    
    setState(() {
      _isAnswered = true;
      if (selectedIndex == _questions[_currentQuestionIndex]['correctAnswerIndex']) {
        _score++;
      }
    });

    Future.delayed(const Duration(seconds: 2), () {
      if (_currentQuestionIndex < _questions.length - 1) {
        setState(() {
          _currentQuestionIndex++;
          _isAnswered = false;
        });
      } else {
        _finishQuiz();
      }
    });
  }

  Future<void> _finishQuiz() async {
    int pointsEarned = _score * 10;
    if (pointsEarned > 0) {
      await StorageService.addPoints(pointsEarned);
    }
    _showResultDialog(pointsEarned);
  }

  void _showResultDialog(int points) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF121B38),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: Color(0xFFD4AF37), width: 2),
        ),
        title: const Text('النتيجة النهائية', textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$_score / ${_questions.length}',
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Color(0xFFD4AF37)),
            ),
            const SizedBox(height: 10),
            Text(
              'لقد كسبت +$points نقطة!',
              style: const TextStyle(color: Colors.greenAccent, fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD4AF37),
                foregroundColor: const Color(0xFF0A1128),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () {
                Navigator.pop(context); 
                Navigator.pop(context); 
              },
              child: const Text('العودة للدرس', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = _questions[_currentQuestionIndex];
    return Scaffold(
      appBar: AppBar(title: const Text('اختبار الفهم')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'السؤال ${_currentQuestionIndex + 1} من ${_questions.length}',
              style: const TextStyle(color: Color(0xFFD4AF37), fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF121B38),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: const Color(0xFFD4AF37).withValues(alpha: 0.3)),
              ),
              child: Text(
                question['question'],
                style: const TextStyle(fontSize: 20, color: Colors.white, height: 1.5),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 30),
            ...List.generate(
              question['options'].length,
              (index) {
                Color buttonColor = const Color(0xFF121B38);
                if (_isAnswered) {
                  if (index == question['correctAnswerIndex']) {
                    buttonColor = Colors.green.shade700; 
                  } else if (index != question['correctAnswerIndex']) {
                    buttonColor = Colors.red.shade800; 
                  }
                }
                return Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: _isAnswered ? buttonColor : Colors.white24),
                      ),
                    ),
                    onPressed: () => _answerQuestion(index),
                    child: Text(
                      question['options'][index],
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}