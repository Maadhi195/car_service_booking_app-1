// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AuthStore on _AuthStore, Store {
  final _$newUserAtom = Atom(name: '_AuthStore.newUser');

  @override
  User get newUser {
    _$newUserAtom.reportRead();
    return super.newUser;
  }

  @override
  set newUser(User value) {
    _$newUserAtom.reportWrite(value, super.newUser, () {
      super.newUser = value;
    });
  }

  final _$currentUserAtom = Atom(name: '_AuthStore.currentUser');

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

  final _$serviceShopeListAtom = Atom(name: '_AuthStore.serviceShopeList');

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

  final _$_AuthStoreActionController = ActionController(name: '_AuthStore');

  @override
  void updateCoverImage(String image) {
    final _$actionInfo = _$_AuthStoreActionController.startAction(
        name: '_AuthStore.updateCoverImage');
    try {
      return super.updateCoverImage(image);
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
