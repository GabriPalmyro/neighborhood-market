import 'package:flutter/material.dart';
import 'package:neighborhood_market/app/common/design_system/components/support/icon/icon_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/text_field/text_field_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/support/icons/icons.dart';
import 'package:neighborhood_market/app/common/design_system/core/support/icons/icons_data.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';

class SearchSuccessWidget extends StatelessWidget {
  const SearchSuccessWidget({
    required this.label,
    required this.leadingIcon,
    this.controller,
    this.onSubmitted,
    this.onChanged,
    this.enabled = true,
    this.onClear,
    this.showClearButton = true,
    this.focusNode,
    this.onTapOutside,
    super.key,
  });

  final String label;
  final IconAssetData leadingIcon;
  final TextEditingController? controller;
  final Function(String?)? onSubmitted;
  final Function(String?)? onChanged;
  final VoidCallback? onClear;
  final bool enabled;
  final bool showClearButton;
  final FocusNode? focusNode;
  final Function(PointerDownEvent)? onTapOutside;

  @override
  Widget build(BuildContext context) {
    final tokens = DSTheme.getDesignTokensOf(context);
    return DSTextField(
      controller: controller,
      label: label,
      textInputAction: TextInputAction.search,
      onFieldSubmitted: onSubmitted,
      enabled: enabled,
      focusNode: focusNode,
      onChanged: onChanged,
      onTapOutside: onTapOutside,
      prefixWidget: IconButton(
        highlightColor: tokens.colors.neutral.light.one.withValues(alpha: 0.3),
        onPressed: null,
        icon: DSIcon(
          icon: leadingIcon,
          color: tokens.colors.neutral.light.two,
          size: DSIconSize.sm,
        ),
      ),
      suffixWidget: showClearButton
          ? IconButton(
              highlightColor: tokens.colors.neutral.light.one.withValues(alpha: 0.3),
              onPressed: onClear,
              icon: DSIcon(
                icon: DSIcons.close,
                color: tokens.colors.neutral.light.two,
                size: DSIconSize.sm,
              ),
            )
          : null,
    );
  }
}
