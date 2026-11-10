import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String _pointsKey = 'student_points';

  // دالة لإضافة نقاط جديدة لرصيد الطالب
  static Future<void> addPoints(int points) async {
    final prefs = await SharedPreferences.getInstance();
    int currentPoints = prefs.getInt(_pointsKey) ?? 0;
    await prefs.setInt(_pointsKey, currentPoints + points);
  }

  // دالة لجلب إجمالي النقاط
  static Future<int> getTotalPoints() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_pointsKey) ?? 0;
  }
}