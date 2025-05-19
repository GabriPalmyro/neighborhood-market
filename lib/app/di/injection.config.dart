// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:neighborhood_market/app/common/auth/auth_service.dart'
    as _i1007;
import 'package:neighborhood_market/app/common/component_builder/di/component_builder_module.dart'
    as _i124;
import 'package:neighborhood_market/app/common/component_builder/presentation/adapter/component_content_adapter_builder.dart'
    as _i1018;
import 'package:neighborhood_market/app/common/component_builder/presentation/components_page_factory.dart'
    as _i192;
import 'package:neighborhood_market/app/common/dynamic_link/dynamic_link_service.dart'
    as _i730;
import 'package:neighborhood_market/app/common/dynamic_link/firebase_dynamic_link_service.dart'
    as _i382;
import 'package:neighborhood_market/app/common/feature_flags/feature_flag_service.dart'
    as _i933;
import 'package:neighborhood_market/app/common/local_database/local_database.dart'
    as _i620;
import 'package:neighborhood_market/app/common/local_database/secure_preferences_local_storage.dart'
    as _i913;
import 'package:neighborhood_market/app/common/local_database/shared_preference_local_storage.dart'
    as _i1049;
import 'package:neighborhood_market/app/common/network/interceptors/network_interceptors.dart'
    as _i977;
import 'package:neighborhood_market/app/common/network/network.dart' as _i387;
import 'package:neighborhood_market/app/common/network/network_provider.dart'
    as _i599;
import 'package:neighborhood_market/app/common/payment_service/stripe_service.dart'
    as _i943;
import 'package:neighborhood_market/app/common/push_notifications/notifications_service.dart'
    as _i339;
import 'package:neighborhood_market/app/common/push_notifications/onesignal_notification_service.dart'
    as _i1064;
import 'package:neighborhood_market/app/common/reactive_listener/reactive_listener.dart'
    as _i360;
import 'package:neighborhood_market/app/common/router/app_navigator.dart'
    as _i521;
import 'package:neighborhood_market/app/common/router/router_config.dart'
    as _i848;
import 'package:neighborhood_market/app/common/xdebugging/features/network/channel/environment_channel.dart'
    as _i241;
import 'package:neighborhood_market/app/features/create_product/data/repository/category_data_source_impl.dart'
    as _i292;
import 'package:neighborhood_market/app/features/create_product/data/repository/create_product_repository.dart'
    as _i658;
import 'package:neighborhood_market/app/features/create_product/domain/boundary/category_data_source.dart'
    as _i981;
import 'package:neighborhood_market/app/features/create_product/domain/boundary/create_product_repository.dart'
    as _i166;
import 'package:neighborhood_market/app/features/create_product/presentation/cubit/builder_product_cubit.dart'
    as _i93;
import 'package:neighborhood_market/app/features/create_product/presentation/cubit/category_selection/category_selection_cubit.dart'
    as _i711;
import 'package:neighborhood_market/app/features/create_product/presentation/cubit/create_product_cubit.dart'
    as _i517;
import 'package:neighborhood_market/app/features/create_product/presentation/cubit/user_selection/user_selection_cubit.dart'
    as _i492;
import 'package:neighborhood_market/app/features/explore/data/repository/explore_repository_impl.dart'
    as _i309;
import 'package:neighborhood_market/app/features/explore/data/repository/filter_update_repository.dart'
    as _i253;
import 'package:neighborhood_market/app/features/explore/di/explore_module.dart'
    as _i127;
import 'package:neighborhood_market/app/features/explore/domain/boundary/explore_repository.dart'
    as _i999;
import 'package:neighborhood_market/app/features/explore/presentation/cubit/explore_cubit.dart'
    as _i467;
import 'package:neighborhood_market/app/features/explore/presentation/cubit/filter_cubit.dart'
    as _i564;
import 'package:neighborhood_market/app/features/following/data/repository/following_repository_impl.dart'
    as _i263;
