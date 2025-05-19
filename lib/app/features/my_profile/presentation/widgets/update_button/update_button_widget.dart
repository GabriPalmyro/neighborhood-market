import 'package:flutter/widgets.dart';
import 'package:neighborhood_market/app/common/design_system/components/clickable/clickable_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';

class UpdateButtonWidget extends StatelessWidget {
  const UpdateButtonWidget({required this.onPressed, super.key});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    return ClickableWidget(
      borderRadius: BorderRadius.circular(
        theme.borders.radius.pill,
      ),
      onTap: onPressed,
      child: Container(
        height: 45.0,
        decoration: BoxDecoration(
          color: theme.colors.neutral.light.pure,
          borderRadius: BorderRadius.circular(
            theme.borders.radius.pill,
          ),
          border: Border.all(
            color: theme.colors.neutral.light.three,
          ),
          boxShadow: [theme.shadow.normal],
        ),
        padding: EdgeInsets.symmetric(
          horizontal: theme.spacing.inline.xs,
        ),
        child: Center(
          child: DSText(
            'Update',
            customStyle: TextStyle(
              fontSize: theme.font.size.xxs,
            ),
          ),
        ),
      ),
    );
  }
}
