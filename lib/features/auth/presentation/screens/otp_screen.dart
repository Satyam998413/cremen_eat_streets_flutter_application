import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/app_button.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

/// Email OTP login — returning users only (see AuthRepository.requestEmailOtp).
class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _emailController = TextEditingController();
  final _codeController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Log In With a Code')),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state case AuthError(:final message)) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
          }
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                final codeSent = state is AuthOtpSent;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      controller: _emailController,
                      enabled: !codeSent,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(labelText: 'Email'),
                    ).animate().fadeIn(duration: 350.ms).slideY(
                          begin: 0.2,
                          duration: 350.ms,
                          curve: Curves.easeOutCubic,
                        ),
                    const SizedBox(height: 16),
                    AnimatedSwitcher(
                      duration: 300.ms,
                      switchInCurve: Curves.easeOutCubic,
                      switchOutCurve: Curves.easeOutCubic,
                      transitionBuilder: (child, animation) => FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0, 0.08),
                            end: Offset.zero,
                          ).animate(animation),
                          child: child,
                        ),
                      ),
                      child: codeSent
                          ? Column(
                              key: const ValueKey('code-step'),
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                TextField(
                                  controller: _codeController,
                                  keyboardType: TextInputType.number,
                                  maxLength: 6,
                                  decoration: const InputDecoration(labelText: '6-digit code'),
                                ),
                                const SizedBox(height: 8),
                                AppButton(
                                  label: 'Verify',
                                  isLoading: state is AuthLoading,
                                  onPressed: () => context.read<AuthBloc>().add(
                                        AuthEvent.otpVerified(
                                          _emailController.text.trim(),
                                          _codeController.text.trim(),
                                        ),
                                      ),
                                ),
                                TextButton(
                                  onPressed: () => context.read<AuthBloc>().add(
                                        AuthEvent.otpRequested(_emailController.text.trim()),
                                      ),
                                  child: const Text('Resend code'),
                                ),
                              ],
                            )
                          : Column(
                              key: const ValueKey('email-step'),
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                AppButton(
                                  label: 'Send Code',
                                  isLoading: state is AuthLoading,
                                  onPressed: () => context.read<AuthBloc>().add(
                                        AuthEvent.otpRequested(_emailController.text.trim()),
                                      ),
                                ),
                              ],
                            ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
