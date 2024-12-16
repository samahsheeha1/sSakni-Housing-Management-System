import 'package:flutter/material.dart';
import 'screens/StartApplicationPage.dart';
import 'screens/editProfilePage.dart';
import 'screens/forgot_password_page.dart';
import 'screens/housing_guidelines_page.dart';
import 'screens/login_page.dart';
import 'screens/profilePage.dart';
import 'screens/room_details_page.dart';
import 'screens/room_reservation_page.dart';
import 'screens/room_selection_page.dart';
import 'screens/roommate_matching.dart';
import 'screens/sign_up_page.dart';
import 'screens/upload_documents_page.dart';
import 'screens/user_dashboar.dart';
import 'screens/welcome_page.dart';
import 'screens/password_reset_confirmation_page.dart'; // استيراد صفحة تأكيد استعادة كلمة المرور

void main() {
  runApp(const SakniApp());
}

class SakniApp extends StatelessWidget {
  const SakniApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sakni',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: Colors.orange.shade50,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomePage(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignUpPage(),
        '/forgot-password': (context) => ForgotPasswordPage(),
        '/password-reset-confirmation': (context) =>
            const PasswordResetConfirmationPage(email: ''),
        '/startApplication': (context) => const StartApplicationPage(),
        '/uploadDocuments': (context) => const UploadDocumentsPage(),
        '/roomSelection': (context) => const RoomSelectionPage(),
        '/dashboard': (context) => const UserDashboard(),
      },
    );
  }
}
