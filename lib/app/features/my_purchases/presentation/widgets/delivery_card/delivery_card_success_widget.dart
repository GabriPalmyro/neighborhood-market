import 'package:flutter/material.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/features/my_purchases/domain/entities/purchase_delivery_item_entity.dart';

class DeliveryCardSuccessWidget extends StatelessWidget {
  const DeliveryCardSuccessWidget({required this.deliveryItems, super.key});

  final List<PurchaseDeliveryItemEntity> deliveryItems;

  bool isEdgeIndex(int index) {
    return index == 0 || index == deliveryItems.length + 1;
  }

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    return SizedBox(
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: theme.colors.neutral.light.pure,
          borderRadius: BorderRadius.circular(theme.borders.radius.large),
          boxShadow: [
            BoxShadow(
              color: theme.colors.neutral.dark.pure.withValues(alpha: 0.1),
              blurRadius: 4,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(theme.spacing.inline.xs),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const DSText(
                'Delivery',
              ),
              SizedBox(height: theme.spacing.inline.sm),
              DeliveryTimeline(
                steps: deliveryItems,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DeliveryTimeline extends StatelessWidget {
  const DeliveryTimeline({required this.steps, super.key});
  final List<PurchaseDeliveryItemEntity> steps;

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    return Column(
      children: List.generate(
        steps.length,
        (index) {
          final step = steps[index];
          final isFirstStep = index == 0;
          final isLastStep = index == steps.length - 1;

          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFD9E6FA),
                    ),
                    padding: const EdgeInsets.all(9),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isFirstStep ? theme.colors.brand.secondary : theme.colors.neutral.dark.pure,
                      ),
                    ),
                  ),
                  if (!isLastStep) ...[
                    Container(
                      width: 2,
                      height: 25,
                      color: const Color(0xFFD9E6FA),
                    ),
                  ],
                ],
              ),
              const SizedBox(width: 10),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: DSText(
                  step.title,
                  customStyle: TextStyle(
                    fontSize: theme.font.size.xxs,
                    fontWeight: theme.font.weight.semiBold,
                    color: theme.colors.brand.primary,
                  ),
                ),
              ),
              const Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  DSText(
                    step.time,
                    customStyle: TextStyle(
                      fontWeight: theme.font.weight.medium,
                      color: theme.colors.neutral.dark.icon,
                      fontSize: theme.font.size.us,
                    ),
                  ),
                  DSText(
                    step.date,
                    customStyle: TextStyle(
                      fontWeight: theme.font.weight.medium,
                      color: theme.colors.neutral.dark.icon,
                      fontSize: theme.font.size.us,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
