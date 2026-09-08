import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/app_button.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

/// Gate for Google sign-ins that arrive with no verified mobile number.
class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final state = context.read<AuthBloc>().state;
    if (state case AuthNeedsProfileCompletion(:final profile)) {
      _nameController.text = profile.fullName;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _mobileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Complete Your Profile'), automaticallyImplyLeading: false),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state case AuthError(:final message)) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
          }
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text('Just need a couple more details to finish setting up your account.')
                    .animate()
                    .fadeIn(duration: 350.ms)
                    .slideY(begin: 0.2, duration: 350.ms, curve: Curves.easeOutCubic),
                const SizedBox(height: 20),
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Full Name'),
                ).animate(delay: 80.ms).fadeIn(duration: 350.ms).slideY(
                      begin: 0.2,
                      duration: 350.ms,
                      curve: Curves.easeOutCubic,
                    ),
                const SizedBox(height: 12),
                TextField(
                  controller: _mobileController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(labelText: 'Mobile Number'),
                ).animate(delay: 150.ms).fadeIn(duration: 350.ms).slideY(
                      begin: 0.2,
                      duration: 350.ms,
                      curve: Curves.easeOutCubic,
                    ),
                const SizedBox(height: 20),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) => AppButton(
                    label: 'Continue',
                    isLoading: state is AuthLoading,
                    onPressed: () => context.read<AuthBloc>().add(
                          AuthEvent.profileCompleted(
                            _nameController.text.trim(),
                            _mobileController.text.trim(),
                          ),
                        ),
                  ),
                ).animate(delay: 220.ms).fadeIn(duration: 350.ms).slideY(
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
