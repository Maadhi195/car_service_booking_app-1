// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manage_vehicle_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ManageVehicleStore on _ManageVehicleStore, Store {
  late final _$isLoadingAllVehiclesAtom =
      Atom(name: '_ManageVehicleStore.isLoadingAllVehicles', context: context);

  @override
  bool get isLoadingAllVehicles {
    _$isLoadingAllVehiclesAtom.reportRead();
    return super.isLoadingAllVehicles;
  }

  @override
  set isLoadingAllVehicles(bool value) {
    _$isLoadingAllVehiclesAtom.reportWrite(value, super.isLoadingAllVehicles,
        () {
      super.isLoadingAllVehicles = value;
    });
  }

  late final _$selectedVehicleTypeAtom =
      Atom(name: '_ManageVehicleStore.selectedVehicleType', context: context);

  @override
  String get selectedVehicleType {
    _$selectedVehicleTypeAtom.reportRead();
    return super.selectedVehicleType;
  }

  @override
  set selectedVehicleType(String value) {
    _$selectedVehicleTypeAtom.reportWrite(value, super.selectedVehicleType, () {
      super.selectedVehicleType = value;
    });
  }

  late final _$vehicleImageListAtom =
      Atom(name: '_ManageVehicleStore.vehicleImageList', context: context);

  @override
  ObservableList<String> get vehicleImageList {
    _$vehicleImageListAtom.reportRead();
    return super.vehicleImageList;
  }

  @override
  set vehicleImageList(ObservableList<String> value) {
    _$vehicleImageListAtom.reportWrite(value, super.vehicleImageList, () {
      super.vehicleImageList = value;
    });
  }

  late final _$userVehicleListAtom =
      Atom(name: '_ManageVehicleStore.userVehicleList', context: context);

  @override
  ObservableList<Vehicle> get userVehicleList {
    _$userVehicleListAtom.reportRead();
    return super.userVehicleList;
  }

  @override
  set userVehicleList(ObservableList<Vehicle> value) {
    _$userVehicleListAtom.reportWrite(value, super.userVehicleList, () {
      super.userVehicleList = value;
    });
  }

  late final _$addNewVehicleToListAsyncAction =
      AsyncAction('_ManageVehicleStore.addNewVehicleToList', context: context);

  @override
  Future<FunctionResponse> addNewVehicleToList(Vehicle newVehicle) {
    return _$addNewVehicleToListAsyncAction
        .run(() => super.addNewVehicleToList(newVehicle));
  }

  late final _$loadAllVehiclesAsyncAction =
      AsyncAction('_ManageVehicleStore.loadAllVehicles', context: context);

  @override
  Future<void> loadAllVehicles() {
    return _$loadAllVehiclesAsyncAction.run(() => super.loadAllVehicles());
  }

  late final _$_ManageVehicleStoreActionController =
      ActionController(name: '_ManageVehicleStore', context: context);

  @override
  void changeSelectedVehicleType(String newVehicleType) {
    final _$actionInfo = _$_ManageVehicleStoreActionController.startAction(
        name: '_ManageVehicleStore.changeSelectedVehicleType');
    try {
      return super.changeSelectedVehicleType(newVehicleType);
    } finally {
      _$_ManageVehicleStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addNewVehicleImage(String newImage) {
    final _$actionInfo = _$_ManageVehicleStoreActionController.startAction(
        name: '_ManageVehicleStore.addNewVehicleImage');
    try {
      return super.addNewVehicleImage(newImage);
    } finally {
      _$_ManageVehicleStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeVehicleImage(String image) {
    final _$actionInfo = _$_ManageVehicleStoreActionController.startAction(
        name: '_ManageVehicleStore.removeVehicleImage');
    try {
      return super.removeVehicleImage(image);
    } finally {
      _$_ManageVehicleStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoadingAllVehicles: ${isLoadingAllVehicles},
selectedVehicleType: ${selectedVehicleType},
vehicleImageList: ${vehicleImageList},
userVehicleList: ${userVehicleList}
    ''';
  }
}
