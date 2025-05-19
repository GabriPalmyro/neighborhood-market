import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:neighborhood_market/app/common/component_builder/domain/entities/widget_style.dart';
import 'package:neighborhood_market/app/common/design_system/core/tokens/design/spacing.dart';

final class WidgetEdgeInsets extends Equatable {
  const WidgetEdgeInsets({
    required this.insets,
  });

  factory WidgetEdgeInsets.fromWidgetBounds({
    required DSThemeSpacing spacing,
    WidgetBounds? bounds,
  }) {
    double parseSpaceValue(String? key, {required DSThemeSpacing spacing}) {
      final spacingMap = {
        'ds_spacing_inline_xxxs': spacing.inline.xxxs,
        'ds_spacing_inline_xxs': spacing.inline.xxs,
        'ds_spacing_inline_xs': spacing.inline.xs,
        'ds_spacing_inline_sm': spacing.inline.sm,
        'ds_spacing_inline_md': spacing.inline.md,
        'ds_spacing_inline_lg': spacing.inline.lg,
        'ds_spacing_inline_xl': spacing.inline.xl,
        'ds_spacing_inline_xxl': spacing.inline.xxl,
        'ds_spacing_inline_xxxl': spacing.inline.xxxl,
      };

      final value = spacingMap[key];
      return value ?? 0;
    }

    return WidgetEdgeInsets(
      insets: EdgeInsets.only(
        top: parseSpaceValue(bounds?.top, spacing: spacing),
        right: parseSpaceValue(bounds?.right, spacing: spacing),
        bottom: parseSpaceValue(bounds?.bottom, spacing: spacing),
        left: parseSpaceValue(bounds?.left, spacing: spacing),
      ),
    );
  }

  final EdgeInsets insets;

  @override
  List<Object> get props => [insets];
}
