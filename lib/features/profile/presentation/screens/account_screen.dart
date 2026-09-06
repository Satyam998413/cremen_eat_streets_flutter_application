import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/theme_cubit.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/theme_mode_switch.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_event.dart';
import '../../../auth/presentation/bloc/auth_state.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Account')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state case Authenticated(:final profile)) {
                  return Column(
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
                      const SizedBox(height: 12),
                      Text(
                        profile.fullName.isNotEmpty ? profile.fullName : 'Your Account',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(profile.email, style: Theme.of(context).textTheme.bodyMedium),
                      const SizedBox(height: 16),
                      AppButton(
                        label: 'Log Out',
                        isOutlined: true,
                        onPressed: () => context.read<AuthBloc>().add(const AuthEvent.loggedOut()),
                      ),
                    ],
                  );
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("You're browsing as a guest.", style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 12),
                    AppButton(label: 'Log In / Sign Up', onPressed: () => context.push('/login')),
                  ],
                );
              },
            ),
            const SizedBox(height: 32),
            Text('Appearance', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            BlocBuilder<ThemeCubit, ThemeMode>(
              builder: (context, mode) => ThemeModeSwitch(
                value: mode,
                onChanged: (newMode) => context.read<ThemeCubit>().changeTheme(newMode),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
