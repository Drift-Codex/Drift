import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/app_feedback.dart';
import '../../navigation/main_tab_scope.dart';

class SalesPage extends StatelessWidget {
  const SalesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 120),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Page Title
          Text(
            'Mes Ventes',
            style: Theme.of(context).textTheme.displayLarge,
          ),
          const SizedBox(height: 4),
          Text(
            'Suivez vos performances financières en temps réel.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 32),

          // Summary Section: Bento Style Cards
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(12),
                    border: const Border(left: BorderSide(color: AppTheme.primary, width: 4)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'CHIFFRE D\'AFFAIRES TOTAL',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      const SizedBox(height: 8),
                      RichText(
                        text: TextSpan(
                          style: Theme.of(context).textTheme.displaySmall,
                          children: [
                            const TextSpan(text: '150 000 '),
                            TextSpan(
                              text: 'FCFA',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppTheme.onSurface,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'VENTES CE MOIS',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            '24',
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppTheme.tertiaryFixed.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              '+12%',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.tertiary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),

          // Sales Trends: Simple Bar Chart
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppTheme.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tendances (7 jours)',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    const Icon(Icons.trending_up, color: AppTheme.outline),
                  ],
                ),
                const SizedBox(height: 24),
                SizedBox(
                  height: 128, // h-32
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildBar('LUN', 48, 32, false),
                      _buildBar('MAR', 80, 64, false),
                      _buildBar('MER', 64, 48, false),
                      _buildBar('JEU', 96, 80, true), // Active/Today
                      _buildBar('VEN', 56, 40, false),
                      _buildBar('SAM', 40, 24, false),
                      _buildBar('DIM', 72, 56, false),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // Recent Transactions List
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Transactions Récentes',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              TextButton(
                onPressed: () => MainTabScope.maybeOf(context)?.goToTab(3),
                child: const Text(
                  'Tout voir',
                  style: TextStyle(color: AppTheme.primary, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          _buildTransactionItem(
            context,
            title: 'Cours de Mathématiques Terminale',
            author: 'Awa K.',
            time: '14:20',
            amount: '+1 500',
          ),
          const SizedBox(height: 12),
          _buildTransactionItem(
            context,
            title: 'SVT : Schémas du corps humain',
            author: 'Moussa S.',
            time: 'Hier',
            amount: '+2 000',
          ),
          const SizedBox(height: 12),
          _buildTransactionItem(
            context,
            title: 'Fiches de révision Histoire-Géo',
            author: 'Fatou B.',
            time: 'Hier',
            amount: '+1 200',
          ),
        ],
      ),
    );
  }

  Widget _buildBar(String label, double bgHeight, double fillHeight, bool isActive) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: bgHeight,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              color: AppTheme.secondaryContainer.withValues(alpha: 0.3),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
            ),
            alignment: Alignment.bottomCenter,
            child: Container(
              height: fillHeight,
              decoration: BoxDecoration(
                color: isActive ? AppTheme.primary : AppTheme.primaryContainer,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: isActive ? FontWeight.bold : FontWeight.w600,
              letterSpacing: 0.5,
              color: isActive ? AppTheme.primary : AppTheme.outline,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(
    BuildContext context, {
    required String title,
    required String author,
    required String time,
    required String amount,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          AppFeedback.snackBar(context, '$title — $author — $time — $amount FCFA');
        },
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppTheme.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: const Color(0x0D111111),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppTheme.primaryFixed,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.description_outlined, color: AppTheme.primary),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text('Par $author', style: const TextStyle(color: AppTheme.onSurfaceVariant, fontSize: 14)),
                        const SizedBox(width: 8),
                        Container(width: 4, height: 4, decoration: const BoxDecoration(color: AppTheme.outlineVariant, shape: BoxShape.circle)),
                        const SizedBox(width: 8),
                        Text(time, style: const TextStyle(color: AppTheme.outline, fontSize: 14)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: AppTheme.tertiaryContainer,
                  ),
                  children: [
                    TextSpan(text: amount),
                    const TextSpan(text: ' F', style: TextStyle(fontSize: 10)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
