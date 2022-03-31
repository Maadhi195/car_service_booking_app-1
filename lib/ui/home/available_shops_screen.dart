import 'package:app_30_car_service_app/ui/shop/shop_screen.dart';

import '../../custom_widgets/custom_wrappers.dart';
import '../../resources/app_images.dart';
import 'package:flutter/material.dart';

class AvailableShopsScreen extends StatelessWidget {
  const AvailableShopsScreen({Key? key}) : super(key: key);

  static const routeName = '/available-shops-screen';

  @override
  Widget build(BuildContext context) {
    //ThemeData & constraints
    ThemeData _theme = Theme.of(context);
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Car Shop'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                const SizedBox(height: 10),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  itemBuilder: (ctx, index) =>
                      _availableShopItem(context, _theme),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _availableShopItem(BuildContext context, ThemeData _theme) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(ShopScreen.routeName);
      },
      child: Column(
        children: [
          customContainer(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Image.asset(
                        carTyreChangeServiceImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Shop Name',
                              style: _theme.textTheme.headline4,
                            ),
                            const SizedBox(height: 5.0),
                            const Text(
                              '11th downing street, emblem avenue, south park, london',
                              softWrap: true,
                            ),
                            const SizedBox(height: 5.0),
                            Row(
                              children: const [
                                Icon(Icons.star),
                                Icon(Icons.star),
                                Icon(Icons.star),
                                Icon(Icons.star),
                              ],
                            ),
                            const SizedBox(height: 5.0),
                          ],
                        )),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
