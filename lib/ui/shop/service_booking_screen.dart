import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../custom_widgets/custom_wrappers.dart';

class ServiceBookingScreen extends StatelessWidget {
  const ServiceBookingScreen({Key? key}) : super(key: key);
  static const routeName = '/service-booking-screen';

  @override
  Widget build(BuildContext context) {
    //ThemeData & constraints
    ThemeData theme = Theme.of(context);
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
              _vehicleDescriptionList(theme),
              const SizedBox(height: 20),
              _bookingDetailsList(theme),
              const SizedBox(height: 20),
              _serviceDetails(theme),
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

  Widget _serviceDetails(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        children: [
          _customListItem(theme, 'Service Details', '100\$'),
          const SizedBox(height: 20),
          Text(
            'Full Car Wash',
            style: theme.textTheme.headline4,
          )
        ],
      ),
    );
  }

  Widget _bookingDetailsList(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Booking Details',
            style: theme.textTheme.headline3,
          ),
          const SizedBox(height: 10),
          customCard(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                _customListItem(
                    theme, 'Date', DateFormat('d M y').format(DateTime.now())),
                _customListItem(theme, 'Duration', '90 minutes'),
                _customListItem(theme, 'Address', 'south park, london'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _customListItem(ThemeData theme, String key, String value) {
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
                    style: theme.textTheme.headline5,
                  ),
                  Text(
                    value,
                    softWrap: true,
                    style: theme.textTheme.headline5,
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

  Widget _vehicleDescriptionList(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Vehicle Decription',
            style: theme.textTheme.headline3,
          ),
          const SizedBox(height: 10),
          customCard(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                _customListItem(theme, 'Car Brand', 'Audi A6'),
                _customListItem(theme, 'Model', 'Audi A6'),
                _customListItem(theme, 'Reg. No', '2345'),
                _customListItem(theme, 'Color', 'Black'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
