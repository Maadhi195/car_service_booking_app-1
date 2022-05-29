import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../custom_widgets/custom_wrappers.dart';
import '../../models/vehicle.dart';
import '../../service_locator.dart';
import '../../stores/manage_vehicle_store.dart';
import '../profile/widget/display_image_widget.dart';

class UserVehicleListScreen extends StatefulWidget {
  UserVehicleListScreen({Key? key}) : super(key: key);
  static const routeName = '/user-vehicle-list-screen';

  @override
  State<UserVehicleListScreen> createState() => _UserVehicleListScreenState();
}

class _UserVehicleListScreenState extends State<UserVehicleListScreen> {
  //Stores
  final ManageVehicleStore _manageVehicleStore = getIt<ManageVehicleStore>();

  @override
  void initState() {
    // _manageVehicleStore.loadAllVehicles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //ThemeData & constraints
    ThemeData theme = Theme.of(context);
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Observer(builder: (_) {
        return _manageVehicleStore.isLoadingAllVehicles
            ? const Scaffold(
                body: Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              )
            : Scaffold(
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
                            manageVehicleStore: _manageVehicleStore,
                            theme: theme),
                      ],
                    ),
                  ),
                ),
              );
      }),
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
          return SingleVehicleWidget(
            currentItem: currentItem,
            theme: theme,
          );
        }
      },
    );
  }
}

class SingleVehicleWidget extends StatelessWidget {
  const SingleVehicleWidget({
    Key? key,
    required this.currentItem,
    required this.theme,
  }) : super(key: key);
  final ThemeData theme;
  final Vehicle currentItem;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(currentItem.id),
      direction: DismissDirection.endToStart,
      onDismissed: (DismissDirection dismissDirection) {},
      child: customCard(
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(120),
            child: buildImage(theme, currentItem.vehicleImages.first,
                height: 50, width: 50),
          ),
          title: Text(currentItem.vehicleModel),
          subtitle: Text(currentItem.vehicleCompany),
          trailing: Text(currentItem.vehicleType.getName()),
        ),
      ),
    );
  }
}