import 'package:neighborhood_market/app/features/following/domain/boundary/following_repository.dart'
    as _i290;
import 'package:neighborhood_market/app/features/following/presentation/cubit/followings_cubit.dart'
    as _i462;
import 'package:neighborhood_market/app/features/home/data/repository/home_repository_impl.dart'
    as _i765;
import 'package:neighborhood_market/app/features/home/di/home_module.dart'
    as _i138;
import 'package:neighborhood_market/app/features/home/domain/boundary/home_repository.dart'
    as _i195;
import 'package:neighborhood_market/app/features/home/presentation/cubit/home_cubit.dart'
    as _i586;
import 'package:neighborhood_market/app/features/home/presentation/cubit/notifications/notifications_cubit.dart'
    as _i532;
import 'package:neighborhood_market/app/features/home/presentation/widgets/filters/di/filters_widget_module.dart'
    as _i537;
import 'package:neighborhood_market/app/features/home/presentation/widgets/search_bar/di/search_widget_module.dart'
    as _i781;
import 'package:neighborhood_market/app/features/home/presentation/widgets/shop_gallery/di/shop_gallery_widget_module.dart'
    as _i829;
import 'package:neighborhood_market/app/features/home/presentation/widgets/text/di/text_widget_module.dart'
    as _i528;
import 'package:neighborhood_market/app/features/login/data/repository/login_repository_impl.dart'
    as _i81;
import 'package:neighborhood_market/app/features/login/domain/login_interactor.dart'
    as _i383;
import 'package:neighborhood_market/app/features/login/domain/repositories/login_repository.dart'
    as _i733;
import 'package:neighborhood_market/app/features/login/presentation/cubit/login_cubit.dart'
    as _i267;
import 'package:neighborhood_market/app/features/main/presentation/cubit/main_page_cubit.dart'
    as _i1006;
import 'package:neighborhood_market/app/features/manage_cards/data/repository/manage_cards_repository.dart'
    as _i919;
import 'package:neighborhood_market/app/features/manage_cards/domain/boundary/manage_cards_repository.dart'
    as _i338;
import 'package:neighborhood_market/app/features/manage_cards/presentation/cubit/manage_cards_cubit.dart'
    as _i994;
import 'package:neighborhood_market/app/features/my_listing/data/repository/my_listing_repository.dart'
    as _i80;
import 'package:neighborhood_market/app/features/my_listing/domain/boundary/my_listing_repository.dart'
    as _i953;
import 'package:neighborhood_market/app/features/my_listing/presentation/cubit/delete_listing_cubit.dart'
    as _i783;
import 'package:neighborhood_market/app/features/my_listing/presentation/cubit/my_listing_cubit.dart'
    as _i453;
import 'package:neighborhood_market/app/features/my_profile/data/repository/my_profile_repository.dart'
    as _i282;
import 'package:neighborhood_market/app/features/my_profile/data/repository/update_phone_email_repository_impl.dart'
    as _i711;
import 'package:neighborhood_market/app/features/my_profile/domain/boundary/my_profile_repository.dart'
    as _i250;
import 'package:neighborhood_market/app/features/my_profile/domain/boundary/update_phone_email_repository.dart'
    as _i845;
import 'package:neighborhood_market/app/features/my_profile/presentation/cubit/account_management/account_management_cubit.dart'
    as _i220;
import 'package:neighborhood_market/app/features/my_profile/presentation/cubit/my_profile_cubit.dart'
    as _i345;
import 'package:neighborhood_market/app/features/my_profile/presentation/cubit/update_email_phone/update_email_phone_cubit.dart'
    as _i967;
import 'package:neighborhood_market/app/features/my_profile/presentation/cubit/update_password/update_password_cubit.dart'
    as _i1049;
import 'package:neighborhood_market/app/features/my_profile/presentation/cubit/update_profile_photo/update_profile_photo_cubit.dart'
    as _i452;
