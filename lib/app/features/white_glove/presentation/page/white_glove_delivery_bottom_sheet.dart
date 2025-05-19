import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neighborhood_market/app/common/design_system/components/button/button_component.dart';
import 'package:neighborhood_market/app/common/design_system/components/button/button_variant.dart';
import 'package:neighborhood_market/app/common/design_system/components/divider/divider_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/snackbar/snackbar_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/features/white_glove/presentation/cubit/white_glove_cubit.dart';
import 'package:neighborhood_market/app/features/white_glove/presentation/widgets/white_glove_componente_widget.dart';

class WhiteGloveDeliveryBottomSheet extends StatefulWidget {
  const WhiteGloveDeliveryBottomSheet({super.key});

  @override
  State<WhiteGloveDeliveryBottomSheet> createState() => _WhiteGloveDeliveryBottomSheetState();
}

class _WhiteGloveDeliveryBottomSheetState extends State<WhiteGloveDeliveryBottomSheet> {
  final ScrollController _scrollController = ScrollController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    return BlocConsumer<WhiteGloveCubit, WhiteGloveState>(
      listener: (context, state) {
        if (state.status == WhiteGloveStatus.loaded) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSuccessSnackBar(
            context,
            content: 'White Glove service requested successfully',
          );
        } else if (state.status == WhiteGloveStatus.error) {
          ScaffoldMessenger.of(context).showErrorSnackBar(
            context,
            content: 'An error occurred while requesting the White Glove service',
          );
        }
      },
      builder: (context, state) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 450),
          curve: Curves.easeInOutQuad,
          height: state.items.length > 1
              ? MediaQuery.of(context).size.height * 0.92 + MediaQuery.of(context).viewInsets.top
              : MediaQuery.of(context).size.height * 0.61 + MediaQuery.of(context).viewInsets.bottom,
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              theme.spacing.inline.xs,
              theme.spacing.inline.xs,
              theme.spacing.inline.xs,
              MediaQuery.of(context).viewInsets.bottom + theme.spacing.inline.xs,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: state.items.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(
                            bottom: index == state.items.length - 1 ? 0 : theme.spacing.inline.xs,
                          ),
                          child: WhiteGloveComponenteWidget(
                            index: index,
                            whiteGloveItem: state.items[index],
                            isLoading: state.status == WhiteGloveStatus.loading,
                            onUpdate: (item) {
                              context.read<WhiteGloveCubit>().updateItem(item, index);
                            },
                            onRemove: () {
                              context.read<WhiteGloveCubit>().removeItem(index);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  if (state.items.length < 10) ...[
                    Row(
                      children: [
                        const Expanded(child: ThemeDividerWidget()),
                        SizedBox(width: theme.spacing.inline.xxs),
                        Expanded(
                          child: DSButton(
                            label: 'Add New Item',
                            onPressed: () {
                              context.read<WhiteGloveCubit>().addItem();
                              Future.delayed(
                                const Duration(milliseconds: 200),
                                () => _scrollController.animateTo(
                                  _scrollController.position.maxScrollExtent,
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.easeInOut,
                                ),
                              );
                            },
                            type: DSButtonType.primaryOutline,
                          ),
                        ),
                        SizedBox(width: theme.spacing.inline.xxs),
                        const Expanded(child: ThemeDividerWidget()),
                      ],
                    ),
                  ],
                  SizedBox(height: theme.spacing.inline.xs),
                  Row(
                    children: [
                      Expanded(
                        child: DSButton(
                          label: 'Cancel',
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          type: DSButtonType.primaryOutline,
                        ),
                      ),
                      SizedBox(width: theme.spacing.inline.xs),
                      Expanded(
                        child: DSButton(
                          label: 'Request Service',
                          isLoading: state.status == WhiteGloveStatus.loading,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<WhiteGloveCubit>().requestWhiteGlove();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: theme.spacing.inline.sm),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
