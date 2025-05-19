import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/common/formatter/phone_number_formatter.dart';
import 'package:neighborhood_market/app/features/product_payment/domain/boundary/product_payment_order_repository.dart';
import 'package:neighborhood_market/app/features/product_payment/domain/entities/shipping_informations_entity.dart';

part 'shipping_infos_state.dart';

@injectable
class ShippingInfosCubit extends Cubit<ShippingInfosState> {
  ShippingInfosCubit(this.repository) : super(const ShippingInfosInitial());

  final ProductPaymentOrderRepository repository;

  late TextEditingController fullNameController;
  late TextEditingController phoneNumberController;
  late TextEditingController addressController;
  late TextEditingController address2Controller;
  late TextEditingController cityController;
  late TextEditingController stateController;
  late TextEditingController zipCodeController;

  Future<void> getShippingInfos() async {
    emit(const ShippingInfosLoading());
    try {
      final shippingInfos = await repository.getShippingInformations();

      fullNameController = TextEditingController(text: shippingInfos.fullName);
      phoneNumberController = TextEditingController(text: phoneWithCountryCodeFormatter.maskText(shippingInfos.phone ?? ''));
      addressController = TextEditingController(text: shippingInfos.address);
      address2Controller = TextEditingController(text: shippingInfos.complementAdress);
      cityController = TextEditingController(text: shippingInfos.city);
      stateController = TextEditingController(text: shippingInfos.state ?? 'Texas');
      zipCodeController = TextEditingController(text: shippingInfos.zipCode);

      emit(ShippingInfosLoaded(shippingInfos));
    } catch (e) {
      fullNameController = TextEditingController();
      phoneNumberController = TextEditingController();
      addressController = TextEditingController();
      address2Controller = TextEditingController();
      cityController = TextEditingController();
      stateController = TextEditingController();
      zipCodeController = TextEditingController();

      emit(const ShippingInfosLoaded(ShippingInformationsEntity()));
    }
  }

  void changeEditState() {
    emit(
      (state as ShippingInfosLoaded).copyWith(
        enableEditing: !(state as ShippingInfosLoaded).enableEditing,
      ),
    );
  }
}
