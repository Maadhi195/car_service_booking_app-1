import 'package:flutter/material.dart';
import '../../theme/my_app_colors.dart';
import '../../service_locator.dart';

//Theme
final AppColors _appColor = getIt<AppColors>();

Widget customContainer(
    {double? height,
    double? width,
    required Widget child,
    EdgeInsetsGeometry? padding}) {
  return Container(
    height: height,
    width: width,
    padding: padding,
    clipBehavior: Clip.hardEdge,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: _appColor.accentColorLight,
        boxShadow: const [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 2,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ]),
    child: child,
  );
}

Widget customImageBox(double width, ThemeData _theme,
    {required String image,
    required String title,
    double? price,
    Function()? onTap}) {
  return InkWell(
    onTap: onTap,
    child: customContainer(
      child: Column(
        children: [
          Image.asset(
            image,
            width: width * 0.9,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: _theme.textTheme.headline4,
          ),
          price != null
              ? Column(
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      '\$ $price',
                      style: _theme.textTheme.headline4,
                    ),
                  ],
                )
              : const SizedBox()
        ],
      ),
    ),
  );
}
