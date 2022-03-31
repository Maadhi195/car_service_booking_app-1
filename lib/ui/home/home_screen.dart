import 'package:app_30_car_service_app/ui/home/available_shops_screen.dart';

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
    ThemeData _theme = Theme.of(context);
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
                _profileWidget(_theme),
                const SizedBox(height: 20),
                _bookingStats(_theme),
                const SizedBox(height: 20),
                _serviceTabs(context, screenWidth, _theme),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _serviceTabs(
      BuildContext context, double screenWidth, ThemeData _theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Services',
          style: _theme.textTheme.headline3,
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
                        return _carWashServices(context, _theme, screenWidth);
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
                        return _workshopServices(context, _theme, screenWidth);
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

                      const Text('Workshop'),
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
                        return _tyreShopServices(context, _theme, screenWidth);
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

  Widget _tyreShopServices(
      BuildContext context, ThemeData _theme, double screenWidth) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Text(
              'Tyre Shop',
              style: _theme.textTheme.headline3,
            ),
            const SizedBox(height: 20),
            customImageBox(
              screenWidth,
              _theme,
              image: carTyreChangeServiceImage,
              title: 'Tyre Change',
              onTap: () {
                Navigator.of(context).pushNamed(AvailableShopsScreen.routeName);
              },
            ),
            const SizedBox(height: 20),
            customImageBox(
              screenWidth,
              _theme,
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

  Widget _workshopServices(
      BuildContext context, ThemeData _theme, double screenWidth) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Text(
              'Workshop',
              style: _theme.textTheme.headline3,
            ),
            const SizedBox(height: 20),
            customImageBox(
              screenWidth,
              _theme,
              image: oilChangeServiceImage,
              title: 'Oil Change',
              onTap: () {
                Navigator.of(context).pushNamed(AvailableShopsScreen.routeName);
              },
            ),
            const SizedBox(height: 20),
            customImageBox(
              screenWidth,
              _theme,
              image: breakServiceImage,
              title: 'Break Service',
              onTap: () {
                Navigator.of(context).pushNamed(AvailableShopsScreen.routeName);
              },
            ),
            const SizedBox(height: 20),
            customImageBox(
              screenWidth,
              _theme,
              image: fullCarServiceImage,
              title: 'Car Service',
              onTap: () {
                Navigator.of(context).pushNamed(AvailableShopsScreen.routeName);
              },
            ),
            const SizedBox(height: 20),
            customImageBox(
              screenWidth,
              _theme,
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

  Widget _carWashServices(
      BuildContext context, ThemeData _theme, double screenWidth) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Text(
              'Car Wash',
              style: _theme.textTheme.headline3,
            ),
            const SizedBox(height: 20),
            customImageBox(
              screenWidth,
              _theme,
              image: halfCarWashServiceImage,
              title: 'Half Car Wash',
              onTap: () {
                Navigator.of(context).pushNamed(AvailableShopsScreen.routeName);
              },
            ),
            const SizedBox(height: 20),
            customImageBox(
              screenWidth,
              _theme,
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

  Widget _bookingStats(ThemeData _theme) {
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
                      style: _theme.textTheme.headline3,
                    ),
                    Text(
                      'Cars',
                      style: _theme.textTheme.headline4,
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
                      style: _theme.textTheme.headline3,
                    ),
                    Text(
                      'Bookings',
                      style: _theme.textTheme.headline4,
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
                      style: _theme.textTheme.headline3,
                    ),
                    Text(
                      'Reviews',
                      style: _theme.textTheme.headline4,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  Widget _profileWidget(ThemeData _theme) {
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
                    style: _theme.textTheme.headline3,
                  ),
                  Text(
                    '+923012345678',
                    style: _theme.textTheme.headline5,
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
