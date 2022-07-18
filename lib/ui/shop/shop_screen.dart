import 'package:app_30_car_service_app/ui/shop/service_booking_screen.dart';
import 'package:flutter/material.dart';
import '../../resources/app_images.dart';
import '../../theme/dark_theme.dart';
import '../../custom_widgets/custom_wrappers.dart';
import '../chatbox/chat_screen.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({Key? key}) : super(key: key);
  static const routeName = '/shop-screen';

  //UI variables
  final double rating = 4.5;
  final int reviewsCount = 703;

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                fullCarWashServiceImage,
                width: double.infinity,
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Perfect Car Services',
                          style: theme.textTheme.headline3,
                        ),
                        const Expanded(child: SizedBox()),
                        // const Icon(Icons.favorite_border),
                        // IconButton(
                        //     onPressed: () => Navigator.pushNamed(
                        //         context, ChatScreen.routeName),
                        //     icon: const Icon(Icons.chat)),
                        const SizedBox(width: 10),
                        const Icon(Icons.location_on_sharp),
                        const SizedBox(width: 10),
                        const Icon(Icons.phone),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '11th downing street, emblem avenue, south park, london',
                              softWrap: true,
                              style: theme.textTheme.headline5,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  rating.toString(),
                                  style: theme.textTheme.headline5,
                                ),
                                const SizedBox(width: 10.0),
                                const Icon(Icons.star),
                                const SizedBox(width: 10.0),
                                Text(
                                  '($reviewsCount Reviews)',
                                  style: theme.textTheme.headline5,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black38,
                            blurRadius: 1,
                            offset: Offset(0, 1), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                              child: Container(
                            color: theme.colorScheme.primary,
                            padding: const EdgeInsets.all(10.0),
                            child: Center(
                                child: Text(
                              'Services',
                              style: theme.textTheme.headline5,
                            )),
                          )),
                          Expanded(
                            child: Container(
                              color: theme.colorScheme.secondary,
                              padding: const EdgeInsets.all(10.0),
                              child: Center(
                                  child: Text(
                                'About',
                                style: theme.textTheme.headline5,
                              )),
                            ),
                          ),
                          Expanded(
                              child: Container(
                            color: theme.colorScheme.secondary,
                            padding: const EdgeInsets.all(10.0),
                            child: Center(
                                child: Text(
                              'Reviews',
                              style: theme.textTheme.headline5,
                            )),
                          )),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    _carWashServices(context, theme, screenWidth),
                    const SizedBox(height: 20),
                    _workshopServices(context, theme, screenWidth),
                    const SizedBox(height: 20),
                    _tyreServices(context, theme, screenWidth),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tyreServices(
      BuildContext context, ThemeData theme, double screenWidth) {
    return Column(
      children: [
        Text(
          'Tyre Shop',
          style: theme.textTheme.headline3,
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(child: Container()),
            customImageBox(
              screenWidth * 0.4,
              theme,
              image: carTyreChangeServiceImage,
              title: 'Tyre Change',
              price: 50,
              onTap: () {
                Navigator.of(context).pushNamed(ServiceBookingScreen.routeName);
              },
            ),
            const SizedBox(width: 20),
            customImageBox(
              screenWidth * 0.4,
              theme,
              image: carTyreRepairServiceImage,
              title: 'Tyre Repair',
              price: 25,
              onTap: () {
                Navigator.of(context).pushNamed(ServiceBookingScreen.routeName);
              },
            ),
            Expanded(child: Container()),
          ],
        ),
      ],
    );
  }

  Widget _workshopServices(
      BuildContext context, ThemeData theme, double screenWidth) {
    return Column(
      children: [
        Text(
          'Workshop Services',
          style: theme.textTheme.headline3,
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(child: Container()),
            customImageBox(
              screenWidth * 0.4,
              theme,
              image: oilChangeServiceImage,
              title: 'Oil Change',
              price: 50,
              onTap: () {
                Navigator.of(context).pushNamed(ServiceBookingScreen.routeName);
              },
            ),
            const SizedBox(width: 20),
            customImageBox(
              screenWidth * 0.4,
              theme,
              image: breakServiceImage,
              title: 'Break Service',
              price: 25,
              onTap: () {
                Navigator.of(context).pushNamed(ServiceBookingScreen.routeName);
              },
            ),
            Expanded(child: Container()),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(child: Container()),
            customImageBox(
              screenWidth * 0.4,
              theme,
              image: fullCarServiceImage,
              title: 'Full Car Service',
              price: 50,
              onTap: () {
                Navigator.of(context).pushNamed(ServiceBookingScreen.routeName);
              },
            ),
            const SizedBox(width: 20),
            customImageBox(
              screenWidth * 0.4,
              theme,
              image: batteryServiceImage,
              title: 'Battery Service',
              price: 25,
              onTap: () {
                Navigator.of(context).pushNamed(ServiceBookingScreen.routeName);
              },
            ),
            Expanded(child: Container()),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _carWashServices(
      BuildContext context, ThemeData theme, double screenWidth) {
    return Column(
      children: [
        Text(
          'Car Wash',
          style: theme.textTheme.headline3,
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(child: Container()),
            customImageBox(
              screenWidth * 0.4,
              theme,
              image: fullCarWashServiceImage,
              title: 'Full Car Wash',
              price: 50,
              onTap: () {
                Navigator.of(context).pushNamed(ServiceBookingScreen.routeName);
              },
            ),
            const SizedBox(width: 20),
            customImageBox(
              screenWidth * 0.4,
              theme,
              image: halfCarWashServiceImage,
              title: 'Half Car Wash',
              price: 25,
              onTap: () {
                Navigator.of(context).pushNamed(ServiceBookingScreen.routeName);
              },
            ),
            Expanded(child: Container()),
          ],
        ),
      ],
    );
  }
}
