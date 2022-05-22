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

  late final _$currentUserAtom =
      Atom(name: '_HomeScreenStore.currentUser', context: context);

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

  late final _$serviceShopListAtom =
      Atom(name: '_HomeScreenStore.serviceShopList', context: context);

  @override
  ObservableList<ServiceShop> get serviceShopList {
    _$serviceShopListAtom.reportRead();
    return super.serviceShopList;
  }

  @override
  set serviceShopList(ObservableList<ServiceShop> value) {
    _$serviceShopListAtom.reportWrite(value, super.serviceShopList, () {
      super.serviceShopList = value;
    });
  }

  late final _$_bookingHistoryListAtom =
      Atom(name: '_HomeScreenStore._bookingHistoryList', context: context);

  @override
  ObservableList<BookingHistory> get _bookingHistoryList {
    _$_bookingHistoryListAtom.reportRead();
    return super._bookingHistoryList;
  }

  @override
  set _bookingHistoryList(ObservableList<BookingHistory> value) {
    _$_bookingHistoryListAtom.reportWrite(value, super._bookingHistoryList, () {
      super._bookingHistoryList = value;
    });
  }

  late final _$loadAllDataAsyncAction =
      AsyncAction('_HomeScreenStore.loadAllData', context: context);

  @override
  Future<void> loadAllData() {
    return _$loadAllDataAsyncAction.run(() => super.loadAllData());
  }

  @override
  String toString() {
    return '''
bookings: ${bookings},
messages: ${messages},
totalUserVehicles: ${totalUserVehicles},
isLoadingHomeScreenData: ${isLoadingHomeScreenData},
currentUser: ${currentUser},
serviceShopList: ${serviceShopList}
    ''';
  }
}
