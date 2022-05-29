// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProfileStore on _ProfileStore, Store {
  late final _$isLoadingAtom =
      Atom(name: '_ProfileStore.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$currentUserAtom =
      Atom(name: '_ProfileStore.currentUser', context: context);

  @override
  AppUser get currentUser {
    _$currentUserAtom.reportRead();
    return super.currentUser;
  }

  @override
  set currentUser(AppUser value) {
    _$currentUserAtom.reportWrite(value, super.currentUser, () {
      super.currentUser = value;
    });
  }

  late final _$loadProfileAsyncAction =
      AsyncAction('_ProfileStore.loadProfile', context: context);

  @override
  Future<FunctionResponse> loadProfile() {
    return _$loadProfileAsyncAction.run(() => super.loadProfile());
  }

  late final _$updateProfileAsyncAction =
      AsyncAction('_ProfileStore.updateProfile', context: context);

  @override
  Future<FunctionResponse> updateProfile() {
    return _$updateProfileAsyncAction.run(() => super.updateProfile());
  }

  late final _$_ProfileStoreActionController =
      ActionController(name: '_ProfileStore', context: context);

  @override
  void toggleIsLoading() {
    final _$actionInfo = _$_ProfileStoreActionController.startAction(
        name: '_ProfileStore.toggleIsLoading');
    try {
      return super.toggleIsLoading();
    } finally {
      _$_ProfileStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateUserAddress(String address) {
    final _$actionInfo = _$_ProfileStoreActionController.startAction(
        name: '_ProfileStore.updateUserAddress');
    try {
      return super.updateUserAddress(address);
    } finally {
      _$_ProfileStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateUserName(String name) {
    final _$actionInfo = _$_ProfileStoreActionController.startAction(
        name: '_ProfileStore.updateUserName');
    try {
      return super.updateUserName(name);
    } finally {
      _$_ProfileStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateUserImage(String image) {
    final _$actionInfo = _$_ProfileStoreActionController.startAction(
        name: '_ProfileStore.updateUserImage');
    try {
      return super.updateUserImage(image);
    } finally {
      _$_ProfileStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateUserLocation(LatLng location) {
    final _$actionInfo = _$_ProfileStoreActionController.startAction(
        name: '_ProfileStore.updateUserLocation');
    try {
      return super.updateUserLocation(location);
    } finally {
      _$_ProfileStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateUserBio(String newBio) {
    final _$actionInfo = _$_ProfileStoreActionController.startAction(
        name: '_ProfileStore.updateUserBio');
    try {
      return super.updateUserBio(newBio);
    } finally {
      _$_ProfileStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
currentUser: ${currentUser}
    ''';
  }
}
