// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_screen_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeScreenStore on _HomeScreenStore, Store {
  late final _$bookingsAtom =
      Atom(name: '_HomeScreenStore.bookings', context: context);

  @override
  int get bookings {
    _$bookingsAtom.reportRead();
    return super.bookings;
  }

  @override
  set bookings(int value) {
    _$bookingsAtom.reportWrite(value, super.bookings, () {
      super.bookings = value;
    });
  }

  late final _$messagesAtom =
      Atom(name: '_HomeScreenStore.messages', context: context);

  @override
  int get messages {
    _$messagesAtom.reportRead();
    return super.messages;
  }

  @override
  set messages(int value) {
    _$messagesAtom.reportWrite(value, super.messages, () {
      super.messages = value;
    });
  }

  late final _$totalUserVehiclesAtom =
      Atom(name: '_HomeScreenStore.totalUserVehicles', context: context);

  @override
  int get totalUserVehicles {
    _$totalUserVehiclesAtom.reportRead();
    return super.totalUserVehicles;
  }

  @override
  set totalUserVehicles(int value) {
    _$totalUserVehiclesAtom.reportWrite(value, super.totalUserVehicles, () {
      super.totalUserVehicles = value;
    });
  }

  late final _$isLoadingHomeScreenDataAtom =
      Atom(name: '_HomeScreenStore.isLoadingHomeScreenData', context: context);

  @override
  bool get isLoadingHomeScreenData {
    _$isLoadingHomeScreenDataAtom.reportRead();
    return super.isLoadingHomeScreenData;
  }

  @override
  set isLoadingHomeScreenData(bool value) {
    _$isLoadingHomeScreenDataAtom
        .reportWrite(value, super.isLoadingHomeScreenData, () {
      super.isLoadingHomeScreenData = value;
    });
  }

  @override
  String toString() {
    return '''
bookings: ${bookings},
messages: ${messages},
totalUserVehicles: ${totalUserVehicles},
isLoadingHomeScreenData: ${isLoadingHomeScreenData}
    ''';
  }
}
