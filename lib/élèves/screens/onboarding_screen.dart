import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  double _pageOffset = 0;

  final List<OnboardingPage> pages = const [
    OnboardingPage(
      title: 'Banque de sujets',
      subtitle: "Accédez à des milliers de sujets d'examens avec corrigés détaillés",
      imageUrl: 'assets/image/exam_bank.png',
      color: Color(0xFF6366F1),
      icon: Icons.library_books_rounded,
    ),
    OnboardingPage(
      title: 'Assistant intelligent',
      subtitle: "Un assistant IA qui guide l'élève dans sa réflexion personnalisée",
      imageUrl: 'assets/image/ai_assistant.png',
      color: Color(0xFFEC4899),
      icon: Icons.auto_awesome_rounded,
    ),
    OnboardingPage(
      title: 'Communauté & Forum',
      subtitle: "Posez des questions, partagez et apprenez avec d'autres élèves",
      imageUrl: 'assets/image/forum.png',
      color: Color(0xFF10B981),
      icon: Icons.people_rounded,
    ),
  ];

  void _navigateToAuth() {
    context.go('/dashboard');
  }

  void _nextPage() {
    if (_currentIndex == pages.length - 1) {
      _navigateToAuth();
    } else {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOutCubic,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _pageOffset = _pageController.page ?? 0;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white,
                  AppColors.background?.withOpacity(0.5) ?? Colors.grey.shade50,
                ],
              ),
            ),
          ),

          // Main Content
          SafeArea(
            child: Column(
              children: [
                // Skip button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                      onPressed: _navigateToAuth,
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.textSecondary,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        'Passer',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),

                // Page View
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: pages.length,
                    onPageChanged: (index) {
                      setState(() => _currentIndex = index);
                    },
                    itemBuilder: (context, index) {
                      final page = pages[index];
                      final isCurrentPage = _currentIndex == index;
                      final animationValue = (_pageOffset - index).abs().clamp(0.0, 1.0);
                      
                      return AnimatedOpacity(
                        duration: const Duration(milliseconds: 400),
                        opacity: isCurrentPage ? 1.0 : 0.5,
                        child: Transform.scale(
                          scale: isCurrentPage ? 1.0 : 0.95,
                          child: OnboardingContent(page: page, animationValue: animationValue),
                        ),
                      );
                    },
                  ),
                ),

                // Navigation Controls
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
                  child: Column(
                    children: [
                      // Progress Indicator
                      AnimatedProgressIndicator(
                        currentIndex: _currentIndex,
                        totalPages: pages.length,
                      ),
                      const SizedBox(height: 32),

                      // Next Button
                      FilledButton(
                        onPressed: _nextPage,
                        style: FilledButton.styleFrom(
                          minimumSize: const Size(double.infinity, 56),
                          backgroundColor: AppColors.brand,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _currentIndex == pages.length - 1 ? 'Commencer' : 'Suivant',
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            if (_currentIndex != pages.length - 1) ...[
                              const SizedBox(width: 8),
                              Icon(
                                Icons.arrow_forward_rounded,
                                size: 18,
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingContent extends StatelessWidget {
  final OnboardingPage page;
  final double animationValue;

  const OnboardingContent({
    super.key,
    required this.page,
    required this.animationValue,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Animated Image Container
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeOutCubic,
              builder: (context, value, child) {
                return Transform.scale(
                  scale: 0.8 + (value * 0.2),
                  child: Opacity(
                    opacity: value,
                    child: child,
                  ),
                );
              },
              child: Container(
                height: 320,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(
                      color: page.color.withOpacity(0.2),
                      blurRadius: 30,
                      offset: const Offset(0, 15),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(32),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Load local asset images when the path is not a network URL,
                      // otherwise fall back to network image. This handles both cases
                      // and prevents attempting to load an asset via `Image.network`.
                      page.imageUrl.startsWith('http')
                          ? Image.network(
                              page.imageUrl,
                              fit: BoxFit.cover,
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Container(
                                  color: AppColors.background,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: page.color,
                                    ),
                                  ),
                                );
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: page.color.withOpacity(0.1),
                                  child: Icon(
                                    page.icon,
                                    size: 64,
                                    color: page.color.withOpacity(0.5),
                                  ),
                                );
                              },
                            )
                          : Image.asset(
                              page.imageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: page.color.withOpacity(0.1),
                                  child: Icon(
                                    page.icon,
                                    size: 64,
                                    color: page.color.withOpacity(0.5),
                                  ),
                                );
                              },
                            ),
                      // Gradient Overlay
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.2),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 48),

            // Title with animation
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeOutCubic,
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(0, 20 * (1 - value)),
                  child: Opacity(
                    opacity: value,
                    child: child,
                  ),
                );
              },
              child: Column(
                children: [
                  // Icon badge
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: page.color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(
                      page.icon,
                      color: page.color,
                      size: 32,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Title
                  Text(
                    page.title,
                    style: GoogleFonts.inter(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                      letterSpacing: -0.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),

                  // Subtitle
                  Text(
                    page.subtitle,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textSecondary,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AnimatedProgressIndicator extends StatelessWidget {
  final int currentIndex;
  final int totalPages;

  const AnimatedProgressIndicator({
    super.key,
    required this.currentIndex,
    required this.totalPages,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalPages, (index) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 6),
          width: currentIndex == index ? 28 : 8,
          height: 8,
          decoration: BoxDecoration(
            gradient: currentIndex == index
                ? LinearGradient(
                    colors: [
                      AppColors.brand ?? Colors.indigo,
                      (AppColors.brand ?? Colors.indigo).withOpacity(0.7),
                    ],
                  )
                : null,
            color: currentIndex == index ? null : AppColors.divider,
            borderRadius: BorderRadius.circular(12),
          ),
        );
      }),
    );
  }
}

class OnboardingPage {
  final String title;
  final String subtitle;
  final String imageUrl;
  final Color color;
  final IconData icon;

  const OnboardingPage({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.color,
    required this.icon,
  });
}