import 'package:neighborhood_market/app/features/my_purchases/data/repository/my_purchases_repository_impl.dart'
    as _i312;
import 'package:neighborhood_market/app/features/my_purchases/data/repository/purchase_details_repository_impl.dart'
    as _i703;
import 'package:neighborhood_market/app/features/my_purchases/domain/boundary/my_purchases_repository.dart'
    as _i590;
import 'package:neighborhood_market/app/features/my_purchases/domain/boundary/purchase_details_repository.dart'
    as _i216;
import 'package:neighborhood_market/app/features/my_purchases/presentation/cubit/purchase_details_cubit.dart'
    as _i712;
import 'package:neighborhood_market/app/features/my_purchases/presentation/cubit/purchases_completed_cubit.dart'
    as _i832;
import 'package:neighborhood_market/app/features/my_purchases/presentation/cubit/purchases_in_progress_cubit.dart'
    as _i1056;
import 'package:neighborhood_market/app/features/my_purchases/presentation/cubit/review_product/review_product_cubit.dart'
    as _i781;
import 'package:neighborhood_market/app/features/notifications/data/repository/notification_repository.dart'
    as _i10;
import 'package:neighborhood_market/app/features/notifications/domain/boundary/notification_repository.dart'
    as _i133;
import 'package:neighborhood_market/app/features/notifications/presentation/cubit/notifications_cubit.dart'
    as _i208;
import 'package:neighborhood_market/app/features/product/data/repository/product_repository_impl.dart'
    as _i750;
import 'package:neighborhood_market/app/features/product/domain/boundaries/product_repository.dart'
    as _i815;
import 'package:neighborhood_market/app/features/product/domain/product_interactor.dart'
    as _i160;
import 'package:neighborhood_market/app/features/product/presentation/cubit/image_full_view/image_full_view_cubit.dart'
    as _i1003;
import 'package:neighborhood_market/app/features/product/presentation/cubit/product_details_cubit.dart'
    as _i718;
import 'package:neighborhood_market/app/features/product/presentation/widgets/product_action_button/presentation/cubit/offer_cubit.dart'
    as _i340;
import 'package:neighborhood_market/app/features/product_payment/data/repository/product_payment_order_repository.dart'
    as _i469;
import 'package:neighborhood_market/app/features/product_payment/data/repository/purchase_repository.dart'
    as _i1054;
import 'package:neighborhood_market/app/features/product_payment/domain/boundary/product_payment_order_repository.dart'
    as _i218;
import 'package:neighborhood_market/app/features/product_payment/domain/boundary/purchase_repository.dart'
    as _i789;
import 'package:neighborhood_market/app/features/product_payment/presentation/cubit/payment_step/product_payment_steps_cubit.dart'
    as _i967;
import 'package:neighborhood_market/app/features/product_payment/presentation/cubit/product_order/product_payment_order_cubit.dart'
    as _i153;
import 'package:neighborhood_market/app/features/product_payment/presentation/cubit/purchase/purchase_cubit.dart'
    as _i508;
import 'package:neighborhood_market/app/features/product_payment/presentation/cubit/shipping_infos/shipping_infos_cubit.dart'
    as _i145;
import 'package:neighborhood_market/app/features/product_payment/presentation/cubit/shipping_methods/shipping_methods_cubit.dart'
    as _i531;
import 'package:neighborhood_market/app/features/profile/di/profile_module.dart'
    as _i94;
import 'package:neighborhood_market/app/features/profile/domain/profile_interactor.dart'
    as _i376;
import 'package:neighborhood_market/app/features/profile/presentation/cubit/profile_cubit.dart'
    as _i378;
import 'package:neighborhood_market/app/features/profile/presentation/widgets/header/di/header_widget_module.dart'
    as _i3;
import 'package:neighborhood_market/app/features/purchasing_setup/data/repository/purchasing_setup_repository.dart'
    as _i386;
