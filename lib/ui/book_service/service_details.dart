import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import '../../custom_utils/connectivity_helper.dart';
import '../../custom_utils/custom_alerts.dart';
import '../../custom_utils/function_response.dart';
import '../../custom_utils/general_helper.dart';
import '../../custom_widgets/custom_wrappers.dart';
import '../../models/service_request.dart';
import '../../models/vehicle_service.dart';
import '../../service_locator.dart';
import '../../stores/book_service_store.dart';
import '../home/home_screen.dart';

class ServiceDetails extends StatelessWidget {
  ServiceDetails({
    Key? key,
  }) : super(key: key);
  static const routeName = '/service-details-screen';

  //Stores
  final BookServiceStore _bookServiceStore = getIt<BookServiceStore>();

  //Custom Utilities
  final CustomAlerts _customAlerts = getIt<CustomAlerts>();
  final ConnectivityHelper _connectivityHelper = getIt<ConnectivityHelper>();

  //Functions
  Future<void> bookService(BuildContext context, DateTime date,
      VehicleService vehicleService) async {
    FunctionResponse fResponse = getIt<FunctionResponse>();
    _customAlerts.showLoaderDialog(context);
    fResponse = await _connectivityHelper.checkInternetConnection();
    if (fResponse.success) {
      fResponse =
          await _bookServiceStore.createBookingRequest(date, vehicleService);
    }
    _customAlerts.popLoader(context);

    fResponse.printResponse();
    //show snackbar
    _customAlerts.showSnackBar(context, fResponse.message,
        success: fResponse.success);
    if (fResponse.success) {
      //Pop edit screen
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
  }

  @override
  Widget build(BuildContext context) {
    //ThemeData & constraints
    ThemeData theme = Theme.of(context);
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    //route Data handeling
    dynamic routeData = modalRouteHandler(context);

    final VehicleService vehicleService = routeData['vehicleService'];

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(children: [
          customContainer(
            height: 250,
            width: screenWidth,
            child: Image.asset(
              vehicleService.coverImage,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 20),
          customContainer(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                _customListItem(theme, 'Shop Name', vehicleService.shopName),
                _customListItem(
                    theme, 'Description', vehicleService.description),
                _customListItem(theme, 'Serivice Type',
                    vehicleService.serviceType.getName()),
                _customListItem(
                    theme, 'Rating', vehicleService.rating.toStringAsFixed(1)),
                _customListItem(theme, 'Address', vehicleService.address),
                _customListItem(theme, 'Distance',
                    '${vehicleService.distance.toStringAsFixed(1)} km'),
                _customListItem(
                    theme, 'Cost', '${vehicleService.cost.toString()} PKR'),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                  child: ElevatedButton(
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all(Colors.black),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                      ),
                      onPressed: () {
                        DatePicker.showDateTimePicker(context,
                            showTitleActions: true,
                            minTime: DateTime(2018, 3, 5),
                            maxTime: DateTime(2029, 6, 7),
                            onConfirm: (date) async {
                          print('confirm $date');

                          await bookService(context, date, vehicleService);
                        }, currentTime: DateTime.now());
                      },
                      child: const Text('Book Service'))),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                  child: ElevatedButton(
                      onPressed: () {}, child: Text('Request Mobile Service'))),
            ],
          ),
        ]),
      ),
    ));
  }
}

Widget _customListItem(ThemeData _theme, String key, String value) {
  return Column(
    children: [
      Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  key,
                  style: _theme.textTheme.headline5,
                ),
                Text(
                  value,
                  // softWrap: true,
                  style: _theme.textTheme.headline5,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
      const Divider(),
    ],
  );
}
