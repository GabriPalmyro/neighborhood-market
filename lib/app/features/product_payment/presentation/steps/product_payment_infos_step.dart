import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neighborhood_market/app/common/design_system/components/bottom_sheet/bottom_sheet_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/bottom_sheet/error_bottom_sheet_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/button/button_component.dart';
import 'package:neighborhood_market/app/common/design_system/components/button/button_variant.dart';
import 'package:neighborhood_market/app/common/design_system/components/clickable/clickable_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/divider/divider_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/recipies/text_input_label/text_input_label.dart';
import 'package:neighborhood_market/app/common/design_system/components/shimmer/shimmer_component.dart';
import 'package:neighborhood_market/app/common/design_system/components/snackbar/snackbar_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/support/icon/icon_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/support/icons/icons.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/common/formatter/phone_number_formatter.dart';
import 'package:neighborhood_market/app/core/app_consts.dart';
import 'package:neighborhood_market/app/features/product_payment/presentation/cubit/payment_step/product_payment_steps_cubit.dart';
import 'package:neighborhood_market/app/features/product_payment/presentation/cubit/product_order/product_payment_order_cubit.dart';
import 'package:neighborhood_market/app/features/product_payment/presentation/cubit/purchase/purchase_cubit.dart';
import 'package:neighborhood_market/app/features/product_payment/presentation/cubit/shipping_infos/shipping_infos_cubit.dart';
import 'package:neighborhood_market/app/features/product_payment/presentation/widgets/payment_resume/payment_resume_widget.dart';
import 'package:neighborhood_market/app/features/product_payment/presentation/widgets/select_shipping_method/select_shipping_method.dart';
import 'package:neighborhood_market/app/features/product_payment/utils/product_payment_strings.dart';
import 'package:neighborhood_market/app/features/register/presentation/widgets/select_state_bottom_sheet.dart';
import 'package:neighborhood_market/app/utils/errors/payment_exceptions.dart';

class ProductPaymentInfosStep extends StatefulWidget {
  const ProductPaymentInfosStep({super.key});

  @override
  State<ProductPaymentInfosStep> createState() => _ProductPaymentInfosStepState();
}

