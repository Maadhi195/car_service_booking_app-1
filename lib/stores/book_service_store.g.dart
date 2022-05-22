// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_service_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BookServiceStore on _BookServiceStore, Store {
  late final _$bookingTimeAtom =
      Atom(name: '_BookServiceStore.bookingTime', context: context);

  @override
  DateTime get bookingTime {
    _$bookingTimeAtom.reportRead();
    return super.bookingTime;
  }

  @override
  set bookingTime(DateTime value) {
    _$bookingTimeAtom.reportWrite(value, super.bookingTime, () {
      super.bookingTime = value;
    });
  }

  late final _$vehicleServiceAtom =
      Atom(name: '_BookServiceStore.vehicleService', context: context);

  @override
  VehicleService? get vehicleService {
    _$vehicleServiceAtom.reportRead();
    return super.vehicleService;
  }

  @override
  set vehicleService(VehicleService? value) {
    _$vehicleServiceAtom.reportWrite(value, super.vehicleService, () {
      super.vehicleService = value;
    });
  }

  late final _$serviceRequestListAtom =
      Atom(name: '_BookServiceStore.serviceRequestList', context: context);

  @override
  ObservableList<ServiceRequest> get serviceRequestList {
    _$serviceRequestListAtom.reportRead();
    return super.serviceRequestList;
  }

  @override
  set serviceRequestList(ObservableList<ServiceRequest> value) {
    _$serviceRequestListAtom.reportWrite(value, super.serviceRequestList, () {
      super.serviceRequestList = value;
    });
  }

  late final _$createBookingRequestAsyncAction =
      AsyncAction('_BookServiceStore.createBookingRequest', context: context);

  @override
  Future<FunctionResponse> createBookingRequest(
      DateTime date, VehicleService vehicleService) {
    return _$createBookingRequestAsyncAction
        .run(() => super.createBookingRequest(date, vehicleService));
  }

  late final _$_BookServiceStoreActionController =
      ActionController(name: '_BookServiceStore', context: context);

  @override
  void setBookingTime(DateTime newDateTime) {
    final _$actionInfo = _$_BookServiceStoreActionController.startAction(
        name: '_BookServiceStore.setBookingTime');
    try {
      return super.setBookingTime(newDateTime);
    } finally {
      _$_BookServiceStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setVehicleService(VehicleService newVehicleService) {
    final _$actionInfo = _$_BookServiceStoreActionController.startAction(
        name: '_BookServiceStore.setVehicleService');
    try {
      return super.setVehicleService(newVehicleService);
    } finally {
      _$_BookServiceStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
bookingTime: ${bookingTime},
vehicleService: ${vehicleService},
serviceRequestList: ${serviceRequestList}
    ''';
  }
}
