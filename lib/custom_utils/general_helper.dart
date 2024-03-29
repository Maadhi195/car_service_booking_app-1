import 'package:flutter/material.dart';

Future<void> delayFunction({int? miliseconds = 2000}) async {
  await Future.delayed(Duration(milliseconds: miliseconds ?? 2000), () {
    // Do something
  });
}

dynamic modalRouteHandler(BuildContext context) {
  final modalRoute = ModalRoute.of(context);
  dynamic routeData;
  if (modalRoute == null) {
    Navigator.of(context).pop();
  } else {
    final routeArguments = modalRoute.settings.arguments;
    if (routeArguments == null) {
      Navigator.of(context).pop();
    } else {
      routeData = routeArguments;
    }
  }
  return routeData;
}

push(context, widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

pushReplace(context, widget) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => widget));
}