class _ProductPaymentInfosStepState extends State<ProductPaymentInfosStep> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();

  bool isWarningOfShippingAddressShown = false;

  bool notReturnableChecked = false;
  bool understandClassifiedChecked = false;

  void _clickOnEdit() {
    ScaffoldMessenger.of(context).showInfoSnackBar(
      context,
      content: 'Click on the edit button to change the shipping address',
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    return BlocBuilder<ProductPaymentOrderCubit, ProductPaymentOrderState>(
      builder: (context, state) {
        state as ProductPaymentOrderLoaded;
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: theme.spacing.inline.xs,
          ),
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocConsumer<ShippingInfosCubit, ShippingInfosState>(
                    listener: (context, state) {
                      if (state is ShippingInfosLoaded) {
                        if (state.shippingInfos.isValid) {
                          _formKey.currentState?.validate();
                        } else if (!isWarningOfShippingAddressShown) {
                          ScaffoldMessenger.of(context).showInfoSnackBar(
                            context,
                            content: 'Please fill the shipping address',
                          );
                          setState(() => isWarningOfShippingAddressShown = true);
                        }
                      }
                    },
                    builder: (context, state) {
                      if (state is ShippingInfosInitial || state is ShippingInfosLoading) {
                        return Padding(
                          padding: EdgeInsets.only(
                            top: theme.spacing.inline.xs,
                          ),
                          child: Column(
                            children: List.generate(
                              6,
                              (index) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                    bottom: theme.spacing.inline.xs,
                                  ),
                                  child: const ShimmerComponent(
                                    width: double.infinity,
                                    height: 55.0,
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      }

                      state as ShippingInfosLoaded;
                      return Column(
                        children: [
                          SizedBox(height: theme.spacing.inline.xs),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              DSText(
                                'Shipping Address',
                                customStyle: TextStyle(
                                  fontSize: theme.font.size.xs,
                                  fontWeight: theme.font.weight.semiBold,
                                ),
                              ),
                              ClickableWidget(
                                borderRadius: BorderRadius.circular(theme.borders.radius.medium),
                                onTap: () {
                                  context.read<ShippingInfosCubit>().changeEditState();
                                },
                                padding: EdgeInsets.symmetric(
                                  horizontal: theme.spacing.inline.xxs,
                                  vertical: theme.spacing.inline.xxxs,
                                ),
                                child: DSText(
                                  state.enableEditing ? 'Save' : 'Edit',
                                  customStyle: TextStyle(
                                    fontSize: theme.font.size.xxs,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: theme.spacing.inline.xs),
                          TextInputLabelWidget(
                            controller: context.read<ShippingInfosCubit>().fullNameController,
                            label: 'Full Name',
                            hintText: 'John Doe',
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            autofillHints: const [AutofillHints.name],
                            enabled: state.enableEditing,
                            onTap: () {
                              if (!state.enableEditing) {
                                _clickOnEdit();
                              }
                            },
                            validator: (value) {
                              if (value?.isEmpty == true) {
                                return 'Name is required';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: theme.spacing.inline.xs),
                          TextInputLabelWidget(
                            controller: context.read<ShippingInfosCubit>().phoneNumberController,
                            label: 'Phone',
                            hintText: '+1 (512) 555-1234',
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.phone,
                            formatter: phoneWithCountryCodeFormatter,
                            autofillHints: const [AutofillHints.telephoneNumber],
                            enabled: state.enableEditing,
                            onTap: () {
                              if (!state.enableEditing) {
                                _clickOnEdit();
                              }
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'The phone number field cannot be empty';
                              } else if (value.length < AppConsts.maxPhoneNumberCharacters) {
                                return 'The phone number must be at least ${AppConsts.maxPhoneNumberCharacters} characters long';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: theme.spacing.inline.xs),
                          TextInputLabelWidget(
                            controller: context.read<ShippingInfosCubit>().addressController,
                            label: 'Address 1',
                            hintText: '1234 Main St',
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.streetAddress,
                            autofillHints: const [AutofillHints.streetAddressLine1],
                            enabled: state.enableEditing,
                            onTap: () {
                              if (!state.enableEditing) {
                                _clickOnEdit();
                              }
                            },
                            validator: (value) {
                              if (value?.isEmpty == true) {
                                return 'Address 1 is required';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: theme.spacing.inline.xs),
                          TextInputLabelWidget(
                            controller: context.read<ShippingInfosCubit>().address2Controller,
                            label: 'Address 2',
                            hintText: 'Apt 123',
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.streetAddress,
                            enabled: state.enableEditing,
                            onTap: () {
                              if (!state.enableEditing) {
                                _clickOnEdit();
                              }
                            },
                          ),
                          SizedBox(height: theme.spacing.inline.xs),
                          TextInputLabelWidget(
                            controller: context.read<ShippingInfosCubit>().cityController,
                            label: 'City',
                            hintText: 'Austin',
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            autofillHints: const [AutofillHints.addressCity],
                            enabled: state.enableEditing,
                            onTap: () {
                              if (!state.enableEditing) {
                                _clickOnEdit();
                              }
                            },
                            validator: (value) {
                              if (value?.isEmpty == true) {
                                return 'City is required';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: theme.spacing.inline.xs),
                          Row(
                            children: [
                              Expanded(
                                child: TextInputLabelWidget(
                                  controller: context.read<ShippingInfosCubit>().stateController,
                                  label: 'State',
                                  hintText: 'State',
                                  enabled: state.enableEditing,
                                  readOnly: true,
                                  onTap: () {
                                    if (state.enableEditing) {
                                      showDSBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        constraints: BoxConstraints(
                                          maxHeight: MediaQuery.of(context).size.height * 0.8,
                                          minWidth: MediaQuery.of(context).size.width,
                                        ),
                                        child: SelectStateBottomSheet(
                                          onSelected: (state) {
                                            context.read<ShippingInfosCubit>().stateController.text = state;
                                          },
                                        ),
                                      );
                                    }
                                  },
                                  suffixWidget: state.enableEditing
                                      ? IconButton(
                                          onPressed: null,
                                          icon: DSIcon(
                                            icon: DSIcons.chevronDown,
                                            size: DSIconSize.md,
                                            color: theme.colors.neutral.dark.one,
                                          ),
                                        )
                                      : null,
                                  validator: (value) {
                                    if (value?.isEmpty == true) {
                                      return 'State is required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(width: theme.spacing.inline.xs),
                              Expanded(
                                child: TextInputLabelWidget(
                                  controller: context.read<ShippingInfosCubit>().zipCodeController,
                                  label: 'Zip',
                                  hintText: '78701',
                                  textInputAction: TextInputAction.done,
                                  keyboardType: TextInputType.number,
                                  autofillHints: const [AutofillHints.postalCode],
                                  enabled: state.enableEditing,
                                  onTap: () {
                                    if (!state.enableEditing) {
                                      _clickOnEdit();
                                    }
                                  },
                                  validator: (value) {
                                    if (value?.isEmpty == true) {
                                      return 'Zip is required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                  SizedBox(height: theme.spacing.inline.xs),
                  const ThemeDividerWidget(),
                  SizedBox(height: theme.spacing.inline.xs),
                  SelectShippingMethodWidget(
                    scrollController: _scrollController,
                  ),
                  SizedBox(height: theme.spacing.inline.xs),
                  const ThemeDividerWidget(),
                  SizedBox(height: theme.spacing.inline.xs),
                  const PaymentResumeWidget(),
                  SizedBox(height: theme.spacing.inline.sm),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                        value: notReturnableChecked,
                        side: BorderSide(
                          color: notReturnableChecked ? theme.colors.feedback.error : theme.colors.neutral.dark.two,
                          width: theme.borderWidth.thin,
                        ),
                        activeColor: theme.colors.neutral.dark.two,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                          side: BorderSide(
                            color: theme.colors.neutral.light.three,
                          ),
                        ),
                        onChanged: (_) {
                          HapticFeedback.lightImpact();
                          setState(() {
                            notReturnableChecked = !notReturnableChecked;
                          });

                          if (understandClassifiedChecked && notReturnableChecked) {
                            _scrollController.animateTo(
                              _scrollController.position.maxScrollExtent,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeOut,
                            );
                          }
                        },
                      ),
                      Expanded(
                        child: DSText(
                          ProductPaymentStrings.purchaseNotRefundable,
                          customStyle: TextStyle(
                            color: theme.colors.neutral.dark.three,
                            fontSize: theme.font.size.xxs,
                            fontWeight: theme.font.weight.medium,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: theme.spacing.inline.sm),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                        value: understandClassifiedChecked,
                        side: BorderSide(
                          color: understandClassifiedChecked ? theme.colors.feedback.error : theme.colors.neutral.dark.two,
                          width: theme.borderWidth.thin,
                        ),
                        activeColor: theme.colors.neutral.dark.two,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                          side: BorderSide(
                            color: theme.colors.neutral.light.three,
                          ),
                        ),
                        onChanged: (_) {
                          HapticFeedback.lightImpact();
                          setState(() {
                            understandClassifiedChecked = !understandClassifiedChecked;
                          });

                          if (understandClassifiedChecked && notReturnableChecked) {
                            _scrollController.animateTo(
                              _scrollController.position.maxScrollExtent,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeOut,
                            );
                          }
                        },
                      ),
                      Expanded(
                        child: DSText(
                          ProductPaymentStrings.notResponsableForItems,
                          customStyle: TextStyle(
                            color: theme.colors.neutral.dark.three,
                            fontSize: theme.font.size.xxs,
                            fontWeight: theme.font.weight.medium,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: theme.spacing.inline.sm),
                  BlocConsumer<PurchaseCubit, PurchaseState>(
                    listener: (context, purchaseState) {
                      switch (purchaseState.runtimeType) {
                        case const (PaymentConfirmed):
                          context.read<ProductPaymentStepsCubit>().nextStep();
                          break;
                        case const (PaymentIntentSuccess):
                          purchaseState as PaymentIntentSuccess;
                          final paymentIntent = purchaseState.paymentData;
                          context.read<PurchaseCubit>().confirmPayment(
                                clientSecret: paymentIntent.clientSecret,
                                delivery: state.shippingMethod,
                                product: state.entity.copyWith(price: state.price),
                              );
                          break;
                        case const (PurchaseError):
                          purchaseState as PurchaseError;

                          if (purchaseState.exception is PaymentDialogDismissed) {
                            ScaffoldMessenger.of(context).showErrorSnackBar(
                              context,
                              content: 'The payment flow has been canceled',
                            );
                            return;
                          }

                          showDSBottomSheet(
                            context: context,
                            isScrollControlled: false,
                            child: ErrorBottomSheetWidget(
                              message: purchaseState.exception.toString(),
                            ),
                          );
                          break;
                      }
                    },
                    builder: (context, purchaseState) {
                      return DSButton(
                        label: 'Continue',
                        isLoading: purchaseState is PurchaseLoading,
                        size: DSButtonSize.md,
                        type: !notReturnableChecked || !understandClassifiedChecked ? DSButtonType.ghost : DSButtonType.primary,
                        onPressed: () {
                          if (!notReturnableChecked || !understandClassifiedChecked) {
                            ScaffoldMessenger.of(context).showErrorSnackBar(
                              context,
                              content: 'You must agree to the terms and conditions',
                            );
                            return;
                          }

                          if (context.read<ShippingInfosCubit>().state.runtimeType != ShippingInfosLoaded) {
                            ScaffoldMessenger.of(context).showErrorSnackBar(
                              context,
                              content: 'Please fill the shipping address',
                            );
                          }

                          if (state.shippingMethod == null) {
                            ScaffoldMessenger.of(context).showErrorSnackBar(
                              context,
                              content: 'Please select a shipping method',
                            );
                          }

                          if (state.entity.id?.isEmpty == true) {
                            ScaffoldMessenger.of(context).showErrorSnackBar(
                              context,
                              content: 'There are some problems with the product. Please try again later',
                            );
                          }

                          context.read<PurchaseCubit>().getPaymentIntent(
                                productId: state.entity.id!,
                                address1: context.read<ShippingInfosCubit>().addressController.text,
                                address2: context.read<ShippingInfosCubit>().address2Controller.text,
                                city: context.read<ShippingInfosCubit>().cityController.text,
                                fullName: context.read<ShippingInfosCubit>().fullNameController.text,
                                state: context.read<ShippingInfosCubit>().stateController.text,
                                zip: context.read<ShippingInfosCubit>().zipCodeController.text,
                                type: state.purchaseType,
                                deliveryType: state.shippingMethod!.type,
                                offerId: state.offerId,
                              );
                        },
                      );
                    },
                  ),
                  SizedBox(height: theme.spacing.inline.md),
                  SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
