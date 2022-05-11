// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'available_shops_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AvailableShopeStore on _AvailableShopeStore, Store {
  final _$availableShopsListAtom =
      Atom(name: '_AvailableShopeStore.availableShopsList');

  @override
  ObservableList<VehicleService> get availableShopsList {
    _$availableShopsListAtom.reportRead();
    return super.availableShopsList;
  }

  @override
  set availableShopsList(ObservableList<VehicleService> value) {
    _$availableShopsListAtom.reportWrite(value, super.availableShopsList, () {
      super.availableShopsList = value;
    });
  }

  @override
  String toString() {
    return '''
availableShopsList: ${availableShopsList}
    ''';
  }
}
