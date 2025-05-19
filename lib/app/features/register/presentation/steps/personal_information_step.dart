import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neighborhood_market/app/common/design_system/components/bottom_sheet/bottom_sheet_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/bottom_sheet/error_bottom_sheet_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/button/button_component.dart';
import 'package:neighborhood_market/app/common/design_system/components/button/button_variant.dart';
import 'package:neighborhood_market/app/common/design_system/components/recipies/text_input_label/text_input_label.dart';
import 'package:neighborhood_market/app/common/design_system/components/support/icon/icon_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/support/icons/icons.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/common/extensions/date_extension.dart';
import 'package:neighborhood_market/app/features/register/domain/entity/register_steps_enum.dart';
import 'package:neighborhood_market/app/features/register/presentation/cubit/register/register_cubit.dart';
import 'package:neighborhood_market/app/features/register/presentation/cubit/register/register_state.dart';
import 'package:neighborhood_market/app/features/register/presentation/cubit/register_step/register_steps_cubit.dart';
import 'package:neighborhood_market/app/features/register/presentation/widgets/select_state_bottom_sheet.dart';
import 'package:neighborhood_market/app/features/register/utils/register_string.dart';

class PersonalInformationStep extends StatefulWidget {
  const PersonalInformationStep({super.key});

  @override
  State<PersonalInformationStep> createState() => _PersonalInformationStepState();
}

class _PersonalInformationStepState extends State<PersonalInformationStep> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateOfBirth = TextEditingController();
  final TextEditingController _address1Controller = TextEditingController();
  final TextEditingController _address2Controller = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _zipController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _usernameController.dispose();
    _nameController.dispose();
    _dateOfBirth.dispose();
    _address1Controller.dispose();
    _address2Controller.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: theme.spacing.inline.xs),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: theme.spacing.inline.sm),
              DSText(
                RegisterStrings.personalInfomation,
                customStyle: TextStyle(
                  fontSize: theme.font.size.sm,
                  fontWeight: theme.font.weight.semiBold,
                ),
              ),
              SizedBox(height: theme.spacing.inline.xxxs),
              DSText(
                RegisterStrings.personalInfomationDescription,
                customStyle: TextStyle(
                  fontSize: theme.font.size.xxs,
                  fontWeight: theme.font.weight.regular,
                ),
              ),
              SizedBox(height: theme.spacing.inline.xs),
              TextInputLabelWidget(
                controller: _usernameController,
                label: '@Username',
                tooltip: 'Enter...',
                hintText: 'Enter Username',
                autofillHints: const [AutofillHints.username],
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value?.isEmpty == true) {
                    return 'Username is required';
                  }
                  return null;
                },
              ),
              SizedBox(height: theme.spacing.inline.xs),
              TextInputLabelWidget(
                controller: _nameController,
                label: 'Name',
                tooltip: 'Enter...',
                hintText: 'Enter...',
                autofillHints: const [AutofillHints.name],
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value?.isEmpty == true) {
                    return 'Name is required';
                  }
                  return null;
                },
              ),
              SizedBox(height: theme.spacing.inline.xs),
              TextInputLabelWidget(
                controller: _dateOfBirth,
                label: 'Date of Birth',
                tooltip: 'Select',
                hintText: 'Enter...',
                readOnly: true,
                validator: (value) {
                  if (value?.isEmpty == true) {
                    return 'Date of Birth is required';
                  }
                  return null;
                },
                onTap: () {
                  showDatePicker(
                    context: context,
                    initialDate: _dateOfBirth.text.toDateTimeUSFormat() ?? DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  ).then((selectedDate) {
                    if (selectedDate != null) {
                      _dateOfBirth.text = selectedDate.toUSFormat();
                    }
                  });
                },
                suffixWidget: IconButton(
                  onPressed: null,
                  icon: DSIcon(
                    icon: DSIcons.calendar,
                    size: DSIconSize.sm,
                    color: theme.colors.neutral.light.two,
                  ),
                ),
              ),
              SizedBox(height: theme.spacing.inline.xs),
              TextInputLabelWidget(
                controller: _address1Controller,
                label: 'Address 1',
                tooltip: 'Enter...',
                hintText: 'Enter...',
                autofillHints: const [AutofillHints.fullStreetAddress],
                keyboardType: TextInputType.streetAddress,
                validator: (value) {
                  if (value?.isEmpty == true) {
                    return 'Address 1 is required';
                  }
                  return null;
                },
              ),
              SizedBox(height: theme.spacing.inline.xs),
              TextInputLabelWidget(
                controller: _address2Controller,
                label: 'Address 2',
                tooltip: 'Enter...',
                hintText: 'Enter...',
                autofillHints: const [AutofillHints.streetAddressLevel1],
                keyboardType: TextInputType.streetAddress,
              ),
              SizedBox(height: theme.spacing.inline.xs),
              TextInputLabelWidget(
                controller: _cityController,
                label: 'City',
                tooltip: 'Enter...',
                hintText: 'Enter...',
                autofillHints: const [AutofillHints.addressCity],
                keyboardType: TextInputType.streetAddress,
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
                    flex: 3,
                    child: TextInputLabelWidget(
                      controller: _stateController,
                      label: 'State',
                      tooltip: 'Select your state',
                      hintText: 'Select',
                      readOnly: true,
                      validator: (value) {
                        if (value?.isEmpty == true) {
                          return 'State is required';
                        }
                        return null;
                      },
                      onTap: () {
                        showDSBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          constraints: BoxConstraints(
                            maxHeight: MediaQuery.of(context).size.height * 0.8,
                            minWidth: MediaQuery.of(context).size.width,
                          ),
                          child: SelectStateBottomSheet(
                            onSelected: (state) {
                              _stateController.text = state;
                            },
                          ),
                        );
                      },
                      suffixWidget: IconButton(
                        onPressed: null,
                        icon: DSIcon(
                          icon: DSIcons.chevronDown,
                          size: DSIconSize.md,
                          color: theme.colors.neutral.dark.one,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: theme.spacing.inline.xs),
                  Expanded(
                    flex: 4,
                    child: TextInputLabelWidget(
                      controller: _zipController,
                      keyboardType: TextInputType.number,
                      autofillHints: const [AutofillHints.postalCode],
                      label: 'Zip',
                      tooltip: 'Enter...',
                      hintText: 'Enter...',
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
              SizedBox(height: theme.spacing.inline.sm),
              BlocConsumer<RegisterCubit, RegisterState>(
                listener: (context, state) {
                  if (state is RegisterSuccess) {
                    context.read<RegisterStepsCubit>().changeStep(RegisterStep.stepFour);
                  } else if (state is RegisterFailure) {
                    showDSBottomSheet(
                      context: context,
                      isScrollControlled: false,
                      child: const ErrorBottomSheetWidget(
                        message: 'There was an error, please try again',
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  return DSButton(
                    label: RegisterStrings.continueButton,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<RegisterCubit>().savePersonalInformationStep(
                              username: _usernameController.text.trim(),
                              fullName: _nameController.text.trim(),
                              birthDate: _dateOfBirth.text.toDateTimeUSFormat()?.toUtc().toIso8601String() ?? '',
                              adress1: _address1Controller.text.trim(),
                              adress2: _address2Controller.text.trim(),
                              city: _cityController.text.trim(),
                              state: _stateController.text.trim(),
                              zip: _zipController.text.trim(),
                            );
                      }
                    },
                    isLoading: state is RegisterLoading,
                    size: DSButtonSize.md,
                  );
                },
              ),
              SizedBox(height: theme.spacing.inline.lg),
            ],
          ),
        ),
      ),
    );
  }
}
