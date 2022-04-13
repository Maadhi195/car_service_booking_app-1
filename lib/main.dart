import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

//Theme
import 'theme/light_theme.dart';
//Screens
import 'ui/auth/login_screen.dart';
import 'ui/auth/signup_screen.dart';
import 'ui/home/home_screen.dart';
import 'ui/home/available_shops_screen.dart';
import 'ui/chatbox/chat_screen.dart';
import 'ui/shop/shop_screen.dart';
import 'ui/shop/service_booking_screen.dart';

//etc
import 'service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  _setupLogging();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme(context),
      routes: {
        '/': (ctx) => HomeScreen(),
        LoginScreen.routeName: (ctx) => LoginScreen(),
        SignupScreen.routeName: (ctx) => SignupScreen(),
        HomeScreen.routeName: (ctx) => HomeScreen(),
        AvailableShopsScreen.routeName: (ctx) => const AvailableShopsScreen(),
        ChatScreen.routeName: (ctx) => const ChatScreen(),
        ShopScreen.routeName: (ctx) => const ShopScreen(),
        ServiceBookingScreen.routeName: (ctx) => const ServiceBookingScreen(),
      },
      onUnknownRoute: (settings) =>
          MaterialPageRoute(builder: (ctx) => LoginScreen()),
    );
  }
}

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}
