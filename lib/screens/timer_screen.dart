import 'dart:async';
import 'package:flutter/material.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  // تعيين وقت التركيز الافتراضي: 25 دقيقة (بالثواني)
  static const int defaultTime = 25 * 60;
  int _timeLeft = defaultTime;
  bool _isRunning = false;
  Timer? _timer;

  void _startTimer() {
    if (_timer != null) _timer!.cancel();
    setState(() {
      _isRunning = true;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeLeft > 0) {
          _timeLeft--;
        } else {
          _timer!.cancel();
          _isRunning = false;
          // إظهار تنبيه عند انتهاء الوقت
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('انتهى وقت التركيز! خذ استراحة قصيرة.'),
              backgroundColor: Color(0xFFD4AF37),
            ),
          );
        }
      });
    });
  }

  void _pauseTimer() {
    if (_timer != null) _timer!.cancel();
    setState(() {
      _isRunning = false;
    });
  }

  void _resetTimer() {
    if (_timer != null) _timer!.cancel();
    setState(() {
      _isRunning = false;
      _timeLeft = defaultTime;
    });
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = remainingSeconds.toString().padLeft(2, '0');
    return '$minutesStr:$secondsStr';
  }

  @override
  void dispose() {
    if (_timer != null) _timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('مؤقت التركيز'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // الدائرة التفاعلية للوقت
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 250,
                  height: 250,
                  child: CircularProgressIndicator(
                    value: _timeLeft / defaultTime,
                    strokeWidth: 12,
                    backgroundColor: const Color(0xFF121B38),
                    valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFD4AF37)),
                  ),
                ),
                Text(
                  _formatTime(_timeLeft),
                  style: const TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            
            // أزرار التحكم
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildControlButton(
                  icon: Icons.refresh,
                  label: 'إعادة',
                  onPressed: _resetTimer,
                  color: Colors.white70,
                ),
                const SizedBox(width: 20),
                _isRunning
                    ? _buildControlButton(
                        icon: Icons.pause,
                        label: 'إيقاف مؤقت',
                        onPressed: _pauseTimer,
                        color: const Color(0xFFD4AF37),
                        isPrimary: true,
                      )
                    : _buildControlButton(
                        icon: Icons.play_arrow,
                        label: 'ابدأ التركيز',
                        onPressed: _startTimer,
                        color: const Color(0xFFD4AF37),
                        isPrimary: true,
                      ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    required Color color,
    bool isPrimary = false,
  }) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(20),
            backgroundColor: isPrimary ? color : const Color(0xFF121B38),
            foregroundColor: isPrimary ? const Color(0xFF0A1128) : color,
          ),
          child: Icon(icon, size: 35),
        ),
        const SizedBox(height: 10),
        Text(
          label,
          style: TextStyle(
            color: isPrimary ? color : Colors.white70,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}