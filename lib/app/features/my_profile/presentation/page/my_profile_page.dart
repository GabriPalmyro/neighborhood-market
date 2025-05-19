import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neighborhood_market/app/common/design_system/components/fade_switcher/fade_switcher_state_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/snackbar/snackbar_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/common/formatter/phone_number_formatter.dart';
import 'package:neighborhood_market/app/features/main/presentation/widgets/main_page_error_widget.dart';
import 'package:neighborhood_market/app/features/my_profile/presentation/cubit/my_profile_cubit.dart';
import 'package:neighborhood_market/app/features/my_profile/presentation/widgets/my_profile_loading_widget.dart';
import 'package:neighborhood_market/app/features/my_profile/presentation/widgets/my_profile_success_widget.dart';
import 'package:neighborhood_market/app/features/my_profile/presentation/widgets/save_profile/save_profile_button_widget.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _biographyController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    return Scaffold(
      backgroundColor: theme.colors.neutral.light.pure,
      body: BlocConsumer<MyProfileCubit, MyProfileState>(
        listener: (context, state) {
          if (state is MyProfileLoaded) {
            _fullNameController = TextEditingController(text: state.entity.fullName);
            _usernameController = TextEditingController(text: state.entity.username);
            _emailController = TextEditingController(text: state.entity.email);
            _phoneController = TextEditingController(
              text: phoneWithCountryCodeFormatter.maskText(state.entity.phone ?? ''),
            );
            _biographyController = TextEditingController(text: state.entity.biography);

            if (state.isSaved && !state.isError) {
              ScaffoldMessenger.of(context).showSuccessSnackBar(
                context,
                content: 'Profile saved successfully',
              );
            } else if (state.isSaved && state.isError) {
              ScaffoldMessenger.of(context).showErrorSnackBar(
                context,
                content: 'Profile could not be saved',
              );
            }
          }
        },
        builder: (context, state) {
          return FadeSwitcherState<MyProfileState, MyProfileLoaded, MyProfileError, MyProfileLoading>(
            state: state,
            error: (_) => MainPageErrorWidget(
              onRetry: () => context.read<MyProfileCubit>().getMyProfile(),
            ),
            loading: (_) => const MyProfileLoadingWidget(),
            result: (result) {
              return Stack(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: MyProfileSuccessWidget(
                      entity: result.entity,
                      fullNameController: _fullNameController,
                      usernameController: _usernameController,
                      emailController: _emailController,
                      phoneController: _phoneController,
                      biographyController: _biographyController,
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: SaveProfileButtonWidget(
                      onPressed: () {
                        context.read<MyProfileCubit>().saveMyProfile(
                          name: _fullNameController.text,
                          username: _usernameController.text,
                          biography: _biographyController.text,
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
