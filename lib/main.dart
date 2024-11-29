import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:onesignal/firebase_options.dart';
import 'package:onesignal/homeView.dart';
import 'package:onesignal/item_page.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.initialize("e546cf91-4be0-4be0-bb2b-6f4cc7e04ec8");
  OneSignal.Notifications.requestPermission(true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    // Add listener for notification click
    OneSignal.Notifications.addClickListener((event) {
      final screen = event.notification.additionalData?["screen"];
      if (screen != null) {
        navigatorKey.currentState?.pushNamed(screen);
      }
    });

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      initialRoute: "/",
      routes: {
        "/": (context) => const HomeView(),
        "/item_page": (context) => const ItemPage(),
      },
      theme: ThemeData.light(useMaterial3: true),
    );
  }
}
