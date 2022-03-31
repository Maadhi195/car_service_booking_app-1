import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../custom_widgets/custom_wrappers.dart';

class ServiceBookingScreen extends StatelessWidget {
  const ServiceBookingScreen({Key? key}) : super(key: key);
  static const routeName = '/service-booking-screen';

  @override
  Widget build(BuildContext context) {
    //ThemeData & constraints
    ThemeData _theme = Theme.of(context);
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              _vehicleDescriptionList(_theme),
              const SizedBox(height: 20),
              _bookingDetailsList(_theme),
              const SizedBox(height: 20),
              _serviceDetails(_theme),
              const SizedBox(height: 20),
            ],
          ),
        ),
        floatingActionButton: _floatingButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  Widget _floatingButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Send Request'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _serviceDetails(ThemeData _theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        children: [
          _customListItem(_theme, 'Service Details', '100\$'),
          const SizedBox(height: 20),
          Text(
            'Full Car Wash',
            style: _theme.textTheme.headline4,
          )
        ],
      ),
    );
  }

  Widget _bookingDetailsList(ThemeData _theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Booking Details',
            style: _theme.textTheme.headline3,
          ),
          const SizedBox(height: 10),
          customContainer(
            child: Column(
              children: [
                _customListItem(
                    _theme, 'Date', DateFormat('y:M:d').format(DateTime.now())),
                _customListItem(_theme, 'Duration', '90 minutes'),
                _customListItem(_theme, 'Address', 'south park, london'),
              ],
            ),
          ),
        ],
      ),
    );
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
                    softWrap: true,
                    style: _theme.textTheme.headline5,
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

  Widget _vehicleDescriptionList(ThemeData _theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Vehicle Decription',
            style: _theme.textTheme.headline3,
          ),
          const SizedBox(height: 10),
          customContainer(
            child: Column(
              children: [
                _customListItem(_theme, 'Car Brand', 'Audi A6'),
                _customListItem(_theme, 'Model', 'Audi A6'),
                _customListItem(_theme, 'Reg. No', '2345'),
                _customListItem(_theme, 'Color', 'Black'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
