// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AuthStore on _AuthStore, Store {
  late final _$newUserAtom = Atom(name: '_AuthStore.newUser', context: context);

  @override
  AppUser get newUser {
    _$newUserAtom.reportRead();
    return super.newUser;
  }

  @override
  set newUser(AppUser value) {
    _$newUserAtom.reportWrite(value, super.newUser, () {
      super.newUser = value;
    });
  }

  late final _$currentUserAtom =
      Atom(name: '_AuthStore.currentUser', context: context);

  @override
  ServiceShop? get currentUser {
    _$currentUserAtom.reportRead();
    return super.currentUser;
  }

  @override
  set currentUser(ServiceShop? value) {
    _$currentUserAtom.reportWrite(value, super.currentUser, () {
      super.currentUser = value;
    });
  }

  late final _$serviceShopeListAtom =
      Atom(name: '_AuthStore.serviceShopeList', context: context);

  @override
  ObservableList<ServiceShop> get serviceShopeList {
    _$serviceShopeListAtom.reportRead();
    return super.serviceShopeList;
  }

  @override
  set serviceShopeList(ObservableList<ServiceShop> value) {
    _$serviceShopeListAtom.reportWrite(value, super.serviceShopeList, () {
      super.serviceShopeList = value;
    });
  }

  late final _$_AuthStoreActionController =
      ActionController(name: '_AuthStore', context: context);

  @override
  void updateUserImage(String image) {
    final _$actionInfo = _$_AuthStoreActionController.startAction(
        name: '_AuthStore.updateUserImage');
    try {
      return super.updateUserImage(image);
    } finally {
      _$_AuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateUserLocation(LatLng newLocation) {
    final _$actionInfo = _$_AuthStoreActionController.startAction(
        name: '_AuthStore.updateUserLocation');
    try {
      return super.updateUserLocation(newLocation);
    } finally {
      _$_AuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
newUser: ${newUser},
currentUser: ${currentUser},
serviceShopeList: ${serviceShopeList}
    ''';
  }
}
