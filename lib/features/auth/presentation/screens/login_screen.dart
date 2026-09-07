import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_button.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import 'forgot_password_screen.dart';
import 'otp_screen.dart';
import 'signup_screen.dart';

/// Shown immediately after Splash — login is the app's front door, but
/// guest checkout is still a real, supported path (the backend allows it),
/// so it stays reachable via "Continue as Guest" rather than being removed.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Log In')),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state case AuthError(:final message)) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Password'),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const ForgotPasswordScreen()),
                    ),
                    child: const Text('Forgot password?'),
                  ),
                ),
                const SizedBox(height: 12),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) => AppButton(
                    label: 'Log In',
                    isLoading: state is AuthLoading,
                    onPressed: () => context.read<AuthBloc>().add(
                          AuthEvent.loggedInWithPassword(
                            _emailController.text.trim(),
                            _passwordController.text,
                          ),
                        ),
                  ),
                ),
                const SizedBox(height: 12),
                AppButton(
                  label: 'Log In With a Code Instead',
                  isOutlined: true,
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const OtpScreen()),
                  ),
                ),
                const SizedBox(height: 24),
                OutlinedButton.icon(
                  onPressed: () => context.read<AuthBloc>().add(const AuthEvent.googleSignInRequested()),
                  icon: const Icon(Icons.g_mobiledata, size: 28),
                  label: const Text('Continue with Google'),
                ),
                const SizedBox(height: 24),
                TextButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const SignupScreen()),
                  ),
                  child: const Text(
                    "Don't have an account? Sign up",
                    style: TextStyle(color: AppColors.brandPrimary, fontWeight: FontWeight.w600),
                  ),
                ),
                TextButton(
                  onPressed: () => context.go('/onboarding'),
                  child: const Text(
                    'Continue as Guest',
                    style: TextStyle(color: AppColors.textSecondaryLight, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
