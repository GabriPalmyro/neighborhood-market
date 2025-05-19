import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:neighborhood_market/app/common/design_system/components/support/icon/icon_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/support/icons/icons.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/common/router/app_navigator.dart';
import 'package:neighborhood_market/app/features/product/domain/entities/product_entity.dart';
import 'package:neighborhood_market/app/features/product/domain/entities/seller_entity.dart';
import 'package:neighborhood_market/app/features/product/presentation/cubit/product_details_cubit.dart';
import 'package:neighborhood_market/app/features/product/presentation/widgets/image_carousel/presentation/image_carousel_success_widget.dart';
import 'package:neighborhood_market/app/features/product/presentation/widgets/product_success_widget.dart';

class MockProductDetailsCubit extends Mock implements ProductDetailsCubit {}

class MockAppNavigator extends Mock implements AppNavigator {}

void main() {
  late MockProductDetailsCubit mockDetailsCubit;
  late MockAppNavigator mockAppNavigator;

  setUp(() {
    mockDetailsCubit = MockProductDetailsCubit();
    mockAppNavigator = MockAppNavigator();

    when(() => mockDetailsCubit.state).thenReturn(const ProductDetailsInitial());
    when(() => mockDetailsCubit.stream).thenAnswer((_) => Stream.value(const ProductDetailsInitial()));
  });

  Widget createWidgetUnderTest(ProductEntity product, {bool showShareButton = false}) {
    return DSTheme(
      data: DSThemeAppData(),
      child: MaterialApp(
        home: MultiBlocProvider(
          providers: [
            BlocProvider<ProductDetailsCubit>.value(value: mockDetailsCubit),
          ],
          child: ProductSuccessWidget(
            product: product,
            appNavigator: mockAppNavigator,
            showShareButton: showShareButton,
          ),
        ),
      ),
    );
  }

  group('ProductSuccessWidget Tests', () {
    testWidgets('displays product details correctly', (tester) async {
      const product = ProductEntity(
        id: 'test-product-id',
        title: 'Test Product',
        price: 100.0,
        images: ['image1.png'],
        description: 'Test Description',
        tags: ['tag1', 'tag2'],
        isLiked: false,
      );

      await tester.pumpWidget(createWidgetUnderTest(product));

      expect(find.text('Test Product'), findsOneWidget);
      expect(find.text('Test Description'), findsOneWidget);
      expect(find.byType(ImageCarouselSuccessWidget), findsOneWidget);
    });

    testWidgets('calls share product when share button is tapped', (tester) async {
      const product = ProductEntity(
        id: 'test-product-id',
        title: 'Test Product',
        price: 100.0,
        images: ['image1.png'],
        description: 'Test Description',
        tags: ['tag1', 'tag2'],
        isLiked: false,
      );

      when(() => mockDetailsCubit.generateShareProductLink(any())).thenAnswer((_) async => 'test-link');

      await tester.pumpWidget(createWidgetUnderTest(product, showShareButton: true));

      await tester.tap(find.byWidgetPredicate((widget) => widget is DSIcon && widget.icon == DSIcons.share));
      await tester.pumpAndSettle();

      verify(() => mockDetailsCubit.generateShareProductLink('test-product-id')).called(1);
    });

    testWidgets('calls follow seller when follow button is tapped', (tester) async {
      const product = ProductEntity(
        id: 'test-product-id',
        title: 'Test Product',
        price: 100.0,
        images: ['image1.png'],
        description: 'Test Description',
        tags: ['tag1', 'tag2'],
        isLiked: false,
        seller: SellerEntity(
          id: 'test-seller-id',
          name: 'Test Seller',
          description: 'Test Seller Description',
          imageUrl: 'image.png',
          isFollowing: false,
        ),
      );

      when(() => mockDetailsCubit.followSeller()).thenAnswer((_) async {});

      await tester.pumpWidget(createWidgetUnderTest(product));

      await tester.tap(find.text('Follow'));
      await tester.pumpAndSettle();

      verify(() => mockDetailsCubit.followSeller()).called(1);
    });

    testWidgets('calls unfollow seller when unfollow button is tapped', (tester) async {
      const product = ProductEntity(
        id: 'test-product-id',
        title: 'Test Product',
        price: 100.0,
        images: ['image1.png'],
        description: 'Test Description',
        tags: ['tag1', 'tag2'],
        isLiked: false,
      );

      when(() => mockDetailsCubit.unfollowSeller()).thenAnswer((_) async {});

      await tester.pumpWidget(createWidgetUnderTest(product));

      await tester.tap(find.text('Unfollow'));
      await tester.pumpAndSettle();

      verify(() => mockDetailsCubit.unfollowSeller()).called(1);
    });

    testWidgets('calls like product when like button is tapped', (tester) async {
      const product = ProductEntity(
        id: 'test-product-id',
        title: 'Test Product',
        price: 100.0,
        images: ['image1.png'],
        description: 'Test Description',
        tags: ['tag1', 'tag2'],
        isLiked: false,
      );

      when(
        () => mockDetailsCubit.changeLikeStatus(
          onSuccess: any(named: 'onSuccess'),
          onError: any(named: 'onError'),
        ),
      ).thenAnswer((_) async {});

      await tester.pumpWidget(createWidgetUnderTest(product));


      await tester.tap(find.byWidgetPredicate((widget) => widget is DSIcon && widget.icon == DSIcons.heartFilled));
      await tester.pumpAndSettle();

      verify(
        () => mockDetailsCubit.changeLikeStatus(
          onSuccess: any(named: 'onSuccess'),
          onError: any(named: 'onError'),
        ),
      ).called(1);
    });
  });
}
