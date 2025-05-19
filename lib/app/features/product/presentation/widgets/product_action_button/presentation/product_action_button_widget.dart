import 'package:flutter/material.dart';
import 'package:neighborhood_market/app/common/design_system/components/bottom_sheet/bottom_sheet_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/bottom_sheet/error_bottom_sheet_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/button/button_component.dart';
import 'package:neighborhood_market/app/common/design_system/components/button/button_variant.dart';
import 'package:neighborhood_market/app/common/design_system/components/support/icon/icon_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/support/icons/icons.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/common/router/app_navigator.dart';
import 'package:neighborhood_market/app/common/router/routes.dart';
import 'package:neighborhood_market/app/features/product/domain/entities/action_button_type.dart';
import 'package:neighborhood_market/app/features/product/presentation/widgets/product_action_button/presentation/widgets/make_offer_bottom_sheet.dart';
import 'package:neighborhood_market/app/features/product/utils/product_strings.dart';

class ProductActionButtonWidget extends StatelessWidget {
  const ProductActionButtonWidget({
    required this.productId,
    required this.actionType,
    required this.appNavigator,
    super.key,
  });

  final String productId;
  final ActionButtonType actionType;
  final AppNavigator appNavigator;

  DSButtonType get _getButtonType {
    if (actionType == ActionButtonType.offerAvailable) {
      return DSButtonType.secondaryOutline;
    } else if (actionType == ActionButtonType.countOfferAvailable) {
      return DSButtonType.secondaryOutline;
    }
    return DSButtonType.ghost;
  }

  bool showBuyButton() {
    return actionType == ActionButtonType.offerAvailable;
  }

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    return Container(
      width: double.infinity,
      color: theme.colors.neutral.light.pure,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          theme.spacing.inline.sm,
          theme.spacing.inline.xs,
          theme.spacing.inline.sm,
          theme.spacing.inline.xs + MediaQuery.of(context).padding.bottom,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: theme.spacing.inline.xxxs,
          ),
          child: Column(
            children: [
              if (actionType == ActionButtonType.offerSubmitted) ...[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(theme.borders.radius.medium),
                    color: const Color(0xFFFFF6E7),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: theme.spacing.inline.xxs,
                    vertical: theme.spacing.inline.xxs,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: theme.spacing.inline.xxxs),
                        child: const DSIcon(
                          icon: DSIcons.info,
                          color: Color(0xFFEC980C),
                          size: DSIconSize.sm,
                        ),
                      ),
                      SizedBox(width: theme.spacing.inline.xxs),
                      Expanded(
                        child: DSText(
                          ProductStrings.offerSubmittedMessage,
                          customStyle: TextStyle(
                            color: const Color(0xFF9D6508),
                            fontSize: theme.font.size.xxxs,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: theme.spacing.inline.xxs),
              ],
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (showBuyButton()) ...[
                    Expanded(
                      child: DSButton(
                        onPressed: () {
                          appNavigator.pushRoute(
                            Routes.productPayment,
                            queryParameters: {
                              'productId': productId,
                              'purchaseType': 'buy',
                            },
                          );
                        },
                        type: DSButtonType.secondary,
                        size: DSButtonSize.sm,
                        label: ProductStrings.buyLabel,
                      ),
                    ),
                    SizedBox(width: theme.spacing.inline.xs),
                  ],
                  Expanded(
                    child: DSButton(
                      onPressed: () {
                        if (actionType == ActionButtonType.offerAccepted || actionType == ActionButtonType.countOfferAccepted) {
                          return;
                        }

                        if (actionType == ActionButtonType.offerAvailable) {
                          showDSBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            child: MakeOfferBottomSheet(
                              productId: productId,
                            ),
                          );
                        } else if (actionType == ActionButtonType.countOfferAvailable) {
                          showDSBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            child: const ErrorBottomSheetWidget(
                              message: ProductStrings.counterOfferNotAvailable,
                            ),
                          );
                        }
                      },
                      type: _getButtonType,
                      size: DSButtonSize.sm,
                      label: actionType.label,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
