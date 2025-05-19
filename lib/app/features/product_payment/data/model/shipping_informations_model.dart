import 'package:equatable/equatable.dart';
import 'package:neighborhood_market/app/features/product_payment/domain/entities/shipping_informations_entity.dart';

class ShippingInformationsModel extends Equatable {
  const ShippingInformationsModel({
    this.fullName,
    this.phone,
    this.address,
    this.complementAdress,
    this.city,
    this.state,
    this.zipCode,
  });

  factory ShippingInformationsModel.fromJson(Map<String, dynamic> json) {

    final data = json['data'] as Map<String, dynamic>;

    return ShippingInformationsModel(
      fullName: data['name'] as String?,
      phone: data['phone'] as String?,
      address: data['address1'] as String?,
      complementAdress: data['address2'] as String?,
      city: data['city'] as String?,
      state: data['state'] as String?,
      zipCode: data['zipCode'] as String?,
    );
  }

  final String? fullName;
  final String? phone;
  final String? address;
  final String? complementAdress;
  final String? city;
  final String? state;
  final String? zipCode;

  ShippingInformationsEntity toEntity() {
    return ShippingInformationsEntity(
      fullName: fullName,
      phone: phone,
      address: address,
      complementAdress: complementAdress,
      city: city,
      state: state,
      zipCode: zipCode,
    );
  }

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
