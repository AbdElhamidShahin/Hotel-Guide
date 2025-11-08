import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/colors.dart';
import '../../../core/helpers/contact/custom_show_snackbar.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class VerificationScreen extends StatefulWidget {
  final String email;
  const VerificationScreen({super.key, required this.email});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  bool isVerified = false;
  bool isLoading = false;
  final _auth = FirebaseAuth.instance;

  Future<void> _checkVerification() async {
    setState(() => isLoading = true);
    await _auth.currentUser?.reload();
    final user = _auth.currentUser;

    if (user != null && user.emailVerified) {
      setState(() => isVerified = true);
      showCustomSnackbar(context, ContentType.success, 'تم التحقق ✅', 'تم تأكيد البريد بنجاح!');
      context.go('/home'); // غيّر المسار حسب اسم صفحة الـ Home عندك
    } else {
      showCustomSnackbar(context, ContentType.warning, 'لم يتم التحقق ❗', 'تحقق من بريدك وأعد المحاولة.');
    }
    setState(() => isLoading = false);
  }

  Future<void> _resendEmail() async {
    await _auth.currentUser?.sendEmailVerification();
    showCustomSnackbar(context, ContentType.help, '📧 تم الإرسال مجددًا', 'راجع بريدك الإلكتروني.');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('تم إرسال كود التحقق إلى:', style: textStyle20RegularWhite),
              const SizedBox(height: 10),
              Text(widget.email, style: textStyle25SemiBoldWhite),
              const SizedBox(height: 40),
              if (isLoading)
                const CircularProgressIndicator(color: Colors.amber)
              else
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: _checkVerification,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.yellowGold,
                        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      ),
                      child: const Text('تحقق الآن'),
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: _resendEmail,
                      child: const Text('إعادة إرسال البريد'),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
