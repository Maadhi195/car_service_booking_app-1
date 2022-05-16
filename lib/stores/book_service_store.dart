import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../custom_utils/function_response.dart';
import '../custom_utils/general_helper.dart';
import '../models/service_request.dart';
import '../models/vehicle_service.dart';
import '../service_locator.dart';

part 'book_service_store.g.dart';

class BookServiceStore = _BookServiceStore with _$BookServiceStore;

abstract class _BookServiceStore with Store {
  @observable
  DateTime bookingTime = DateTime.now();

  @observable
  VehicleService? vehicleService;

  @observable
  ObservableList<ServiceRequest> serviceRequestList =
      ObservableList<ServiceRequest>.of([]);

  @action
  void setBookingTime(DateTime newDateTime) {
    bookingTime = newDateTime;
  }

  @action
  void setVehicleService(VehicleService newVehicleService) {
    vehicleService = newVehicleService;
  }

  @action
  Future<FunctionResponse> createBookingRequest(
      DateTime date, VehicleService vehicleService) async {
    FunctionResponse fResponse = getIt<FunctionResponse>();
    try {
      await delayFunction();
      serviceRequestList.add(
        ServiceRequest(
          id: DateTime.now().microsecondsSinceEpoch.toString(),
          userId: '123',
          paymentMethod: PaymentMethod.cash,
          dateTime: date,
          vehicleService: vehicleService,
          isMobile: false,
          serviceRequestStatus: ServiceRequestStatus.idle,
        ),
      );
      fResponse.passed(message: 'Succefully booked service');
    } catch (e) {
      fResponse.failed(message: 'Error booking Service : $e');
    }
    return fResponse;
  }
}
