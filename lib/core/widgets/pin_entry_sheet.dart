import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_colors.dart';

class PinEntryScreen extends StatefulWidget {
  const PinEntryScreen({super.key});

  @override
  State<PinEntryScreen> createState() => _PinEntryScreenState();
}

class _PinEntryScreenState extends State<PinEntryScreen>
    with TickerProviderStateMixin {
  late final AnimationController _backgroundController;
  late final AnimationController _pulseController;
  late final AnimationController _shakeController;
  final TextEditingController _pinController = TextEditingController();
  String? _errorMessage;
  bool _isChecking = false;

  @override
  void initState() {
    super.initState();
    _backgroundController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat(reverse: true);
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 360),
    );
  }

  @override
  void dispose() {
    _pinController.dispose();
    _backgroundController.dispose();
    _pulseController.dispose();
    _shakeController.dispose();
    super.dispose();
  }

  void _verifyPin() {
    final pin = _pinController.text.trim();

    if (pin.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter your PIN';
        _shakeController.forward(from: 0);
      });
      return;
    }

    if (pin.length != 6) {
      setState(() {
        _errorMessage = 'PIN must be 6 digits';
        _shakeController.forward(from: 0);
      });
      return;
    }

    setState(() => _isChecking = true);

    Future.delayed(const Duration(milliseconds: 800), () {
      if (!mounted) return;
      setState(() => _isChecking = false);
      if (pin == '123456') {
        final router = GoRouter.maybeOf(context);
        if (router != null) {
          router.go('/admin/dashboard');
        } else {
          Navigator.of(context).pop();
        }
      } else {
        setState(() {
          _errorMessage = 'Incorrect PIN! Try 123456';
          _pinController.clear();
          _shakeController.forward(from: 0);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withValues(alpha: 0.65),
      body: AnimatedBuilder(
        animation: _backgroundController,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.lerp(const Color(0xFF111827), const Color(0xFF1F2937), _backgroundController.value)! ,
                  Color.lerp(const Color(0xFF1F2937), const Color(0xFF111827), _backgroundController.value)! ,
                ],
              ),
            ),
            child: child,
          );
        },
        child: Stack(
          children: [
            ..._buildParticles(),
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedBuilder(
                      animation: _pulseController,
                      builder: (context, child) {
                        final scale = 1.0 + (_pulseController.value * 0.1);
                        return Transform.scale(scale: scale, child: child);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          gradient: AppColors.brandGradient,
                          borderRadius: BorderRadius.circular(22),
                        ),
                        child: const Icon(Icons.lock_open_rounded, size: 48, color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Owner Access',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        letterSpacing: -0.4,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Enter your 6-digit PIN to unlock the kitchen queue',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15, color: Colors.white.withValues(alpha: 0.72)),
                    ),
                    const SizedBox(height: 28),
                    _buildPinField(),
                    const SizedBox(height: 18),
                    if (_errorMessage != null)
                      AnimatedBuilder(
                        animation: _shakeController,
                        builder: (context, child) {
                          final shake = (_shakeController.value - 0.5).abs() * 2;
                          final offset = math.sin(shake * math.pi * 10) * 8 * shake;
                          return Transform.translate(offset: Offset(offset, 0), child: child);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                          decoration: BoxDecoration(
                            color: AppColors.spicyRed.withValues(alpha: 0.14),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.spicyRed.withValues(alpha: 0.35)),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.error_outline_rounded, color: AppColors.spicyRed, size: 18),
                              const SizedBox(width: 8),
                              Expanded(child: Text(_errorMessage!, style: TextStyle(color: AppColors.spicyRed, fontWeight: FontWeight.w700))),
                            ],
                          ),
                        ),
                      ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isChecking ? null : _verifyPin,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.brandPrimary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                        child: _isChecking
                            ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                            : const Text('VERIFY PIN', style: TextStyle(fontWeight: FontWeight.w800, letterSpacing: 0.4)),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () => context.pop(),
                      child: const Text('Cancel', style: TextStyle(color: Colors.white70)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPinField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withValues(alpha: 0.18)),
      ),
      child: TextField(
        controller: _pinController,
        keyboardType: TextInputType.number,
        maxLength: 6,
        obscureText: true,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Colors.white, letterSpacing: 8),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: '______',
          hintStyle: TextStyle(fontSize: 24, color: Colors.white38, letterSpacing: 8),
          counterText: '',
        ),
        onChanged: (value) {
          setState(() => _errorMessage = null);
          if (value.length == 6) {
            _verifyPin();
          }
        },
      ),
    );
  }

  List<Widget> _buildParticles() {
    final random = math.Random(77);
    final particles = <Widget>[];
    for (int i = 0; i < 16; i++) {
      final size = 4.0 + random.nextDouble() * 6;
      final delay = random.nextDouble() * 3;
      particles.add(
        Positioned(
          left: random.nextDouble() * 100,
          top: random.nextDouble() * 100,
          child: AnimatedBuilder(
            animation: _backgroundController,
            builder: (_, __) {
              final progress = ((_backgroundController.value + delay) % 1.0);
              final y = -size + (progress * (MediaQuery.of(context).size.height + size));
              return Opacity(
                opacity: 0.24 + random.nextDouble() * 0.28,
                child: Transform.translate(
                  offset: Offset(0, y),
                  child: Container(
                    width: size,
                    height: size,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(colors: [AppColors.brandPrimary.withValues(alpha: 0.55), AppColors.brandSecondary.withValues(alpha: 0.35)]),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      );
    }
    return particles;
  }
}
