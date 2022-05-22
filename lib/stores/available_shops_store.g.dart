// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'available_shops_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AvailableShopStore on _AvailableShopStore, Store {
  late final _$selectedVehicleAtom =
      Atom(name: '_AvailableShopStore.selectedVehicle', context: context);

  @override
  Vehicle? get selectedVehicle {
    _$selectedVehicleAtom.reportRead();
    return super.selectedVehicle;
  }

  @override
  set selectedVehicle(Vehicle? value) {
    _$selectedVehicleAtom.reportWrite(value, super.selectedVehicle, () {
      super.selectedVehicle = value;
    });
  }

  late final _$selectedServiceTypeAtom =
      Atom(name: '_AvailableShopStore.selectedServiceType', context: context);

  @override
  ServiceType? get selectedServiceType {
    _$selectedServiceTypeAtom.reportRead();
    return super.selectedServiceType;
  }

  @override
  set selectedServiceType(ServiceType? value) {
    _$selectedServiceTypeAtom.reportWrite(value, super.selectedServiceType, () {
      super.selectedServiceType = value;
    });
  }

  late final _$isLoadingServicesAtom =
      Atom(name: '_AvailableShopStore.isLoadingServices', context: context);

  @override
  bool get isLoadingServices {
    _$isLoadingServicesAtom.reportRead();
    return super.isLoadingServices;
  }

  @override
  set isLoadingServices(bool value) {
    _$isLoadingServicesAtom.reportWrite(value, super.isLoadingServices, () {
      super.isLoadingServices = value;
    });
  }

  late final _$availableServicesListAtom =
      Atom(name: '_AvailableShopStore.availableServicesList', context: context);

  @override
  ObservableList<VehicleService> get availableServicesList {
    _$availableServicesListAtom.reportRead();
    return super.availableServicesList;
  }

  @override
  set availableServicesList(ObservableList<VehicleService> value) {
    _$availableServicesListAtom.reportWrite(value, super.availableServicesList,
        () {
      super.availableServicesList = value;
    });
  }

  @override
  String toString() {
    return '''
selectedVehicle: ${selectedVehicle},
selectedServiceType: ${selectedServiceType},
isLoadingServices: ${isLoadingServices},
availableServicesList: ${availableServicesList}
    ''';
  }
}
