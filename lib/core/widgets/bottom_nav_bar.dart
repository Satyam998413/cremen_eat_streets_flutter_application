import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';

class PinEntryScreen extends StatefulWidget {
  const PinEntryScreen({super.key});

  @override
  State<PinEntryScreen> createState() => _PinEntryScreenState();
}

class _PinEntryScreenState extends State<PinEntryScreen>
    with TickerProviderStateMixin {
  late AnimationController _backgroundController;
  late AnimationController _dotPulseController;
  late AnimationController _shakeController;

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

    _dotPulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);

    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    // Auto-focus the text field
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(FocusNode());
    });
  }

  @override
  void dispose() {
    _pinController.dispose();
    _backgroundController.dispose();
    _dotPulseController.dispose();
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

    // Simulate PIN check (replace with actual auth logic)
    Future.delayed(const Duration(milliseconds: 800), () {
      if (!mounted) return;
      
      setState(() => _isChecking = false);
      
      if (pin == '123456') {
        // Successful PIN - navigate to owner dashboard
        context.go('/admin/dashboard');
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
      backgroundColor: Colors.black,
      body: AnimatedBuilder(
        animation: _backgroundController,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.lerp(
                    const Color(0xFF1E293B),
                    const Color(0xFF0F172A),
                    _backgroundController.value,
                  )!,
                  Color.lerp(
                    const Color(0xFF0F172A),
                    const Color(0xFF1E293B),
                    _backgroundController.value,
                  )!,
                ],
              ),
            ),
            child: child,
          );
        },
        child: Stack(
          children: [
            // Animated background particles
            ..._buildBackgroundParticles(),

            // Main content
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Lock icon with pulse animation
                    AnimatedBuilder(
                      animation: _dotPulseController,
                      builder: (context, child) {
                        final scale = 1.0 + (_dotPulseController.value * 0.15);
                        return Transform.scale(
                          scale: scale,
                          child: child,
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          gradient: AppColors.brandGradient,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Icon(
                          Icons.lock_outline,
                          size: 48,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Title
                    Text(
                      'Owner Access',
                      style: GoogleFonts.outfit(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Subtitle
                    Text(
                      'Enter 6-digit PIN to access kitchen orders',
                      style: GoogleFonts.outfit(
                        fontSize: 16,
                        color: Colors.white.withValues(alpha: 0.7),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // PIN input field
                    _buildPinInput(),

                    const SizedBox(height: 24),

                    // Error message
                    if (_errorMessage != null)
                      AnimatedBuilder(
                        animation: _shakeController,
                        builder: (context, child) {
                          final shake = (_shakeController.value - 0.5).abs() * 2;
                          final offset = math.sin(shake * math.pi * 10) * 8 * shake;
                          return Transform.translate(
                            offset: Offset(offset, 0),
                            child: child,
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: AppColors.spicyRed.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: AppColors.spicyRed.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.error_outline,
                                color: AppColors.spicyRed,
                                size: 18,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  _errorMessage!,
                                  style: TextStyle(
                                    color: AppColors.spicyRed,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    const SizedBox(height: 32),

                    // Verify button
                    SizedBox(
                      width: double.infinity,
                      child: AnimatedBuilder(
                        animation: _dotPulseController,
                        builder: (context, child) {
                          final isPressed = _isChecking;
                          final scale = isPressed ? 0.95 : 1.0;
                          return Transform.scale(
                            scale: scale,
                            child: child,
                          );
                        },
                        child: ElevatedButton(
                          onPressed: _isChecking ? null : _verifyPin,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.brandPrimary,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 0,
                          ),
                          child: _isChecking
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : const Text(
                                  'VERIFY PIN',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Cancel button
                    TextButton(
                      onPressed: () => context.pop(),
                      child: Text(
                        'Cancel',
                        style: GoogleFonts.outfit(
                          fontSize: 14,
                          color: Colors.white.withValues(alpha: 0.6),
                        ),
                      ),
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

  Widget _buildPinInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.2),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(16),
        color: Colors.white.withValues(alpha: 0.05),
      ),
      child: TextField(
        controller: _pinController,
        keyboardType: TextInputType.number,
        maxLength: 6,
        style: GoogleFonts.outfit(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          letterSpacing: 12,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: '______',
          hintStyle: TextStyle(
            color: Colors.white38,
            fontSize: 24,
            letterSpacing: 12,
          ),
          counterText: '',
        ),
        textAlign: TextAlign.center,
        onChanged: (value) {
          setState(() {
            _errorMessage = null; // Clear error on input
          });
          
          // Auto-verify when 6 digits entered
          if (value.length == 6) {
            _verifyPin();
          }
        },
      ),
    );
  }

  List<Widget> _buildBackgroundParticles() {
    final random = math.Random(123);
    final particles = <Widget>[];

    // Create floating particles
    for (int i = 0; i < 15; i++) {
      final size = 4.0 + random.nextDouble() * 6;
      final speed = 0.5 + random.nextDouble() * 1.5;
      final delay = random.nextDouble() * 3;
      
      particles.add(
        Positioned(
          left: random.nextDouble() * 100,
          top: random.nextDouble() * 100,
          child: AnimatedBuilder(
            animation: _backgroundController,
            builder: (context, _) {
              final progress =
                  ((_backgroundController.value + delay) % 1.0);
              final y = -size + (progress * (MediaQuery.sizeOf(context).height + size));
              final x = 0 +
                  math.sin(progress * math.pi * 2) *
                  50 *
                  (random.nextDouble() - 0.5);
              
              return Opacity(
                opacity: 0.3 + random.nextDouble() * 0.4,
                child: Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        AppColors.brandPrimary.withValues(alpha: 0.6),
                        AppColors.brandSecondary.withValues(alpha: 0.4),
                      ],
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