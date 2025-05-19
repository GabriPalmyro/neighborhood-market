import 'package:equatable/equatable.dart';

class RegisterInfosEntity extends Equatable {
  const RegisterInfosEntity({
    this.username,
    this.name,
    this.email,
    this.countryCode,
    this.phoneNumber,
    this.dateOfBirth,
    this.adress1,
    this.adress2,
    this.city,
    this.state,
    this.zipCode,
    this.password,
    this.isTermsAccepted = false,
    this.isPhoneNumberVerified = false,
  });

  final String? username;
  final String? name;
  final String? email;
  final String? countryCode;
  final String? phoneNumber;
  final String? dateOfBirth;
  final String? adress1;
  final String? adress2;
  final String? city;
  final String? state;
  final String? zipCode;
  final String? password;
  final bool? isTermsAccepted;
  final bool? isPhoneNumberVerified;

  @override
  List<Object?> get props => [
        username,
        name,
        email,
        countryCode,
        phoneNumber,
        dateOfBirth,
        adress1,
        adress2,
        city,
        state,
        zipCode,
        password,
        isTermsAccepted,
        isPhoneNumberVerified,
      ];
}
