// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_screen_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeScreenStore on _HomeScreenStore, Store {
  final _$bookingsAtom = Atom(name: '_HomeScreenStore.bookings');

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

  final _$messagesAtom = Atom(name: '_HomeScreenStore.messages');

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

  final _$totalUserVehiclesAtom =
      Atom(name: '_HomeScreenStore.totalUserVehicles');

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

  final _$serviceShopListAtom = Atom(name: '_HomeScreenStore.serviceShopList');

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

  final _$_bookingHistoryListAtom =
      Atom(name: '_HomeScreenStore._bookingHistoryList');

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

  @override
  String toString() {
    return '''
bookings: ${bookings},
messages: ${messages},
totalUserVehicles: ${totalUserVehicles},
serviceShopList: ${serviceShopList}
    ''';
  }
}
