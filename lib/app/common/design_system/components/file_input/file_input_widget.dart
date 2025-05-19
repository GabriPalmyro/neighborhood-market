import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:neighborhood_market/app/common/design_system/components/support/icon/icon_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/support/icons/icons.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';

class FileInputWidget extends StatelessWidget {
  const FileInputWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);

    return SizedBox(
      width: double.infinity,
      child: CustomPaint(
        painter: DashedBorderPainter(
          color: theme.colors.neutral.light.two,
          borderRadius: theme.borders.radius.large,
          dashGap: 7,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: theme.spacing.inline.xs,
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: theme.colors.neutral.light.three.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(theme.borders.radius.small),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(theme.spacing.inline.xxs),
                    child: DSIcon(
                      icon: DSIcons.upload,
                      color: theme.colors.neutral.dark.three.withValues(alpha: 0.6),
                    ),
                  ),
                ),
                SizedBox(height: theme.spacing.inline.xxs),
                DSText(
                  'Photos',
                  textAlign: TextAlign.center,
                  customStyle: TextStyle(
                    color: theme.colors.brand.secondary,
                    fontSize: theme.font.size.xs,
                    fontWeight: theme.font.weight.medium,
                  ),
                ),
                SizedBox(height: theme.spacing.inline.xxs),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: theme.spacing.inline.sm,
                  ),
                  child: DSText(
                    'JPG, PNG - Max file size 5MB',
                    textAlign: TextAlign.center,
                    customStyle: TextStyle(
                      fontSize: theme.font.size.xxs,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DashedBorderPainter extends CustomPainter {
  DashedBorderPainter({
    required this.color,
    this.strokeWidth = 2,
    this.dashWidth = 5,
    this.dashGap = 3,
    this.borderRadius = 0,
  });

  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashGap;
  final double borderRadius;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.addRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Radius.circular(borderRadius),
      ),
    );

    final double dashSpace = dashWidth + dashGap;
    final Path dashedPath = Path();

    for (PathMetric pathMetric in path.computeMetrics()) {
      double distance = 0;
      while (distance < pathMetric.length) {
        dashedPath.addPath(
          pathMetric.extractPath(distance, distance + dashWidth),
          Offset.zero,
        );
        distance += dashSpace;
      }
    }

    canvas.drawPath(dashedPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
