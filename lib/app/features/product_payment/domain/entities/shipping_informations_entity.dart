import 'package:equatable/equatable.dart';

class ShippingInformationsEntity extends Equatable {
  const ShippingInformationsEntity({
    this.fullName,
    this.phone,
    this.address,
    this.complementAdress,
    this.city,
    this.state,
    this.zipCode,
  });

  final String? fullName;
  final String? phone;
  final String? address;
  final String? complementAdress;
  final String? city;
  final String? state;
  final String? zipCode;

  bool get isValid =>
      fullName?.isNotEmpty == true &&
      phone?.isNotEmpty == true &&
      address?.isNotEmpty == true &&
      city?.isNotEmpty == true &&
      state?.isNotEmpty == true &&
      zipCode?.isNotEmpty == true;

  @override
  List<Object?> get props => [
        fullName,
        phone,
        address,
        complementAdress,
        city,
        state,
        zipCode,
      ];
}
