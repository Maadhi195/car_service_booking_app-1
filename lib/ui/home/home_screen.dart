import 'package:app_30_car_service_app/models/vehicle_service.dart';
import 'package:intl/intl.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../constants/firebase_constants.dart';
import '../../custom_utils/connectivity_helper.dart';
import '../../custom_utils/custom_alerts.dart';
import '../../custom_utils/function_response.dart';
import '../../custom_utils/google_maps_helper.dart';
import '../../custom_widgets/custom_wrappers.dart';
import 'package:flutter/material.dart';
//Theme
import '../../models/service_request.dart';
import '../../models/vehicle.dart';
import '../../stores/available_shops_store.dart';
import '../../stores/book_service_store.dart';
import '../../stores/manage_vehicle_store.dart';
import '../../stores/profile_store.dart';
import '../../theme/my_app_colors.dart';
import '../../resources/app_images.dart';

//UI
import '../../ui/auth/login_screen.dart';
import '../../ui/chatbox/chat_screen.dart';
import '../../ui/home/available_shops_screen.dart';
import '../../ui/profile/user_profile_screen.dart';

//Stores
import '../../stores/home_screen_store.dart';
//Services
import '../../service_locator.dart';
import '../manage_vehicle/add_vehicle_screen.dart';
import '../manage_vehicle/user_vehicle_list_screen.dart';
import '../profile/widget/display_image_widget.dart';
import 'bookings_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);
  static const routeName = '/home-screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //Theme
  final AppColors _appColor = getIt<AppColors>();

  //Stores
  final HomeScreenStore _homeScreenStore = getIt<HomeScreenStore>();

  final ProfileStore _profileStore = getIt<ProfileStore>();

  final ManageVehicleStore _manageVehicleStore = getIt<ManageVehicleStore>();
  final AvailableShopStore _availableShopStore = getIt<AvailableShopStore>();

  final BookServiceStore _bookServiceStore = getIt<BookServiceStore>();

  //Utilities
  final GoogleMapsHelper _googleMapsHelper = getIt<GoogleMapsHelper>();

  final CustomAlerts _customAlerts = getIt<CustomAlerts>();

  final ConnectivityHelper _connectivityHelper = getIt<ConnectivityHelper>();

  //Functions
  Future<void> tryLogout(BuildContext context) async {
    FunctionResponse fResponse = getIt<FunctionResponse>();

    try {
      _customAlerts.showLoaderDialog(context);
      fResponse = await _connectivityHelper.checkInternetConnection();
      if (fResponse.success) {
        await firebaseAuth.signOut();
        fResponse.passed(message: 'Sign Out Successful');
      }
    } catch (e) {
      fResponse.failed(message: 'Error Logging Out');
    }

    _customAlerts.popLoader(context);

    fResponse.printResponse();
    //show snackbar
    _customAlerts.showSnackBar(context, fResponse.message,
        success: fResponse.success);
    if (fResponse.success) {
      //Go to Login
      Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
    }
  }

  @override
  void initState() {
    print('load data');
    _profileStore.loadProfile();
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
        return _profileStore.isLoading
            ? const Scaffold(
                body: Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              )
            : Scaffold(
                appBar: AppBar(
                  actions: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () {
                              // Navigator.of(context).pushNamed(ChatScreen.routeName);
                            },
                            icon: const Icon(Icons.notifications)),
                        IconButton(
                            onPressed: () async {
                              await tryLogout(context);
                            },
                            icon: const Icon(Icons.logout)),
                      ],
                    ),
                  ],
                ),
                body: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Column(
                          children: [
                            ProfileWidget(
                                theme: theme,
                                userProfileScreenStore: _profileStore),
                            const SizedBox(height: 20),
                            BookingStats(
                                theme: theme,
                                homeScreenStore: _homeScreenStore,
                                manageVehicleStore: _manageVehicleStore,
                                bookServiceStore: _bookServiceStore),
                            const SizedBox(height: 20),
                            ServiceTabs(
                              screenWidth: screenWidth,
                              theme: theme,
                              manageVehicleStore: _manageVehicleStore,
                              availableShopStore: _availableShopStore,
                            ),
                            const SizedBox(height: 20),
                            BookingHistoryList(
                              screenWidth: screenWidth,
                              theme: theme,
                              homeScreenStore: _homeScreenStore,
                              bookServiceStore: _bookServiceStore,
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                floatingActionButton: FloatingActionButton.extended(
                  onPressed: () => Navigator.of(context)
                      .pushNamed(AddNewVehicleScreen.routeName),
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: theme.colorScheme.secondary,
                  label: const Text('Add Vehicle'),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
              );
      }),
    );
  }
}

