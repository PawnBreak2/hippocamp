import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hippocamp/constants/navigation/navigation_configuration.dart';
import 'package:hippocamp/pages/login/login_page.dart';
import 'package:hippocamp/storage/local_storage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'constants/storage_keys.dart';

void main() {
  runApp(ProviderScope(
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  bool isLogged = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void checkIfUserIsLoggedIn() {
    setState(() async {
      isLogged = await LocalStorage.readString(StorageKeys.isLogged) == "true";
      print('isLogged');
      print(isLogged);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return MaterialApp.router(
        routerConfig: NavigationConfiguration.routes,
        title: 'Hippocamp',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
      );
    });
  }
}
