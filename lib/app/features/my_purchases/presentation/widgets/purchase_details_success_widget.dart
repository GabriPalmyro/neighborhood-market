import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:neighborhood_market/app/common/design_system/components/bottom_sheet/bottom_sheet_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/feedback/success_feedback_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/common/router/app_navigator.dart';
import 'package:neighborhood_market/app/common/router/routes.dart';
import 'package:neighborhood_market/app/features/my_purchases/domain/entities/purchase_details_entity.dart';
import 'package:neighborhood_market/app/features/my_purchases/domain/entities/purchase_status_enum.dart';
import 'package:neighborhood_market/app/features/my_purchases/presentation/cubit/purchase_details_cubit.dart';
import 'package:neighborhood_market/app/features/my_purchases/presentation/widgets/delivery_card/delivery_card_success_widget.dart';
import 'package:neighborhood_market/app/features/my_purchases/presentation/widgets/order_card/order_card_success_widget.dart';
import 'package:neighborhood_market/app/features/my_purchases/presentation/widgets/review_product/review_product_bottom_sheet.dart';
import 'package:neighborhood_market/app/features/my_purchases/utils/my_purchases_strings.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PurchaseDetailsSuccessWidget extends StatefulWidget {
  const PurchaseDetailsSuccessWidget({
    required this.purchaseId,
    required this.purchaseDetails,
    super.key,
  });

  final String purchaseId;
  final PurchaseDetailsEntity purchaseDetails;

  @override
  State<PurchaseDetailsSuccessWidget> createState() => _PurchaseDetailsSuccessWidgetState();
}

class _PurchaseDetailsSuccessWidgetState extends State<PurchaseDetailsSuccessWidget> {
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: theme.spacing.inline.xs,
      ),
      child: SmartRefresher(
        controller: _refreshController,
        onRefresh: () async {
          await context.read<PurchaseDetailsCubit>().loadPurchaseDetails(
                widget.purchaseId,
              );
          _refreshController.refreshCompleted();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (widget.purchaseDetails.status == PurchaseStatusEnum.delivered) ...[
                SizedBox(height: theme.spacing.inline.sm),
                SuccessFeedbackWidget(
                  title: MyPurchasesStrings.deliverySuccessfully,
                  subtitle: MyPurchasesStrings.deliverySubtitle(
                    widget.purchaseDetails.order.product.title ?? '',
                  ),
                  buttonLabel: widget.purchaseDetails.hasBeenReviewed ? MyPurchasesStrings.sellerReviews : MyPurchasesStrings.review,
                  onButtonPressed: () {
                    if (widget.purchaseDetails.hasBeenReviewed) {
                      GetIt.I.get<AppNavigator>().pushRoute(
                        Routes.sellerReviews,
                        queryParameters: {
                          'sellerId': widget.purchaseDetails.sellerId ?? '-1',
                        },
                      );
                    } else {
                      showDSBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        child: ReviewProductBottomSheet(
                          onReviewSent: () {
                            context.read<PurchaseDetailsCubit>().changeReviewStatus();
                          },
                          sellerId: widget.purchaseDetails.sellerId ?? '',
                          productId: widget.purchaseDetails.order.product.id ?? '',
                          productName: widget.purchaseDetails.order.product.title ?? '',
                        ),
                      );
                    }
                  },
                ),
              ],
              SizedBox(height: theme.spacing.inline.sm),
              OrderCardSuccessWidget(
                order: widget.purchaseDetails.order,
              ),
              SizedBox(height: theme.spacing.inline.sm),
              DeliveryCardSuccessWidget(
                deliveryItems: widget.purchaseDetails.deliveryItems,
              ),
              SizedBox(height: theme.spacing.inline.sm),
            ],
          ),
        ),
      ),
    );
  }
}
