import 'package:app_30_car_service_app/ui/home/available_shops_screen.dart';
import 'package:intl/intl.dart';

import '../../custom_widgets/custom_wrappers.dart';
import 'package:flutter/material.dart';
//Theme
import '../../theme/my_app_colors.dart';
import '../../resources/app_images.dart';

//UI
import '../../ui/auth/login_screen.dart';
import '../../ui/chatbox/chat_screen.dart';

import 'package:app_30_car_service_app/service_locator.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  static const routeName = '/home-screen';

  //Theme
  final AppColors _appColor = getIt<AppColors>();

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
                      Navigator.of(context).pushNamed(ChatScreen.routeName);
                    },
                    icon: const Icon(Icons.email_outlined)),
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
                ProfileWidget(theme: theme),
                const SizedBox(height: 20),
                BookingStats(theme: theme),
                const SizedBox(height: 20),
                ServiceTabs(screenWidth: screenWidth, theme: theme),
                const SizedBox(height: 20),
                Column(
                  children: [
                    Text(
                      'History',
                      style: theme.textTheme.headline3,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: customContainer(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      DateFormat('d MMM y')
                                          .format(DateTime.now())
                                          .toString(),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      DateFormat('kk:mm')
                                          .format(DateTime.now())
                                          .toString(),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: screenWidth * 0.4,
                                  child: Text(
                                      'Shop Nameasl alskd fjals dflsjdf alskd falskdjf aslkdjf'),
                                ),
                                Text('PKR : 1590')
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
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

                      const Text('Tyre Shop'),
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
  const BookingStats({Key? key, required this.theme}) : super(key: key);
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return customContainer(
        height: 100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '1',
                      style: theme.textTheme.headline3,
                    ),
                    Text(
                      'Cars',
                      style: theme.textTheme.headline4,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '1',
                      style: theme.textTheme.headline3,
                    ),
                    Text(
                      'Bookings',
                      style: theme.textTheme.headline4,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '1',
                      style: theme.textTheme.headline3,
                    ),
                    Text(
                      'Reviews',
                      style: theme.textTheme.headline4,
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
  const ProfileWidget({Key? key, required this.theme}) : super(key: key);
  final ThemeData theme;
  @override
  Widget build(BuildContext context) {
    return customContainer(
      height: 120,
      child: Row(
        children: [
          const Expanded(
              child: CircleAvatar(
            radius: 50,
            // child: Image.asset(appLogo),
            child: Icon(
              Icons.person,
              size: 40,
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
    );
  }
}
