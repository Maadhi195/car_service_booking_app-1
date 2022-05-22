// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_screen_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UserProfileScreenStore on _UserProfileScreenStore, Store {
  late final _$currentUserAtom =
      Atom(name: '_UserProfileScreenStore.currentUser', context: context);

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
      AsyncAction('_UserProfileScreenStore.loadProfile', context: context);

  @override
  Future<FunctionResponse> loadProfile() {
    return _$loadProfileAsyncAction.run(() => super.loadProfile());
  }

  @override
  String toString() {
    return '''
currentUser: ${currentUser}
    ''';
  }
}
