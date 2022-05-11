import 'package:flutter/material.dart';

import '../../models/vehicle.dart';
import '../../service_locator.dart';
import '../../stores/manage_vehicle_store.dart';
import '../profile/widget/display_image_widget.dart';

class UserVehicleListScreen extends StatelessWidget {
  UserVehicleListScreen({Key? key}) : super(key: key);
  static const routeName = '/user-vehicle-list-screen';

  //Stores
  final ManageVehicleStore _manageVehicleStore = getIt<ManageVehicleStore>();

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
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                Text(
                  'All your Vehicles',
                  style: theme.textTheme.headline2,
                ),
                const SizedBox(height: 20),
                VehicleList(
                    manageVehicleStore: _manageVehicleStore, theme: theme),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class VehicleList extends StatelessWidget {
  const VehicleList({
    Key? key,
    required ManageVehicleStore manageVehicleStore,
    required this.theme,
  })  : _manageVehicleStore = manageVehicleStore,
        super(key: key);

  final ManageVehicleStore _manageVehicleStore;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _manageVehicleStore.userVehicleList.isEmpty
          ? 1
          : _manageVehicleStore.userVehicleList.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        print(
            'vehicle list is empty ${_manageVehicleStore.userVehicleList.isEmpty}');
        if (_manageVehicleStore.userVehicleList.isEmpty) {
          return Center(
            child: Text(
              'No Vehicles Added yet',
              style: theme.textTheme.headline4,
            ),
          );
        } else {
          Vehicle currentItem = _manageVehicleStore.userVehicleList[index];

          print('Model Name ${currentItem.vehicleModel}');
          print('Comapny ${currentItem.vehicleCompany}');
          print('Description ${currentItem.vehicleDescription}');
          print('total images ${currentItem.vehicleImages.length}');
          print('Vehicle Type ${currentItem.vehicleType.getName()}');
          print(
              'total vehicles : ${_manageVehicleStore.userVehicleList.length}');
          return SingleVehicleWidget(currentItem: currentItem);
        }
      },
    );
  }
}

class SingleVehicleWidget extends StatelessWidget {
  const SingleVehicleWidget({
    Key? key,
    required this.currentItem,
  }) : super(key: key);

  final Vehicle currentItem;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(currentItem.id),
      direction: DismissDirection.endToStart,
      onDismissed: (DismissDirection dismissDirection) {},
      child: Card(
        child: ListTile(
          leading: CircleAvatar(
            radius: 50,
            // child: Image.asset(appLogo),
            child: DisplayImage(
              imagePath: currentItem.vehicleImages.first,
              onPressed: () {},
            ),
          ),
          title: Text(currentItem.vehicleModel),
          subtitle: Text(currentItem.vehicleCompany),
          trailing: Text(currentItem.vehicleType.getName()),
        ),
      ),
    );
  }
}
