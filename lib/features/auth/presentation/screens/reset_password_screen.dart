import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/app_button.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

/// Reached via the Supabase password-recovery deep link, which must already
/// have established a recovery session before this screen opens — deep-link
/// handling (app_links/uni_links + platform manifest config) is tracked as a
/// follow-up, not yet wired in this slice.
class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reset Password')),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          switch (state) {
            case AuthError(:final message):
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
            case Authenticated():
              context.go('/');
            default:
              break;
          }
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'New password (min. 8 characters)'),
                ).animate().fadeIn(duration: 350.ms).slideY(
                      begin: 0.2,
                      duration: 350.ms,
                      curve: Curves.easeOutCubic,
                    ),
                const SizedBox(height: 16),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) => AppButton(
                    label: 'Update Password',
                    isLoading: state is AuthLoading,
                    onPressed: () {
                      if (_passwordController.text.length < 8) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Password must be at least 8 characters.')),
                        );
                        return;
                      }
                      context.read<AuthBloc>().add(AuthEvent.passwordUpdated(_passwordController.text));
                    },
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
      ),
    );
  }
}