import 'package:neighborhood_market/app/features/purchasing_setup/domain/boundary/purchasing_setup_repository.dart'
    as _i1032;
import 'package:neighborhood_market/app/features/purchasing_setup/presentation/cubit/purchasing_setup_cubit.dart'
    as _i712;
import 'package:neighborhood_market/app/features/recover_password/data/repository/recover_password_repository.dart'
    as _i564;
import 'package:neighborhood_market/app/features/recover_password/domain/boundary/recover_password_repository.dart'
    as _i838;
import 'package:neighborhood_market/app/features/recover_password/presentation/cubit/recover_password_cubit.dart'
    as _i388;
import 'package:neighborhood_market/app/features/register/data/repository/register_repository_impl.dart'
    as _i113;
import 'package:neighborhood_market/app/features/register/di/register_module.dart'
    as _i350;
import 'package:neighborhood_market/app/features/register/domain/repositories/register_repository.dart'
    as _i63;
import 'package:neighborhood_market/app/features/register/presentation/cubit/eye_control_cubit.dart'
    as _i916;
import 'package:neighborhood_market/app/features/register/presentation/cubit/register/register_cubit.dart'
    as _i26;
import 'package:neighborhood_market/app/features/register/presentation/cubit/register_step/register_steps_cubit.dart'
    as _i345;
import 'package:neighborhood_market/app/features/seller_profile/data/repositories/seller_profile_repository.dart'
    as _i276;
import 'package:neighborhood_market/app/features/seller_profile/domain/boundary/seller_profile_repository.dart'
    as _i685;
import 'package:neighborhood_market/app/features/seller_profile/presentation/cubit/seller_profile_cubit.dart'
    as _i768;
import 'package:neighborhood_market/app/features/seller_profile/presentation/cubit/seller_reviews_cubit.dart'
    as _i354;
import 'package:neighborhood_market/app/features/splash/presentation/cubit/splash_cubit_cubit.dart'
    as _i338;
import 'package:neighborhood_market/app/features/white_glove/data/repository/white_glove_repository_impl.dart'
    as _i1034;
import 'package:neighborhood_market/app/features/white_glove/domain/boundary/white_glove_repository.dart'
    as _i510;
import 'package:neighborhood_market/app/features/white_glove/presentation/cubit/white_glove_cubit.dart'
    as _i474;
import 'package:neighborhood_market/app/features/wishlist/data/repository/update_wishlist_repository.dart'
    as _i525;
import 'package:neighborhood_market/app/features/wishlist/data/repository/wishlist_repository_impl.dart'
    as _i1072;
import 'package:neighborhood_market/app/features/wishlist/di/wishlist_module.dart'
    as _i853;
import 'package:neighborhood_market/app/features/wishlist/domain/boundary/wishlist_repository.dart'
    as _i1011;
