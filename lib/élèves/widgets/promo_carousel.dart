import 'dart:async';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class PromoCardModel {
  final String badgeText;
  final IconData icon;
  final String title;
  final String description;
  final String buttonText;
  final VoidCallback onTap;
  final List<Color> gradientColors;

  const PromoCardModel({
    required this.badgeText,
    required this.icon,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.onTap,
    required this.gradientColors,
  });
}

class PromoCarousel extends StatefulWidget {
  final List<PromoCardModel> cards;
  final Duration autoplayInterval;

  const PromoCarousel({
    super.key,
    required this.cards,
    this.autoplayInterval = const Duration(seconds: 5),
  });

  @override
  State<PromoCarousel> createState() => _PromoCarouselState();
}

class _PromoCarouselState extends State<PromoCarousel> {
  late final PageController _pageController;
  int _currentPage = 0;
  Timer? _autoplayTimer;

  @override
  void initState() {
    super.initState();
    // Using a viewportFraction of 0.9 to let adjacent cards peek, showing the user it can scroll
    _pageController = PageController(viewportFraction: 0.91, initialPage: 0);
    _startAutoplay();
  }

  @override
  void dispose() {
    _autoplayTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoplay() {
    _autoplayTimer?.cancel();
    if (widget.cards.length <= 1) return;
    _autoplayTimer = Timer.periodic(widget.autoplayInterval, (timer) {
      if (!mounted) return;
      final nextPage = (_currentPage + 1) % widget.cards.length;
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      );
    });
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  // Reset autoplay timer when user manually swipes to prevent sudden transitions
  void _handleUserInteraction() {
    _startAutoplay();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.cards.isEmpty) return const SizedBox.shrink();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // PageView Slider Container
        SizedBox(
          height: 145,
          child: NotificationListener<ScrollStartNotification>(
            onNotification: (_) {
              _handleUserInteraction();
              return false;
            },
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              itemCount: widget.cards.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final card = widget.cards[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
                  child: _buildPromoCard(card),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 10),
        // Discrete Page Indicators / Dots
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.cards.length, (index) {
            final isActive = _currentPage == index;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              width: isActive ? 20.0 : 6.0,
              height: 6.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: isActive ? AppColors.brand : AppColors.textTertiary.withOpacity(0.3),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildPromoCard(PromoCardModel card) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          colors: card.gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: card.gradientColors.first.withOpacity(0.25),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // Background abstract premium pattern/circle
          Positioned(
            right: -20,
            top: -20,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            left: -40,
            bottom: -40,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                shape: BoxShape.circle,
              ),
            ),
          ),

          // Content Layout
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Top Row: Micro-Badge and Icon
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Badge
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white.withOpacity(0.25)),
                      ),
                      child: Text(
                        card.badgeText.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                    // Small branding / logo indicator on top right
                    Icon(
                      Icons.star_rounded,
                      color: Colors.white.withOpacity(0.3),
                      size: 16,
                    ),
                  ],
                ),

                // Middle Row: Logo Container + Text block
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Left Logo / Icon Container
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.18),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.white.withOpacity(0.2)),
                      ),
                      child: Icon(
                        card.icon,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Title and Description
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            card.title,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: -0.2,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            card.description,
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.white.withOpacity(0.85),
                              height: 1.3,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // Bottom Row: Push action button to right
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    height: 28,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: card.onTap,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: card.gradientColors.first,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        card.buttonText,
                        style: const TextStyle(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
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
