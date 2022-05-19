import 'package:intl/intl.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../custom_widgets/custom_wrappers.dart';
import 'package:flutter/material.dart';
//Theme
import '../../stores/book_service_store.dart';
import '../../stores/manage_vehicle_store.dart';
import '../../stores/user_profile_screen_store.dart';
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

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  static const routeName = '/home-screen';

  //Theme
  final AppColors _appColor = getIt<AppColors>();

  //Stores
  final HomeScreenStore _homeScreenStore = getIt<HomeScreenStore>();
  final UserProfileScreenStore _userProfileScreenStore =
      getIt<UserProfileScreenStore>();
  final ManageVehicleStore _manageVehicleStore = getIt<ManageVehicleStore>();
  final BookServiceStore _bookServiceStore = getIt<BookServiceStore>();

  @override
  Widget build(BuildContext context) {
    //ThemeData & constraints
    ThemeData theme = Theme.of(context);
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
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
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed(LoginScreen.routeName);
                    },
                    icon: const Icon(Icons.logout)),
              ],
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                ProfileWidget(
                    theme: theme,
                    userProfileScreenStore: _userProfileScreenStore),
                const SizedBox(height: 20),
                BookingStats(
                    theme: theme,
                    homeScreenStore: _homeScreenStore,
                    manageVehicleStore: _manageVehicleStore,
                    bookServiceStore: _bookServiceStore),
                const SizedBox(height: 20),
                ServiceTabs(screenWidth: screenWidth, theme: theme),
                const SizedBox(height: 20),
                BookingHistoryList(
                    screenWidth: screenWidth,
                    theme: theme,
                    homeScreenStore: _homeScreenStore),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () =>
              Navigator.of(context).pushNamed(AddNewVehicleScreen.routeName),
          backgroundColor: theme.colorScheme.primary,
          foregroundColor: theme.colorScheme.secondary,
          label: const Text('Add Vehicle'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}

class ServiceTabs extends StatelessWidget {
  const ServiceTabs({Key? key, required this.theme, required this.screenWidth})
      : super(key: key);
  final ThemeData theme;
  final double screenWidth;

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
                            theme: theme, screenWidth: screenWidth);
                      });
                },
                child: customContainer(
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
                            theme: theme, screenWidth: screenWidth);
                      });
                },
                child: customContainer(
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
                            theme: theme, screenWidth: screenWidth);
                      });
                },
                child: customContainer(
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
      {Key? key, required this.theme, required this.screenWidth})
      : super(key: key);
  final ThemeData theme;
  final double screenWidth;

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
              onTap: () {
                Navigator.of(context).pushNamed(AvailableShopsScreen.routeName);
              },
            ),
            const SizedBox(height: 20),
            customImageBox(
              screenWidth,
              theme,
              image: carTyreRepairServiceImage,
              title: 'Tyre Repair',
              onTap: () {
                Navigator.of(context).pushNamed(AvailableShopsScreen.routeName);
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
      {Key? key, required this.theme, required this.screenWidth})
      : super(key: key);
  final ThemeData theme;
  final double screenWidth;

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
              onTap: () {
                Navigator.of(context).pushNamed(AvailableShopsScreen.routeName);
              },
            ),
            const SizedBox(height: 20),
            customImageBox(
              screenWidth,
              theme,
              image: breakServiceImage,
              title: 'Break Service',
              onTap: () {
                Navigator.of(context).pushNamed(AvailableShopsScreen.routeName);
              },
            ),
            const SizedBox(height: 20),
            customImageBox(
              screenWidth,
              theme,
              image: fullCarServiceImage,
              title: 'Car Service',
              onTap: () {
                Navigator.of(context).pushNamed(AvailableShopsScreen.routeName);
              },
            ),
            const SizedBox(height: 20),
            customImageBox(
              screenWidth,
              theme,
              image: batteryServiceImage,
              title: 'Battery Issue',
              onTap: () {
                Navigator.of(context).pushNamed(AvailableShopsScreen.routeName);
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
      {Key? key, required this.theme, required this.screenWidth})
      : super(key: key);
  final ThemeData theme;
  final double screenWidth;

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
              onTap: () {
                Navigator.of(context).pushNamed(AvailableShopsScreen.routeName);
              },
            ),
            const SizedBox(height: 20),
            customImageBox(
              screenWidth,
              theme,
              image: fullCarWashServiceImage,
              title: 'Full Car Wash',
              onTap: () {
                Navigator.of(context).pushNamed(AvailableShopsScreen.routeName);
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
    return customContainer(
        height: 100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: InkWell(
                onTap: () => Navigator.of(context)
                    .pushNamed(UserVehicleListScreen.routeName),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        manageVehicleStore.userVehicleList.length.toString(),
                        style: theme.textTheme.headline4,
                      ),
                      Text(
                        'Vehicles',
                        style: theme.textTheme.headline5,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: InkWell(
                  onTap: () =>
                      Navigator.of(context).pushNamed(BookingsScreen.routeName),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Observer(builder: (_) {
                        return Text(
                          bookServiceStore.serviceRequestList.length.toString(),
                          style: theme.textTheme.headline4,
                        );
                      }),
                      Text(
                        'Bookings',
                        style: theme.textTheme.headline5,
                      ),
                    ],
                  ),
                ),
              ),
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

class ProfileWidget extends StatelessWidget {
  const ProfileWidget(
      {Key? key, required this.theme, required this.userProfileScreenStore})
      : super(key: key);
  final ThemeData theme;
  final UserProfileScreenStore userProfileScreenStore;
  @override
  Widget build(BuildContext context) {
    return customContainer(
      height: 120,
      child: InkWell(
        onTap: () =>
            Navigator.of(context).pushNamed(UserProfileScreen.routeName),
        child: Row(
          children: [
            const SizedBox(width: 10),
            Expanded(
                child: CircleAvatar(
              radius: 50,
              // child: Image.asset(appLogo),
              child: DisplayImage(
                imagePath: userProfileScreenStore.user.userImage,
                onPressed: () {},
              ),
            )),
            Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Hammad',
                      style: theme.textTheme.headline3,
                    ),
                    Text(
                      '+923012345678',
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
  }) : super(key: key);
  //UI
  final double screenWidth;
  final ThemeData theme;

  //Stores
  final HomeScreenStore homeScreenStore;

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
          return homeScreenStore.bookingHistoryList.isEmpty
              ? Text(
                  'No Record Found',
                  style: theme.textTheme.headline4,
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: homeScreenStore.bookingHistoryList.length,
                  itemBuilder: (context, index) => Column(
                        children: [
                          Row(
                            key: ValueKey(
                                homeScreenStore.bookingHistoryList[index]),
                            children: [
                              Expanded(
                                child: customContainer(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            DateFormat('d MMM y')
                                                .format(DateTime.now())
                                                .toString(),
                                            // style: theme.textTheme.headline6,
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            DateFormat('kk:mm a')
                                                .format(DateTime.now())
                                                .toString(),
                                            // style: theme.textTheme.headline6,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: screenWidth * 0.4,
                                        child: Text(
                                          'Shop Name',
                                          style: theme.textTheme.headline6,
                                        ),
                                      ),
                                      const Text('PKR : 1590'),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                        ],
                      ));
        }),
      ],
    );
  }
}
