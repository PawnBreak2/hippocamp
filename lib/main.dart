import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hippocapp/constants/navigation/navigation_configuration.dart';
import 'package:hippocapp/storage/local_storage.dart';
import 'package:hippocapp/styles/colors.dart';

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
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        alwaysUse24HourFormat: false,
      ),
      child: ResponsiveSizer(builder: (context, orientation, screenType) {
        return MaterialApp.router(
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            Locale('it'),
          ],
          routerConfig: NavigationConfiguration.routes,
          title: 'hippocapp',
          theme: ThemeData(
            floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: Colors.white,
                foregroundColor: CustomColors.lightRed,
                shape: CircleBorder()),
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
      }),
    );
  }
}
