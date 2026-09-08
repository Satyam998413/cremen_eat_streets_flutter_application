import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/app_button.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Forgot Password')),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state case AuthError(:final message)) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
          }
        },
        builder: (context, state) {
          final resetSent = state is AuthPasswordResetEmailSent;
          return AnimatedSwitcher(
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
            child: resetSent
                ? const Padding(
                    key: ValueKey('success-step'),
                    padding: EdgeInsets.all(24),
                    child: Text('Check your email for a link to reset your password.'),
                  )
                : SafeArea(
                    key: const ValueKey('form-step'),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(labelText: 'Email'),
                          ).animate().fadeIn(duration: 350.ms).slideY(
                                begin: 0.2,
                                duration: 350.ms,
                                curve: Curves.easeOutCubic,
                              ),
                          const SizedBox(height: 16),
                          AppButton(
                            label: 'Send Reset Link',
                            isLoading: state is AuthLoading,
                            onPressed: () => context.read<AuthBloc>().add(
                                  AuthEvent.passwordResetRequested(_emailController.text.trim()),
                                ),
                          ).animate(delay: 80.ms).fadeIn(duration: 350.ms).slideY(
                                begin: 0.2,
                                duration: 350.ms,
                                curve: Curves.easeOutCubic,
                              ),
                        ],
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }
}