class ServiceTabs extends StatelessWidget {
  const ServiceTabs(
      {Key? key,
      required this.theme,
      required this.screenWidth,
      required this.manageVehicleStore,
      required this.availableShopStore})
      : super(key: key);
  final ThemeData theme;
  final double screenWidth;
  final ManageVehicleStore manageVehicleStore;
  final AvailableShopStore availableShopStore;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Services',
          style: theme.textTheme.headline3,
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return CarWashServices(
                          theme: theme,
                          screenWidth: screenWidth,
                          manageVehicleStore: manageVehicleStore,
                          availableShopStore: availableShopStore,
                        );
                      });
                },
                child: customCard(
                  height: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.water,
                        size: 60,
                      ),
                      // Image.asset(
                      //   appLogo,
                      //   height: 70,
                      // ),
                      Text('Car Wash'),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return WorkShopServices(
                          theme: theme,
                          screenWidth: screenWidth,
                          manageVehicleStore: manageVehicleStore,
                          availableShopStore: availableShopStore,
                        );
                      });
                },
                child: customCard(
                  height: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      // Image.asset(
                      //   appLogo,
                      //   height: 70,
                      // ),
                      Icon(
                        Icons.settings,
                        size: 60,
                      ),

                      Text('Workshop'),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return TyreShopServices(
                          theme: theme,
                          screenWidth: screenWidth,
                          manageVehicleStore: manageVehicleStore,
                          availableShopStore: availableShopStore,
                        );
                      });
                },
                child: customCard(
                  height: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      // Image.asset(
                      //   appLogo,
                      //   height: 70,
                      // ),
                      Icon(
                        Icons.cached_rounded,
                        size: 60,
                      ),

                      Text('Tyre Shop'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class TyreShopServices extends StatelessWidget {
  const TyreShopServices(
      {Key? key,
      required this.theme,
      required this.screenWidth,
      required this.manageVehicleStore,
      required this.availableShopStore})
      : super(key: key);
  final ThemeData theme;
  final double screenWidth;
  final ManageVehicleStore manageVehicleStore;
  final AvailableShopStore availableShopStore;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Text(
              'Tyre Shop',
              style: theme.textTheme.headline3,
            ),
            const SizedBox(height: 20),
            customImageBox(
              screenWidth,
              theme,
              image: carTyreChangeServiceImage,
              title: 'Tyre Change',
              onTap: () async {
                await findService(context, theme, ServiceType.tyreChange,
                    manageVehicleStore, availableShopStore);
              },
            ),
            const SizedBox(height: 20),
            customImageBox(
              screenWidth,
              theme,
              image: carTyreRepairServiceImage,
              title: 'Tyre Repair',
              onTap: () async {
                await findService(context, theme, ServiceType.tyreRepair,
                    manageVehicleStore, availableShopStore);
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class WorkShopServices extends StatelessWidget {
  const WorkShopServices(
      {Key? key,
      required this.theme,
      required this.screenWidth,
      required this.manageVehicleStore,
      required this.availableShopStore})
      : super(key: key);
  final ThemeData theme;
  final double screenWidth;
  final ManageVehicleStore manageVehicleStore;
  final AvailableShopStore availableShopStore;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Text(
              'Workshop',
              style: theme.textTheme.headline3,
            ),
            const SizedBox(height: 20),
            customImageBox(
              screenWidth,
              theme,
              image: oilChangeServiceImage,
              title: 'Oil Change',
              onTap: () async {
                await findService(context, theme, ServiceType.oilChange,
                    manageVehicleStore, availableShopStore);
              },
            ),
            const SizedBox(height: 20),
            customImageBox(
              screenWidth,
              theme,
              image: breakServiceImage,
              title: 'Break Service',
              onTap: () async {
                await findService(context, theme, ServiceType.breakService,
                    manageVehicleStore, availableShopStore);
              },
            ),
            const SizedBox(height: 20),
            customImageBox(
              screenWidth,
              theme,
              image: fullCarServiceImage,
              title: 'Car Service',
              onTap: () async {
                await findService(context, theme, ServiceType.carService,
                    manageVehicleStore, availableShopStore);
              },
            ),
            const SizedBox(height: 20),
            customImageBox(
              screenWidth,
              theme,
              image: batteryServiceImage,
              title: 'Battery Issue',
              onTap: () async {
                await findService(context, theme, ServiceType.batteryIssue,
                    manageVehicleStore, availableShopStore);
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class CarWashServices extends StatelessWidget {
  const CarWashServices(
      {Key? key,
      required this.theme,
      required this.screenWidth,
      required this.manageVehicleStore,
      required this.availableShopStore})
      : super(key: key);
  final ThemeData theme;
  final double screenWidth;
  final ManageVehicleStore manageVehicleStore;
  final AvailableShopStore availableShopStore;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Text(
              'Car Wash',
              style: theme.textTheme.headline3,
            ),
            const SizedBox(height: 20),
            customImageBox(
              screenWidth,
              theme,
              image: halfCarWashServiceImage,
              title: 'Half Car Wash',
              onTap: () async {
                await findService(context, theme, ServiceType.halfCarWash,
                    manageVehicleStore, availableShopStore);
              },
            ),
            const SizedBox(height: 20),
            customImageBox(
              screenWidth,
              theme,
              image: fullCarWashServiceImage,
              title: 'Full Car Wash',
              onTap: () async {
                await findService(context, theme, ServiceType.fullCarWash,
                    manageVehicleStore, availableShopStore);
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class BookingStats extends StatelessWidget {
  const BookingStats({
    Key? key,
    required this.theme,
    required this.homeScreenStore,
    required this.manageVehicleStore,
    required this.bookServiceStore,
  }) : super(key: key);
  final ThemeData theme;
  //Stores
  final HomeScreenStore homeScreenStore;
  final ManageVehicleStore manageVehicleStore;
  final BookServiceStore bookServiceStore;
  @override
  Widget build(BuildContext context) {
    return customCard(
        height: 100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: VehiclesTab(
                  manageVehicleStore: manageVehicleStore, theme: theme),
            ),
            Expanded(
              child:
                  BookingsTab(bookServiceStore: bookServiceStore, theme: theme),
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      homeScreenStore.messages.toString(),
                      style: theme.textTheme.headline4,
                    ),
                    Text(
                      'Messages',
                      style: theme.textTheme.headline5,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}

class BookingsTab extends StatefulWidget {
  const BookingsTab({
    Key? key,
    required this.bookServiceStore,
    required this.theme,
  }) : super(key: key);

  final BookServiceStore bookServiceStore;
  final ThemeData theme;

  @override
  State<BookingsTab> createState() => _BookingsTabState();
}

class _BookingsTabState extends State<BookingsTab> {
  @override
  void initState() {
    widget.bookServiceStore.loadAllServiceRequests();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return widget.bookServiceStore.isLoadingOrders
          ? const Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : Center(
              child: InkWell(
                onTap: () =>
                    Navigator.of(context).pushNamed(BookingsScreen.routeName),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Observer(builder: (_) {
                      return Text(
                        widget.bookServiceStore.serviceRequestList
                            .where((element) =>
                                element.serviceRequestStatus ==
                                ServiceRequestStatus.idle)
                            .toList()
                            .length
                            .toString(),
                        style: widget.theme.textTheme.headline4,
                      );
                    }),
                    Text(
                      'Bookings',
                      style: widget.theme.textTheme.headline5,
                    ),
                  ],
                ),
              ),
            );
    });
  }
}

class VehiclesTab extends StatefulWidget {
  const VehiclesTab({
    Key? key,
    required this.manageVehicleStore,
    required this.theme,
  }) : super(key: key);

  final ManageVehicleStore manageVehicleStore;
  final ThemeData theme;

  @override
  State<VehiclesTab> createState() => _VehiclesTabState();
}

class _VehiclesTabState extends State<VehiclesTab> {
  @override
  void initState() {
    widget.manageVehicleStore.loadAllVehicles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return widget.manageVehicleStore.isLoadingAllVehicles
          ? const Scaffold(
              body: Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            )
          : InkWell(
              onTap: () => Navigator.of(context)
                  .pushNamed(UserVehicleListScreen.routeName),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.manageVehicleStore.userVehicleList.length
                          .toString(),
                      style: widget.theme.textTheme.headline4,
                    ),
                    Text(
                      'Vehicles',
                      style: widget.theme.textTheme.headline5,
                    ),
                  ],
                ),
              ),
            );
    });
  }
}

class ProfileWidget extends StatelessWidget {
  const ProfileWidget(
      {Key? key, required this.theme, required this.userProfileScreenStore})
      : super(key: key);
  final ThemeData theme;
  final ProfileStore userProfileScreenStore;
  @override
  Widget build(BuildContext context) {
    return customCard(
      height: 120,
      child: InkWell(
        onTap: () => Navigator.of(context).pushNamed(ProfileScreen.routeName),
        child: Row(
          children: [
            const SizedBox(width: 10),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(200),
                child: buildImage(
                  theme,
                  userProfileScreenStore.currentUser.userImage,
                ),
              ),
            )),
            Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      userProfileScreenStore.currentUser.name,
                      style: theme.textTheme.headline3,
                    ),
                    Text(
                      userProfileScreenStore.currentUser.email,
                      style: theme.textTheme.headline5,
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

class BookingHistoryList extends StatelessWidget {
  const BookingHistoryList({
    Key? key,
    required this.screenWidth,
    required this.theme,
    required this.homeScreenStore,
    required this.bookServiceStore,
  }) : super(key: key);
  //UI
  final double screenWidth;
  final ThemeData theme;

  //Stores
  final HomeScreenStore homeScreenStore;
  final BookServiceStore bookServiceStore;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'History',
          style: theme.textTheme.headline3,
        ),
        const SizedBox(height: 15),
        Observer(builder: (_) {
          return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: bookServiceStore.serviceRequestList.isEmpty
                  ? 1
                  : bookServiceStore.serviceRequestList.length,
              itemBuilder: (context, index) {
                if (bookServiceStore.serviceRequestList.isEmpty ||
                    bookServiceStore.serviceRequestList
                        .where((element) =>
                            element.serviceRequestStatus !=
                            ServiceRequestStatus.idle)
                        .toList()
                        .isEmpty) {
                  return Column(
                    children: const [
                      SizedBox(height: 20),
                      Text('No Record Found')
                    ],
                  );
                } else {
                  ServiceRequest currentItem =
                      bookServiceStore.serviceRequestList[index];
                  if (currentItem.serviceRequestStatus !=
                          ServiceRequestStatus.done &&
                      currentItem.serviceRequestStatus !=
                          ServiceRequestStatus.canceled) {
                    return const SizedBox();
                  } else {
                    return Column(
                      children: [
                        Row(
                          key: ValueKey(
                              bookServiceStore.serviceRequestList[index]),
                          children: [
                            Expanded(
                              child: customCard(
                                child: Container(
                                  color: currentItem.serviceRequestStatus ==
                                          ServiceRequestStatus.canceled
                                      ? theme.colorScheme.error
                                      : theme.colorScheme.primary,
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            DateFormat('d MMM y')
                                                .format(currentItem.dateTime)
                                                .toString(),
                                            style: theme.textTheme.headline6
                                                ?.copyWith(
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            DateFormat('kk:mm a')
                                                .format(currentItem.dateTime)
                                                .toString(),
                                            // style: theme.textTheme.headline6,
                                            style: theme.textTheme.headline6
                                                ?.copyWith(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: screenWidth * 0.4,
                                        child: Text(
                                          currentItem.vehicleService.shopName,
                                          style: theme.textTheme.headline6
                                              ?.copyWith(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            'PKR : ${currentItem.vehicleService.cost}',
                                            style: theme.textTheme.headline6
                                                ?.copyWith(
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            ' ${currentItem.serviceRequestStatus.getName()}',
                                            style: theme.textTheme.headline6
                                                ?.copyWith(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                      ],
                    );
                  }
                }
              });
        }),
      ],
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
  SingleVehicleWidget({
    Key? key,
    required this.currentItem,
    required this.theme,
  }) : super(key: key);

  final Vehicle currentItem;
  final ThemeData theme;
  final AvailableShopStore _availableShopStore = getIt<AvailableShopStore>();

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(currentItem.id),
      direction: DismissDirection.endToStart,
      onDismissed: (DismissDirection dismissDirection) {},
      child: customCard(
        child: InkWell(
          onTap: () {
            _availableShopStore.updateSelectedVehicle(currentItem);
            Navigator.of(context).pushNamed(AvailableShopsScreen.routeName);
          },
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(150),
              child: buildImage(theme, currentItem.vehicleImages.first,
                  height: 50, width: 50),
            ),
            title: Text(currentItem.vehicleModel),
            subtitle: Text(currentItem.vehicleCompany),
            trailing: Text(currentItem.vehicleType.getName()),
          ),
        ),
      ),
    );
  }
}

Future<void> findService(
    BuildContext context,
    ThemeData theme,
    ServiceType serviceType,
    ManageVehicleStore manageVehicleStore,
    AvailableShopStore availableShopStore) async {
  availableShopStore.updateSelectedServiceType(serviceType);
  //pop services sheet
  Navigator.of(context).pop();
  await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                const SizedBox(height: 10),
                Text(
                  'Select a vehicle',
                  style: theme.textTheme.headline3,
                ),
                const SizedBox(height: 20),
                VehicleList(
                    theme: theme, manageVehicleStore: manageVehicleStore),
              ],
            ),
          ),
        );
      });

  Navigator.of(context).pushNamed(AvailableShopsScreen.routeName);
}