import 'package:neighborhood_market/app/features/wishlist/presentation/cubit/wishlist_cubit.dart'
    as _i16;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> $initAppGetIt({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    await _i528.TextWidgetModule().init(gh);
    await _i781.SearchWidgetModule().init(gh);
    await _i537.FiltersWidgetModule().init(gh);
    await _i829.ShopGalleryWidgetModule().init(gh);
    await _i3.HeaderWidgetModule().init(gh);
    final registerModule = _$RegisterModule();
    final componentBuilderModule = _$ComponentBuilderModule();
    final profileModule = _$ProfileModule();
    final exploreModule = _$ExploreModule();
    final wishlistModule = _$WishlistModule();
    final homeModule = _$HomeModule();
    gh.factory<_i1003.ImageFullViewCubit>(() => _i1003.ImageFullViewCubit());
    gh.factory<_i916.EyeControlCubit>(
        () => registerModule.provideEyeControlCubit());
    gh.factory<_i1006.MainPageCubit>(() => _i1006.MainPageCubit());
    gh.factory<_i967.ProductPaymentStepsCubit>(
        () => _i967.ProductPaymentStepsCubit());
    gh.factory<_i1018.ComponentContentAdapterBuilder>(
        () => componentBuilderModule.providesComponentContentAdapterBuilder());
    gh.singleton<_i943.StripeService>(() => _i943.StripeService());
    gh.singleton<_i241.EnvironmentChannel>(
        () => _i241.EnvironmentChannelImpl());
    gh.singleton<_i360.ReactiveListener>(() => _i360.ReactiveListenerImpl());
    gh.singleton<_i620.LocalStorage>(() => _i1049.SharedPreferencesDatabase());
    gh.singleton<_i339.NotificationsService>(
        () => _i1064.OnesignalNotificationService());
    gh.lazySingleton<_i521.AppNavigator>(
        () => _i521.AppNavigatorImpl(gh<_i848.AppRouterConfig>()));
    gh.factory<_i981.CategoryDataSource>(() =>
        _i292.CategoryDataSourceImpl(localStorage: gh<_i620.LocalStorage>()));
    gh.lazySingleton<_i525.UpdateWishlistRepository>(
        () => _i525.UpdateWishlistRepositoryImpl(gh<_i360.ReactiveListener>()));
    gh.singleton<_i620.LocalStorage>(
      () => _i913.SecurePreferencesLocalStorage(),
      instanceName: 'SecurePreferencesLocalStorage',
    );
    gh.lazySingleton<_i253.FilterUpdateRepository>(
        () => _i253.FilterUpdateRepositoryImpl(gh<_i360.ReactiveListener>()));
    gh.singleton<_i933.FeatureFlagService>(
        () => _i933.FeatureFlagServiceImpl());
    gh.factory<_i564.FilterCubit>(
        () => _i564.FilterCubit(gh<_i253.FilterUpdateRepository>()));
    gh.singleton<_i1007.AuthService>(() => _i1007.AuthServiceImpl(
        storage: gh<_i620.LocalStorage>(
            instanceName: 'SecurePreferencesLocalStorage')));
    gh.factory<_i338.SplashCubit>(
        () => _i338.SplashCubit(gh<_i1007.AuthService>()));
    gh.factory<_i730.DynamicLinkService>(
        () => _i382.FirebaseDynamicLinkService(gh<_i933.FeatureFlagService>()));
    gh.factory<_i345.RegisterStepsCubit>(
        () => _i345.RegisterStepsCubit(gh<_i620.LocalStorage>()));
    gh.factory<_i977.NetworkInterceptors>(
        () => _i977.NetworkInterceptorsImpl(gh<_i1007.AuthService>()));
    gh.factory<_i376.ProfileInteractor>(() => _i376.ProfileInteractorImpl(
          gh<_i1007.AuthService>(),
          gh<_i339.NotificationsService>(),
          gh<_i360.ReactiveListener>(),
        ));
    gh.factory<_i378.ProfileCubit>(
        () => _i378.ProfileCubit(gh<_i376.ProfileInteractor>()));
    gh.lazySingleton<_i599.NetworkProvider>(() => _i599.NetworkProviderImlp(
          authService: gh<_i1007.AuthService>(),
          environmentChannel: gh<_i241.EnvironmentChannel>(),
          networkInterceptors: gh<_i977.NetworkInterceptors>(),
        ));
    gh.lazySingleton<_i195.HomeRepository>(() =>
        _i765.HomeRepositoryImpl(networkProvider: gh<_i387.NetworkProvider>()));
    gh.factory<_i338.ManageCardsRepository>(() =>
        _i919.ManageCardsRepositoryImpl(provider: gh<_i387.NetworkProvider>()));
    gh.factory<_i1032.PurchasingSetupRepository>(() =>
        _i386.PurchasingSetupRepositoryImpl(
            provider: gh<_i387.NetworkProvider>()));
    gh.factory<_i218.ProductPaymentOrderRepository>(() =>
        _i469.ProductPaymentOrderRepositoryImpl(gh<_i387.NetworkProvider>()));
    gh.factory<_i815.ProductRepository>(() => _i750.ProductRepositoryImpl(
          gh<_i387.NetworkProvider>(),
          gh<_i933.FeatureFlagService>(),
        ));
    gh.factory<_i290.FollowingRepository>(() => _i263.FollowingRepositoryImpl(
          networkProvider: gh<_i387.NetworkProvider>(),
          eventBus: gh<_i360.ReactiveListener>(),
        ));
    gh.lazySingleton<_i999.ExploreRepository>(() => _i309.ExploreRepositoryImpl(
        networkProvider: gh<_i387.NetworkProvider>()));
    gh.factory<_i160.ProductInteractor>(() => _i160.ProductInteractorImpl(
          gh<_i815.ProductRepository>(),
          gh<_i730.DynamicLinkService>(),
          gh<_i360.ReactiveListener>(),
        ));
    gh.factory<_i192.ComponentsPageFactory>(
      () => profileModule.provideProfilePageFactory(
        gh<_i378.ProfileCubit>(),
        gh<_i1018.ComponentContentAdapterBuilder>(),
      ),
      instanceName: 'ProfilePageFactory',
    );
    gh.factory<_i953.MyListingRepository>(
        () => _i80.MyListingRepositoryImpl(gh<_i387.NetworkProvider>()));
    gh.factory<_i838.RecoverPasswordRepository>(() =>
        _i564.RecoverPasswordRepositoryImpl(
            provider: gh<_i387.NetworkProvider>()));
    gh.lazySingleton<_i1011.WishlistRepository>(() =>
        _i1072.WishlistRepositoryImpl(
            networkProvider: gh<_i387.NetworkProvider>()));
    gh.factory<_i467.ExploreCubit>(() => _i467.ExploreCubit(
          gh<_i999.ExploreRepository>(),
          gh<_i253.FilterUpdateRepository>(),
          gh<_i525.UpdateWishlistRepository>(),
        ));
    gh.factory<_i994.ManageCardsCubit>(
        () => _i994.ManageCardsCubit(gh<_i338.ManageCardsRepository>()));
    gh.factory<_i510.WhiteGloveRepository>(() =>
        _i1034.WhiteGloveRepositoryImpl(provider: gh<_i599.NetworkProvider>()));
    gh.factory<_i789.PurchaseRepository>(() => _i1054.PurchaseRepositoryImpl(
          provider: gh<_i387.NetworkProvider>(),
          reactiveListener: gh<_i360.ReactiveListener>(),
        ));
    gh.factory<_i462.FollowingsCubit>(
        () => _i462.FollowingsCubit(gh<_i290.FollowingRepository>()));
    gh.factory<_i718.ProductDetailsCubit>(
        () => _i718.ProductDetailsCubit(gh<_i160.ProductInteractor>()));
    gh.factory<_i16.WishlistCubit>(() => _i16.WishlistCubit(
          gh<_i1011.WishlistRepository>(),
          gh<_i525.UpdateWishlistRepository>(),
        ));
    gh.factory<_i145.ShippingInfosCubit>(() =>
        _i145.ShippingInfosCubit(gh<_i218.ProductPaymentOrderRepository>()));
    gh.factory<_i531.ShippingMethodsCubit>(() =>
        _i531.ShippingMethodsCubit(gh<_i218.ProductPaymentOrderRepository>()));
    gh.factory<_i153.ProductPaymentOrderCubit>(() =>
        _i153.ProductPaymentOrderCubit(
            gh<_i218.ProductPaymentOrderRepository>()));
    gh.factory<_i192.ComponentsPageFactory>(
      () => exploreModule.provideExplorePageFactory(
        gh<_i467.ExploreCubit>(),
        gh<_i1018.ComponentContentAdapterBuilder>(),
      ),
      instanceName: 'ExplorePageFactory',
    );
    gh.factory<_i340.OfferCubit>(() => _i340.OfferCubit(
          gh<_i815.ProductRepository>(),
          gh<_i360.ReactiveListener>(),
        ));
    gh.lazySingleton<_i733.LoginRepository>(() => _i81.LoginRepositoryImpl(
          networkProvider: gh<_i387.NetworkProvider>(),
          authService: gh<_i1007.AuthService>(),
          notificationsService: gh<_i339.NotificationsService>(),
        ));
    gh.factory<_i166.CreateProductRepository>(
        () => _i658.CreateProductRepositoryImpl(
              provider: gh<_i387.NetworkProvider>(),
              eventBus: gh<_i360.ReactiveListener>(),
              dataSource: gh<_i981.CategoryDataSource>(),
            ));
    gh.factory<_i250.MyProfileRepository>(() => _i282.MyProfileRepositoryImpl(
          provider: gh<_i387.NetworkProvider>(),
          reactiveListener: gh<_i360.ReactiveListener>(),
        ));
    gh.factory<_i586.HomeCubit>(() => _i586.HomeCubit(
          gh<_i195.HomeRepository>(),
          gh<_i360.ReactiveListener>(),
        ));
    gh.factory<_i532.NotificationsHomeCubit>(() => _i532.NotificationsHomeCubit(
          gh<_i195.HomeRepository>(),
          gh<_i360.ReactiveListener>(),
        ));
    gh.factory<_i1049.UpdatePasswordCubit>(
        () => _i1049.UpdatePasswordCubit(gh<_i250.MyProfileRepository>()));
    gh.factory<_i452.UpdateProfilePhotoCubit>(
        () => _i452.UpdateProfilePhotoCubit(gh<_i250.MyProfileRepository>()));
    gh.factory<_i388.RecoverPasswordCubit>(() =>
        _i388.RecoverPasswordCubit(gh<_i838.RecoverPasswordRepository>()));
    gh.factory<_i845.UpdatePhoneEmailRepository>(() =>
        _i711.UpdatePhoneEmailRepositoryImpl(
            provider: gh<_i387.NetworkProvider>()));
    gh.factory<_i192.ComponentsPageFactory>(
      () => wishlistModule.provideWishlistPageFactory(
        gh<_i16.WishlistCubit>(),
        gh<_i1018.ComponentContentAdapterBuilder>(),
      ),
      instanceName: 'WishlistPageFactory',
    );
    gh.factory<_i711.CategorySelectionCubit>(() =>
        _i711.CategorySelectionCubit(gh<_i166.CreateProductRepository>()));
    gh.factory<_i492.UserSelectionCubit>(
        () => _i492.UserSelectionCubit(gh<_i166.CreateProductRepository>()));
    gh.factory<_i93.BuilderProductCubit>(
        () => _i93.BuilderProductCubit(gh<_i166.CreateProductRepository>()));
    gh.factory<_i517.CreateProductCubit>(
        () => _i517.CreateProductCubit(gh<_i166.CreateProductRepository>()));
    gh.factory<_i685.SellerProfileRepository>(() =>
        _i276.SellerProfileRepositoryImpl(
            provider: gh<_i387.NetworkProvider>()));
    gh.lazySingleton<_i63.RegisterRepository>(() =>
        _i113.RegisterRepositoryImpl(
            networkProvider: gh<_i387.NetworkProvider>()));
    gh.factory<_i216.PurchaseDetailsRepository>(() =>
        _i703.PurchaseDetailsRepositoryImpl(
            provider: gh<_i387.NetworkProvider>()));
    gh.factory<_i133.NotificationRepository>(() =>
        _i10.NotificationRepositoryImpl(provider: gh<_i387.NetworkProvider>()));
    gh.factory<_i590.MyPurchasesRepository>(
        () => _i312.MyPurchasesRepositoryImpl(gh<_i387.NetworkProvider>()));
    gh.factory<_i783.DeleteListingCubit>(() => _i783.DeleteListingCubit(
          gh<_i953.MyListingRepository>(),
          gh<_i360.ReactiveListener>(),
        ));
    gh.factory<_i712.PurchasingSetupCubit>(() =>
        _i712.PurchasingSetupCubit(gh<_i1032.PurchasingSetupRepository>()));
    gh.factory<_i508.PurchaseCubit>(() => _i508.PurchaseCubit(
          gh<_i789.PurchaseRepository>(),
          gh<_i943.StripeService>(),
        ));
    gh.factory<_i192.ComponentsPageFactory>(
      () => homeModule.provideHomePageFactory(
        gh<_i586.HomeCubit>(),
        gh<_i1018.ComponentContentAdapterBuilder>(),
      ),
      instanceName: 'HomePageFactory',
    );
    gh.factory<_i453.MyListingCubit>(() => _i453.MyListingCubit(
          gh<_i953.MyListingRepository>(),
          gh<_i360.ReactiveListener>(),
        ));
    gh.factory<_i26.RegisterCubit>(() => _i26.RegisterCubit(
          gh<_i63.RegisterRepository>(),
          gh<_i1007.AuthService>(),
        ));
    gh.lazySingleton<_i383.LoginInteractor>(
        () => _i383.LoginInteractorImpl(gh<_i733.LoginRepository>()));
    gh.factory<_i1056.PurchasesInProgressCubit>(() =>
        _i1056.PurchasesInProgressCubit(gh<_i590.MyPurchasesRepository>()));
    gh.factory<_i832.PurchasesCompletedCubit>(
        () => _i832.PurchasesCompletedCubit(gh<_i590.MyPurchasesRepository>()));
    gh.factory<_i474.WhiteGloveCubit>(
        () => _i474.WhiteGloveCubit(gh<_i510.WhiteGloveRepository>()));
    gh.factory<_i712.PurchaseDetailsCubit>(() =>
        _i712.PurchaseDetailsCubit(gh<_i216.PurchaseDetailsRepository>()));
    gh.factory<_i781.ReviewProductCubit>(
        () => _i781.ReviewProductCubit(gh<_i216.PurchaseDetailsRepository>()));
    gh.factory<_i208.NotificationsCubit>(
        () => _i208.NotificationsCubit(gh<_i133.NotificationRepository>()));
    gh.factory<_i354.SellerReviewsCubit>(
        () => _i354.SellerReviewsCubit(gh<_i685.SellerProfileRepository>()));
    gh.factory<_i768.SellerProfileCubit>(
        () => _i768.SellerProfileCubit(gh<_i685.SellerProfileRepository>()));
    gh.factory<_i345.MyProfileCubit>(() => _i345.MyProfileCubit(
          gh<_i250.MyProfileRepository>(),
          gh<_i1007.AuthService>(),
        ));
    gh.factory<_i220.AccountManagementCubit>(() => _i220.AccountManagementCubit(
          gh<_i250.MyProfileRepository>(),
          gh<_i376.ProfileInteractor>(),
        ));
    gh.factory<_i967.UpdateEmailPhoneCubit>(() =>
        _i967.UpdateEmailPhoneCubit(gh<_i845.UpdatePhoneEmailRepository>()));
    gh.factory<_i267.LoginCubit>(
        () => _i267.LoginCubit(gh<_i383.LoginInteractor>()));
    return this;
  }
}

class _$RegisterModule extends _i350.RegisterModule {}

class _$ComponentBuilderModule extends _i124.ComponentBuilderModule {}

class _$ProfileModule extends _i94.ProfileModule {}

class _$ExploreModule extends _i127.ExploreModule {}

class _$WishlistModule extends _i853.WishlistModule {}

class _$HomeModule extends _i138.HomeModule {}
