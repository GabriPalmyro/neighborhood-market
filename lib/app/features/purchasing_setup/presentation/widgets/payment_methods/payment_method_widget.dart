import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neighborhood_market/app/common/design_system/components/card/card_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/recipies/list_item/list_item_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/features/purchasing_setup/domain/entities/payment_method_entity.dart';
import 'package:neighborhood_market/app/features/purchasing_setup/presentation/cubit/purchasing_setup_cubit.dart';

class PaymentMethodWidget extends StatelessWidget {
  const PaymentMethodWidget({
    required this.entity,
    super.key,
  });

  final PaymentMethodEntity entity;

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    return ThemeCardWidget(
      borderRadius: BorderRadius.circular(
        theme.borders.radius.medium,
      ),
      child: Padding(
        padding: EdgeInsets.all(
          theme.spacing.inline.xxs,
        ),
        child: ListItemWidget(
          title: entity.name,
          subtitle: entity.description,
          leading: Transform.scale(
            scale: 0.8,
            child: CupertinoSwitch(
              activeTrackColor: theme.colors.brand.secondary,
              value: entity.isEnabled,
              onChanged: (value) {
                context.read<PurchasingSetupCubit>().changePaymentMethodStatus(
                      entity.id,
                    );
              },
            ),
          ),
        ),
      ),
    );
  }
}
