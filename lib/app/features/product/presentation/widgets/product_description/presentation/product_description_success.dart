import 'package:flutter/material.dart';
import 'package:neighborhood_market/app/common/design_system/components/clickable/clickable_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';

class ProductDescriptionSuccess extends StatefulWidget {
  const ProductDescriptionSuccess({
    required this.description,
    super.key,
  });

  final String description;

  @override
  ProductDescriptionSuccessState createState() => ProductDescriptionSuccessState();
}

class ProductDescriptionSuccessState extends State<ProductDescriptionSuccess> {
  bool _isExpanded = false;
  bool _isOverflowing = false;

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    final textStyle = TextStyle(
      color: theme.colors.neutral.dark.three,
      fontSize: theme.font.size.xs,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final textSpan = TextSpan(text: widget.description, style: textStyle);
        final textPainter = TextPainter(
          text: textSpan,
          maxLines: 3,
          textDirection: TextDirection.ltr,
        );
        textPainter.layout(maxWidth: constraints.maxWidth);
        _isOverflowing = textPainter.didExceedMaxLines;

        return ClickableWidget(
          borderRadius: BorderRadius.circular(
            theme.borders.radius.medium,
          ),
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          padding: EdgeInsets.symmetric(
            vertical: theme.spacing.inline.xxxs,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DSText(
                'Description',
                customStyle: TextStyle(
                  color: theme.colors.neutral.dark.pure,
                  fontSize: theme.font.size.xs,
                  fontWeight: theme.font.weight.bold,
                ),
              ),
              SizedBox(height: theme.spacing.inline.xxs),
              DSText(
                widget.description,
                customStyle: textStyle,
                maxLines: _isExpanded ? null : 3,
                overflow: _isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
              ),
              if (_isOverflowing) ...[
                SizedBox(height: theme.spacing.inline.xxs),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DSText(
                      _isExpanded ? 'See less' : 'See full description',
                      customStyle: TextStyle(
                        color: theme.colors.neutral.dark.pure,
                        fontSize: theme.font.size.xs,
                        fontWeight: theme.font.weight.bold,
                      ),
                    ),
                    Icon(
                      _isExpanded ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
                      color: theme.colors.neutral.dark.pure,
                      size: theme.font.size.xs,
                    ),
                  ],
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
