// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'available_shops_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AvailableShopeStore on _AvailableShopeStore, Store {
  final _$availableServicesListAtom =
      Atom(name: '_AvailableShopeStore.availableServicesList');

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
availableServicesList: ${availableServicesList}
    ''';
  }
}
