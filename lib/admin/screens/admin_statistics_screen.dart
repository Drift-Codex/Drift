import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/admin_colors.dart';

class AdminStatisticsScreen extends StatelessWidget {
  const AdminStatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AdminColors.background,
      appBar: AppBar(
        backgroundColor: AdminColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AdminColors.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: const Text('Statistiques', style: TextStyle(color: AdminColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 18)),
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              children: const [
                Text('30 derniers jours', style: TextStyle(color: AdminColors.textPrimary, fontSize: 12)),
                SizedBox(width: 4),
                Icon(Icons.keyboard_arrow_down, size: 16, color: AdminColors.textPrimary),
              ],
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: _buildStatCard('1,248', 'Utilisateurs', '+12%', AdminColors.primary.withOpacity(0.1), AdminColors.primary)),
                const SizedBox(width: 12),
                Expanded(child: _buildStatCard('342', 'Sujets', '+8%', Colors.purple.withOpacity(0.1), Colors.purple)),
                const SizedBox(width: 12),
                Expanded(child: _buildStatCard('156', 'Cours', '+15%', Colors.green.withOpacity(0.1), Colors.green)),
              ],
            ),
            const SizedBox(height: 32),
            
            const Text('Évolution des utilisateurs', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AdminColors.textPrimary)),
            const SizedBox(height: 16),
            Container(
              height: 200,
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: CustomPaint(
                painter: LineChartPainter(AdminColors.primary),
              ),
            ),
            const SizedBox(height: 32),

            const Text('Activités par type', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AdminColors.textPrimary)),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: Row(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: CustomPaint(painter: PieChartPainter()),
                  ),
                  const SizedBox(width: 32),
                  Expanded(
                    child: Column(
                      children: [
                        _buildLegendItem('Sujets ajoutés', '40%', Colors.purple),
                        _buildLegendItem('Cours ajoutés', '30%', Colors.blue),
                        _buildLegendItem('Utilisateurs inscrits', '20%', Colors.lightBlue),
                        _buildLegendItem('Autres', '10%', Colors.grey),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String value, String label, String trend, Color bgColor, Color iconColor) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(8)),
            child: Icon(Icons.analytics_outlined, color: iconColor, size: 20),
          ),
          const SizedBox(height: 12),
          Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AdminColors.textPrimary)),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 11, color: AdminColors.textSecondary)),
          const SizedBox(height: 8),
          Text(trend, style: const TextStyle(color: AdminColors.success, fontWeight: FontWeight.bold, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, String percentage, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(width: 12, height: 12, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          const SizedBox(width: 8),
          Expanded(child: Text(label, style: const TextStyle(fontSize: 12, color: AdminColors.textSecondary))),
          Text(percentage, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AdminColors.textPrimary)),
        ],
      ),
    );
  }
}

class LineChartPainter extends CustomPainter {
  final Color color;
  LineChartPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();
    path.moveTo(0, size.height * 0.8);
    path.quadraticBezierTo(size.width * 0.15, size.height * 0.8, size.width * 0.25, size.height * 0.6);
    path.quadraticBezierTo(size.width * 0.4, size.height * 0.4, size.width * 0.5, size.height * 0.5);
    path.quadraticBezierTo(size.width * 0.7, size.height * 0.7, size.width * 0.85, size.height * 0.2);
    path.lineTo(size.width, size.height * 0.3);

    canvas.drawPath(path, paint);
    
    // Draw dots
    final dotPaint = Paint()..color = Colors.white..style = PaintingStyle.fill;
    final borderPaint = Paint()..color = color..strokeWidth = 2..style = PaintingStyle.stroke;
    
    _drawDot(canvas, Offset(0, size.height * 0.8), dotPaint, borderPaint);
    _drawDot(canvas, Offset(size.width * 0.25, size.height * 0.6), dotPaint, borderPaint);
    _drawDot(canvas, Offset(size.width * 0.5, size.height * 0.5), dotPaint, borderPaint);
    _drawDot(canvas, Offset(size.width * 0.85, size.height * 0.2), dotPaint, borderPaint);
    _drawDot(canvas, Offset(size.width, size.height * 0.3), dotPaint, borderPaint);
  }
  
  void _drawDot(Canvas canvas, Offset offset, Paint fill, Paint stroke) {
    canvas.drawCircle(offset, 4, fill);
    canvas.drawCircle(offset, 4, stroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class PieChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final paint = Paint()..style = PaintingStyle.stroke..strokeWidth = 20;

    // Purple (40%)
    paint.color = Colors.purple.shade400;
    canvas.drawArc(rect, -pi / 2, 2 * pi * 0.4, false, paint);

    // Blue (30%)
    paint.color = Colors.blue.shade600;
    canvas.drawArc(rect, -pi / 2 + 2 * pi * 0.4, 2 * pi * 0.3, false, paint);

    // Light Blue (20%)
    paint.color = Colors.lightBlue.shade300;
    canvas.drawArc(rect, -pi / 2 + 2 * pi * 0.7, 2 * pi * 0.2, false, paint);

    // Grey (10%)
    paint.color = Colors.grey.shade400;
    canvas.drawArc(rect, -pi / 2 + 2 * pi * 0.9, 2 * pi * 0.1, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
