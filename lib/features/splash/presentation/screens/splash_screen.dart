import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _particleController;
  late AnimationController _logoController;
  late AnimationController _bgController;
  late AnimationController _rippleController;

  @override
  void initState() {
    super.initState();

    _bgController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    _particleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();

    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..forward();

    _rippleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    // Navigate after 3.8 seconds
    Future.delayed(const Duration(milliseconds: 3800), () {
      if (mounted) context.go('/');
    });
  }

  @override
  void dispose() {
    _particleController.dispose();
    _logoController.dispose();
    _bgController.dispose();
    _rippleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: AnimatedBuilder(
        animation: _bgController,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.lerp(
                    const Color(0xFFFFF7ED),
                    const Color(0xFFFFEDD5),
                    _bgController.value,
                  )!,
                  Color.lerp(
                    const Color(0xFFFED7AA),
                    const Color(0xFFFDBA74),
                    _bgController.value,
                  )!,
                  Color.lerp(
                    const Color(0xFFF97316),
                    const Color(0xFFF59E0B),
                    _bgController.value,
                  )!,
                ],
                stops: const [0.0, 0.5, 1.0],
              ),
            ),
            child: child,
          );
        },
        child: Stack(
          children: [
            // Floating food particles (background)
            ..._buildParticles(size),

            // Ripple circles behind logo
            Center(child: _buildRipples()),

            // Main content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo Container
                  _buildAnimatedLogo(),

                  const SizedBox(height: 28),

                  // Brand Name
                  Text(
                    'Cremen',
                    style: GoogleFonts.outfit(
                      fontSize: 46,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: -1.0,
                      shadows: [
                        Shadow(
                          color: AppColors.brandDark.withValues(alpha: 0.4),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                  )
                      .animate(delay: 600.ms)
                      .fadeIn(duration: 600.ms)
                      .slideY(begin: 0.3, curve: Curves.easeOutCubic),

                  Text(
                    'EAT STREETS',
                    style: GoogleFonts.outfit(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.white.withValues(alpha: 0.9),
                      letterSpacing: 6,
                    ),
                  )
                      .animate(delay: 800.ms)
                      .fadeIn(duration: 600.ms)
                      .slideY(begin: 0.3, curve: Curves.easeOutCubic),

                  const SizedBox(height: 14),

                  // Tagline
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.25),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.4),
                        width: 1.5,
                      ),
                    ),
                    child: Text(
                      'Surat Ka Swadist Street Food 🍽️',
                      style: GoogleFonts.outfit(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                  )
                      .animate(delay: 1100.ms)
                      .fadeIn(duration: 700.ms)
                      .scale(
                        begin: const Offset(0.8, 0.8),
                        curve: Curves.elasticOut,
                        duration: 800.ms,
                      ),

                  const SizedBox(height: 60),

                  // Loading Dots
                  _buildLoadingDots(),
                ],
              ),
            ),

            // Bottom signature
            Positioned(
              bottom: 32,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Text(
                    'By Satyam Baranwal',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.outfit(
                      fontSize: 13,
                      color: Colors.white.withValues(alpha: 0.7),
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                    ),
                  ),
                ]
                    .animate(delay: 1400.ms)
                    .fadeIn(duration: 800.ms),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedLogo() {
    return AnimatedBuilder(
      animation: _logoController,
      builder: (context, child) {
        final bounce = Curves.elasticOut.transform(
          _logoController.value.clamp(0.0, 1.0),
        );
        return Transform.scale(
          scale: bounce,
          child: child,
        );
      },
      child: Container(
        width: 130,
        height: 130,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.brandPrimary.withValues(alpha: 0.4),
              blurRadius: 30,
              spreadRadius: 8,
              offset: const Offset(0, 8),
            ),
            BoxShadow(
              color: Colors.white.withValues(alpha: 0.6),
              blurRadius: 20,
              spreadRadius: 4,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: ClipOval(
          child: Image.asset(
            'assets/images/cremen_logo.jpg',
            fit: BoxFit.cover,
            errorBuilder: (_, _, _) => Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppColors.brandGradient,
              ),
              child: const Icon(Icons.fastfood, size: 60, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRipples() {
    return AnimatedBuilder(
      animation: _rippleController,
      builder: (context, _) {
        return SizedBox(
          width: 300,
          height: 300,
          child: Stack(
            alignment: Alignment.center,
            children: List.generate(3, (i) {
              final delay = i / 3;
              final progress =
                  ((_rippleController.value + delay) % 1.0);
              return Opacity(
                opacity: (1.0 - progress) * 0.35,
                child: Container(
                  width: 130 + progress * 170,
                  height: 130 + progress * 170,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 2.0 * (1.0 - progress),
                    ),
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }

  List<Widget> _buildParticles(Size size) {
    final foodEmojis = ['🌶️', '🍲', '🥙', '🧆', '🍜', '⭐', '✨', '🔥'];
    final random = math.Random(42);

    return List.generate(12, (i) {
      final emoji = foodEmojis[i % foodEmojis.length];
      final startX = random.nextDouble() * size.width;
      final startY = size.height + 40.0;
      final endY = -80.0 + random.nextDouble() * size.height * 0.4;
      final delay = random.nextDouble() * 2.0;
      final duration = 2.5 + random.nextDouble() * 2.0;
      final xWiggle = (random.nextDouble() - 0.5) * 100;
      final fontSize = 16.0 + random.nextDouble() * 20;

      return AnimatedBuilder(
        animation: _particleController,
        builder: (context, _) {
          final t = ((_particleController.value + delay / 3.0) % 1.0);
          final smoothT = Curves.easeInOut.transform(t);
          final y = startY + (endY - startY) * smoothT;
          final x = startX + xWiggle * math.sin(t * math.pi * 2);
          final opacity = t < 0.1
              ? t / 0.1
              : t > 0.8
                  ? (1.0 - t) / 0.2
                  : 1.0;

          return Positioned(
            left: x,
            top: y,
            child: Opacity(
              opacity: opacity * 0.6,
              child: Text(
                emoji,
                style: TextStyle(fontSize: fontSize),
              ),
            ),
          );
        },
      );
    });
  }

  Widget _buildLoadingDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (i) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          width: 10,
          height: 10,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
        )
            .animate(
              delay: Duration(milliseconds: 1500 + i * 180),
              onPlay: (c) => c.repeat(reverse: true),
            )
            .scaleXY(end: 1.5, duration: 500.ms, curve: Curves.easeInOut)
            .fadeIn(duration: 300.ms);
      }),
    );
  }
}
