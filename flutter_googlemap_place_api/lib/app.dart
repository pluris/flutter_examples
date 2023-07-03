import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_googlemap_place_api/presentation/view/google_map_screen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    _onAppResumed(state);
  }

  void _onAppResumed(AppLifecycleState state) async {
    var locationPermission = await Geolocator.checkPermission();
    if (state == AppLifecycleState.resumed) {
      //**Refer to this link for permission handling: https://davidserrano.io/best-way-to-handle-permissions-in-your-flutter-app
      //** FOR IOS
      if (Platform.isIOS) {
        if (locationPermission == LocationPermission.always ||
            locationPermission == LocationPermission.whileInUse) {
        } else {
          await Geolocator.checkPermission();
        }
        //** FOR ANDROID
      } else if (Platform.isAndroid) {
        if (locationPermission == LocationPermission.always ||
            locationPermission == LocationPermission.whileInUse) {
        } else {}
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(),
        primarySwatch: Colors.blue,
      ),
      home: const GoogleMapScreen(),
    );
  }
}
