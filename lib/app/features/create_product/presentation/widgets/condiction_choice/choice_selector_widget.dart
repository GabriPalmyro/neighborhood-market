import 'package:flutter/material.dart';
import 'package:neighborhood_market/app/common/design_system/components/chips/chip_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';

class ChoiceSelectorWidget extends StatelessWidget {
  const ChoiceSelectorWidget({
    required this.label,
    required this.choices,
    required this.onTap,
    this.selectedId = '',
    this.tooltip,
    this.errorText,
    super.key,
  });

  final String label;
  final List<String> choices;
  final String? tooltip;
  final Function(String) onTap;
  final String selectedId;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    return FormField<String>(
      validator: (value) {
        if (selectedId.isEmpty) {
          return errorText ?? 'Please select a choice';
        }
        return null;
      },
      builder: (FormFieldState<String> state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: theme.spacing.inline.xxs,
              ),
              child: Tooltip(
                message: tooltip ?? '',
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    DSText(
                      label,
                      customStyle: TextStyle(
                        fontSize: theme.font.size.xxs,
                        fontWeight: theme.font.weight.medium,
                      ),
                    ),
                    if (tooltip != null) ...[
                      SizedBox(width: theme.spacing.inline.xxxs),
                      const Icon(
                        Icons.info_outline,
                        size: 14,
                      ),
                    ],
                    if (state.hasError)
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: theme.spacing.inline.xxs,
                        ).copyWith(bottom: 2),
                        child: Text(
                          state.errorText ?? '',
                          style: TextStyle(
                            color: theme.colors.feedback.error,
                            fontSize: theme.font.size.xxxs,
                            fontWeight: theme.font.weight.extraLight,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            SizedBox(height: theme.spacing.inline.xxs),
            Wrap(
              spacing: theme.spacing.inline.xxs,
              runSpacing: theme.spacing.inline.xxs,
              children: List.generate(
                choices.length,
                (index) => ChipWidget(
                  isSelected: selectedId == choices[index],
                  label: choices[index],
                  onTap: () {
                    onTap.call(choices[index]);
                    state.didChange(choices[index]);
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
