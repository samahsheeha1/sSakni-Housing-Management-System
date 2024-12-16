import 'package:flutter/material.dart';
import 'package:animated_background/animated_background.dart';
import 'package:lottie/lottie.dart';

class PasswordResetConfirmationPage extends StatefulWidget {
  final String email;

  const PasswordResetConfirmationPage({super.key, required this.email});

  @override
  _PasswordResetConfirmationPageState createState() =>
      _PasswordResetConfirmationPageState();
}

class _PasswordResetConfirmationPageState
    extends State<PasswordResetConfirmationPage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    // تحديد عرض الشاشة
    final double screenWidth = MediaQuery.of(context).size.width;

    // تحديد عرض البطاقة بناءً على حجم الشاشة
    double cardWidth;
    if (screenWidth > 600) {
      // للشاشات الكبيرة، تحديد عرض أقصى
      cardWidth = 500;
    } else {
      // للشاشات الصغيرة، استخدام 90% من عرض الشاشة
      cardWidth = screenWidth * 0.9;
    }

    return Scaffold(
      // تمت إزالة خاصية appBar هنا
      body: AnimatedBackground(
        behaviour: RandomParticleBehaviour(
          options: const ParticleOptions(
            baseColor: Colors.orange,
            spawnOpacity: 0.0,
            opacityChangeRate: 0.25,
            minOpacity: 0.1,
            maxOpacity: 0.4,
            spawnMinSpeed: 30.0,
            spawnMaxSpeed: 70.0,
            spawnMinRadius: 7.0,
            spawnMaxRadius: 20.0,
            particleCount: 50,
          ),
        ),
        vsync: this,
        child: Center(
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              width: cardWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFFFA726),
                    Color(0xFFFF7043)
                  ], // درجات البرتقالي
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // استبدال الأيقونة بالرسوم المتحركة من Lottie
                  Lottie.asset(
                    'assets/animations/success_check.json',
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Password Reset Link Sent',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'A password reset link has been sent to ${widget.email}.\n'
                    'Please check your email and follow the instructions to reset your password.',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 30),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(50), // زوايا دائرية أكثر
                      ),
                      side: const BorderSide(
                          color: Colors.orange,
                          width: 2), // إضافة حدود برتقالية
                    ),
                    child: const Text(
                      'Return to Login',
                      style: TextStyle(fontSize: 18, color: Colors.orange),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
