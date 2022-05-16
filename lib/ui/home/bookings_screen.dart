import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/service_request.dart';
import '../../models/vehicle_service.dart';
import '../../service_locator.dart';
import '../../stores/book_service_store.dart';

class BookingsScreen extends StatelessWidget {
  BookingsScreen({Key? key}) : super(key: key);
  static const routeName = '/booking-screen';

  //Stores
  final BookServiceStore _bookServiceStore = getIt<BookServiceStore>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Bookings'),
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(18.0),
          itemCount: _bookServiceStore.serviceRequestList.isEmpty
              ? 1
              : _bookServiceStore.serviceRequestList.length,
          itemBuilder: (BuildContext context, int index) {
            if (_bookServiceStore.serviceRequestList.isEmpty) {
              return const Center(
                child: Text('No record found'),
              );
            } else {
              ServiceRequest currentItem =
                  _bookServiceStore.serviceRequestList[index];
              return Card(
                child: ListTile(
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat('d MMM y')
                            .format(currentItem.dateTime)
                            .toString(),
                        // style: theme.textTheme.headline6,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        DateFormat('kk:mm a')
                            .format(currentItem.dateTime)
                            .toString(),
                        // style: theme.textTheme.headline6,
                      ),
                    ],
                  ),
                  title: Text(currentItem.vehicleService.serviceType.getName()),
                  subtitle: Text(currentItem.vehicleService.shopName),
                  trailing: Text(
                    currentItem.serviceRequestStatus.getName(),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
