import 'dart:async';

import 'package:flutter/material.dart';
import 'package:neighborhood_market/app/common/design_system/components/bottom_sheet/bottom_sheet_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/button/button_component.dart';
import 'package:neighborhood_market/app/common/design_system/components/button/button_variant.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/common/extensions/date_extension.dart';
import 'package:neighborhood_market/app/common/extensions/time_extension.dart';
import 'package:neighborhood_market/app/common/router/app_navigator.dart';
import 'package:neighborhood_market/app/common/router/routes.dart';
import 'package:neighborhood_market/app/features/notifications/domain/entities/notification_entity.dart';
import 'package:neighborhood_market/app/features/product/presentation/widgets/product_action_button/presentation/widgets/count_offer_response_bottom_sheet.dart';
import 'package:neighborhood_market/app/features/product/presentation/widgets/product_action_button/presentation/widgets/offer_response_bottom_sheet.dart';

class NotificationCardWidget extends StatefulWidget {
  const NotificationCardWidget({
    required this.entity,
    required this.appNavigator,
    super.key,
  });

  final NotificationEntity entity;
  final AppNavigator appNavigator;

  @override
  State<NotificationCardWidget> createState() => _NotificationCardWidgetState();
}

class _NotificationCardWidgetState extends State<NotificationCardWidget> with AutomaticKeepAliveClientMixin {
  late int remainingSeconds;
  Timer? _timer;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    remainingSeconds = widget.entity.remainingSeconds ?? 0;
    if (remainingSeconds > 0) {
      _startTimer();
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      if (remainingSeconds > 0) {
        setState(() {
          remainingSeconds -= 60;
        });
      } else {
        _timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  bool directToProduct(NotificationActionType? type) {
    return type == NotificationActionType.ongoingOffer ||
        type == NotificationActionType.counterOfferSent ||
        type == NotificationActionType.offerDenied ||
        type == NotificationActionType.newItem;
  }

  void _onTap() {
    if (widget.entity.isRead) {
      return;
    }

    if (widget.entity.type != null) {

      if (directToProduct(widget.entity.type)) {
          widget.appNavigator.pushRoute(
            Routes.product,
            queryParameters: {
              'id': widget.entity.data?.itemId ?? '-1',
            },
          );
          return;
      }

      switch (widget.entity.type) {
        case NotificationActionType.offerAccepted:
          widget.appNavigator.pushRoute(
            Routes.productPayment,
            queryParameters: {
              'productId': widget.entity.data?.itemId ?? '-1',
              'purchaseType': 'offer',
              'offerId': widget.entity.data?.offerId ?? '-1',
              'productOfferPrice': widget.entity.data?.offerPrice?.toStringAsFixed(2) ?? '0.0',
            },
          );
          break;
        case NotificationActionType.offerReceived:
          showDSBottomSheet(
            context: context,
            isScrollControlled: true,
            child: OfferResponseBottomSheet(
              offerId: widget.entity.data?.offerId ?? '-1',
              itemId: widget.entity.data?.itemId ?? '-1',
              itemName: widget.entity.data?.itemName ?? '',
              offerPrice: widget.entity.data?.offerPrice ?? 0.0,
            ),
          );
          break;
        case NotificationActionType.counterOfferReceived:
          showDSBottomSheet(
            context: context,
            isScrollControlled: true,
            child: CountOfferResponseBottomSheet(
              appNavigator: widget.appNavigator,
              offerId: widget.entity.data?.offerId ?? '-1',
              itemId: widget.entity.data?.itemId ?? '-1',
              itemName: widget.entity.data?.itemName ?? '',
              counterOfferPrice: widget.entity.data?.offerPrice ?? 0.0,
            ),
          );
          break;
        case NotificationActionType.itemDelivered:
          widget.appNavigator.pushRoute(
            Routes.myPurchaseDetails,
            queryParameters: {
              'purchaseId': widget.entity.data?.itemId ?? '-1',
            },
          );
        default:
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final tokens = DSTheme.getDesignTokensOf(context);
    final showButton = widget.entity.type != null && widget.entity.type == NotificationActionType.offerAccepted;
    return GestureDetector(
      onTap: _onTap,
      child: Stack(
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: tokens.colors.neutral.light.pure,
              borderRadius: BorderRadius.circular(tokens.borders.radius.medium),
              border: Border.all(
                color: tokens.colors.neutral.light.one,
                width: tokens.borderWidth.thin,
              ),
              boxShadow: [
                BoxShadow(
                  color: tokens.colors.neutral.dark.pure.withValues(alpha: 0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            padding: EdgeInsets.symmetric(
              horizontal: tokens.spacing.inline.xxs,
              vertical: tokens.spacing.inline.xxs,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DSText(
                  widget.entity.title,
                  customStyle: TextStyle(
                    fontWeight: tokens.font.weight.medium,
                    fontSize: tokens.font.size.xxs,
                  ),
                ),
                SizedBox(height: tokens.spacing.inline.xxxs),
                DSText(
                  widget.entity.message,
                  customStyle: TextStyle(
                    color: tokens.colors.neutral.dark.icon,
                    fontSize: tokens.font.size.xxxs,
                  ),
                ),
                SizedBox(height: tokens.spacing.inline.xxs),
                if (widget.entity.remainingSeconds != null) ...[
                  DSText(
                    remainingSeconds.formatSecondsToHHMM(),
                    customStyle: TextStyle(
                      color: tokens.colors.neutral.dark.icon,
                      fontSize: tokens.font.size.sm,
                    ),
                  ),
                  SizedBox(height: tokens.spacing.inline.xxs),
                ],
                if (showButton) ...[
                  DSButton(
                    label: 'Finalize your order.',
                    size: DSButtonSize.sm,
                    onPressed: _onTap,
                  ),
                  SizedBox(height: tokens.spacing.inline.xxs),
                ],
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DSText(
                      widget.entity.date.toStringDate(),
                      customStyle: TextStyle(
                        fontSize: tokens.font.size.us,
                        color: tokens.colors.neutral.dark.icon,
                      ),
                    ),
                    DSText(
                      widget.entity.date.toTime(),
                      customStyle: TextStyle(
                        fontSize: tokens.font.size.us,
                        color: tokens.colors.neutral.dark.icon,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (!widget.entity.isRead)
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: tokens.colors.feedback.error,
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
