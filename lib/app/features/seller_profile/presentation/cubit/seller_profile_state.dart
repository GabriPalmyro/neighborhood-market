part of 'seller_profile_cubit.dart';

sealed class SellerProfileState extends Equatable {
  const SellerProfileState();

  @override
  List<Object> get props => [];
}

final class SellerProfileInitial extends SellerProfileState {
  const SellerProfileInitial();

  @override
  List<Object> get props => [];
}

final class SellerProfileLoading extends SellerProfileState {
  const SellerProfileLoading();

  @override
  List<Object> get props => [];
}

final class SellerProfileLoaded extends SellerProfileState {
  const SellerProfileLoaded(this.sellerProfile);
  final SellerProfileEntity sellerProfile;

  SellerProfileLoaded copyWith({
    SellerProfileEntity? sellerProfile,
  }) {
    return SellerProfileLoaded(
      sellerProfile ?? this.sellerProfile,
    );
  }

  @override
  List<Object> get props => [sellerProfile];
}

final class SellerProfileError extends SellerProfileState {
  const SellerProfileError(
    this.message,
    this.sellerId,
  );
  
  final String message;
  final String sellerId;

  @override
  List<Object> get props => [message];
}
