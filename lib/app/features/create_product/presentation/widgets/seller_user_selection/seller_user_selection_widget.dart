import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:neighborhood_market/app/common/design_system/components/bottom_sheet/bottom_sheet_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/dropdown/dropdown_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/features/create_product/domain/entity/user_search_entity.dart';
import 'package:neighborhood_market/app/features/create_product/presentation/cubit/builder_product_cubit.dart';
import 'package:neighborhood_market/app/features/create_product/presentation/cubit/user_selection/user_selection_cubit.dart';
import 'package:neighborhood_market/app/features/create_product/presentation/widgets/seller_user_selection/user_selection_bottom_sheet.dart';

class SellerUserSelectionWidget extends StatelessWidget {
  const SellerUserSelectionWidget({
    this.seller,
    super.key,
  });
  final UserSearchEntity? seller;

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: theme.spacing.inline.xxs,
          ),
          child: Tooltip(
            message: 'Select the account to which the product will be associated',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                DSText(
                  'Account to which add this listing',
                  customStyle: TextStyle(
                    fontSize: theme.font.size.xxs,
                    fontWeight: theme.font.weight.medium,
                  ),
                ),
                SizedBox(width: theme.spacing.inline.xxxs),
                const Icon(
                  Icons.info_outline,
                  size: 14,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: theme.spacing.inline.xxs),
        DSDropdownWidget(
          label: seller?.name,
          hintText: 'Select...',
          onTap: () {
            showDSBottomSheet(
              context: context,
              isScrollControlled: true,
              child: BlocProvider(
                create: (context) => GetIt.I<UserSelectionCubit>(),
                child: UserSelectionBottomSheet(
                  onSelected: (seller) {
                    context.read<BuilderProductCubit>().updateState(seller: seller);
                  },
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
