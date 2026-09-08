import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/theme_cubit.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/theme_mode_switch.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_event.dart';
import '../../../auth/presentation/bloc/auth_state.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final _nameController = TextEditingController();
  final _newPasswordController = TextEditingController();
  bool _nameInitialized = false;

  @override
  void dispose() {
    _nameController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Account')),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state case AuthError(:final message)) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
          }
        },
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state case Authenticated(:final profile)) {
                    if (!_nameInitialized) {
                      _nameController.text = profile.fullName;
                      _nameInitialized = true;
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 28,
                              backgroundColor: AppColors.brandPrimary,
                              child: Text(
                                profile.fullName.isNotEmpty ? profile.fullName[0].toUpperCase() : '?',
                                style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(profile.email, style: Theme.of(context).textTheme.bodyMedium),
                          ],
                        ).animate().fadeIn(duration: 350.ms).slideY(begin: 0.2, duration: 350.ms, curve: Curves.easeOutCubic),
                        const SizedBox(height: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Profile', style: Theme.of(context).textTheme.titleMedium),
                            const SizedBox(height: 12),
                            TextField(
                              controller: _nameController,
                              decoration: const InputDecoration(labelText: 'Full Name'),
                            ),
                            const SizedBox(height: 8),
                            Align(
                              alignment: Alignment.centerRight,
                              child: AppButton(
                                label: 'Save Name',
                                isLoading: state is AuthLoading,
                                onPressed: () {
                                  final name = _nameController.text.trim();
                                  if (name.isEmpty) return;
                                  context.read<AuthBloc>().add(AuthEvent.fullNameUpdated(name));
                                },
                              ),
                            ),
                          ],
                        )
                            .animate(delay: 80.ms)
                            .fadeIn(duration: 350.ms)
                            .slideY(begin: 0.2, duration: 350.ms, curve: Curves.easeOutCubic),
                        const SizedBox(height: 24),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Change Password', style: Theme.of(context).textTheme.titleMedium),
                            const SizedBox(height: 12),
                            TextField(
                              controller: _newPasswordController,
                              obscureText: true,
                              decoration: const InputDecoration(labelText: 'New password (min. 8 characters)'),
                            ),
                            const SizedBox(height: 8),
                            Align(
                              alignment: Alignment.centerRight,
                              child: AppButton(
                                label: 'Update Password',
                                isOutlined: true,
                                isLoading: state is AuthLoading,
                                onPressed: () {
                                  if (_newPasswordController.text.length < 8) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Password must be at least 8 characters.')),
                                    );
                                    return;
                                  }
                                  context
                                      .read<AuthBloc>()
                                      .add(AuthEvent.passwordUpdated(_newPasswordController.text));
                                  _newPasswordController.clear();
                                },
                              ),
                            ),
                          ],
                        )
                            .animate(delay: 160.ms)
                            .fadeIn(duration: 350.ms)
                            .slideY(begin: 0.2, duration: 350.ms, curve: Curves.easeOutCubic),
                        const SizedBox(height: 24),
                        AppButton(
                          label: 'Log Out',
                          isOutlined: true,
                          onPressed: () => context.read<AuthBloc>().add(const AuthEvent.loggedOut()),
                        )
                            .animate(delay: 240.ms)
                            .fadeIn(duration: 350.ms)
                            .slideY(begin: 0.2, duration: 350.ms, curve: Curves.easeOutCubic),
                      ],
                    );
                  }
                  _nameInitialized = false;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("You're browsing as a guest.", style: Theme.of(context).textTheme.titleMedium)
                          .animate()
                          .fadeIn(duration: 350.ms)
                          .slideY(begin: 0.2, duration: 350.ms, curve: Curves.easeOutCubic),
                      const SizedBox(height: 12),
                      AppButton(label: 'Log In / Sign Up', onPressed: () => context.push('/login'))
                          .animate(delay: 80.ms)
                          .fadeIn(duration: 350.ms)
                          .slideY(begin: 0.2, duration: 350.ms, curve: Curves.easeOutCubic),
                    ],
                  );
                },
              ),
              const SizedBox(height: 32),
              Text('Appearance', style: Theme.of(context).textTheme.titleMedium)
                  .animate(delay: 300.ms)
                  .fadeIn(duration: 350.ms)
                  .slideY(begin: 0.2, duration: 350.ms, curve: Curves.easeOutCubic),
              const SizedBox(height: 12),
              BlocBuilder<ThemeCubit, ThemeMode>(
                builder: (context, mode) => ThemeModeSwitch(
                  value: mode,
                  onChanged: (newMode) => context.read<ThemeCubit>().changeTheme(newMode),
                ),
              ).animate(delay: 360.ms).fadeIn(duration: 350.ms).slideY(begin: 0.2, duration: 350.ms, curve: Curves.easeOutCubic),
              const SizedBox(height: 24),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () => context.push('/account/returns-policy'),
                  child: const Text(
                    'Returns Policy',
                    style: TextStyle(color: AppColors.brandPrimary, fontWeight: FontWeight.w600),
                  ),
                ),
              ).animate(delay: 420.ms).fadeIn(duration: 350.ms).slideY(begin: 0.2, duration: 350.ms, curve: Curves.easeOutCubic),
            ],
          ),
        ),
      ),
    );
  }
}
