import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wang_logistic/src/models/user_location.dart';
import 'package:wang_logistic/src/page/login/login_page.dart';
import 'package:wang_logistic/src/services/location_service.dart';

import 'constants/setting.dart';
import 'package:wang_logistic/src/page/home/home_page.dart';
import 'package:wang_logistic/src/page/splash/splash_page.dart';
import 'package:wang_logistic/src/models/provider/profile_emp.dart';

import 'models/user_location.dart';


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // lock screen แนวตั้ง
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MultiProvider(
      providers: [
        StreamProvider<UserLocation>(
          initialData: UserLocation(),
          create: (_) => LocationService().locationStream,
        ),
        ChangeNotifierProvider<ProviderProfile>(
          create: (_) => ProviderProfile(),
        ),
      ],
      child: FutureBuilder(
        future: Init.instance.initialize(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          var empProfile = context.read<ProviderProfile>();
          empProfile.empProfice();

          if (snapshot.connectionState == ConnectionState.waiting) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Wangpharmacy',
              theme: ThemeData(
                fontFamily: Setting.themeFont,
                primarySwatch: Setting.themeColor,
              ),
              home: FutureBuilder<SharedPreferences>(
                future: SharedPreferences.getInstance(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final token = snapshot.data!.getString(Setting.token) ?? '';
                    if (token.isNotEmpty) {
                      return const HomePage();
                    }
                    return const SplashPage();
                  }
                  return const SizedBox();
                },
              ),
            );
          } else {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Wangpharmacy',
              theme: ThemeData(
                // fontFamily: 'K2D',
                fontFamily: Setting.themeFont,
                primarySwatch: Setting.themeColor,
              ),
              home: FutureBuilder<SharedPreferences>(
                future: SharedPreferences.getInstance(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final token = snapshot.data!.getString(Setting.token) ?? '';
                    if (token.isNotEmpty) {
                      return const HomePage();
                    }
                    return const LoginPage();
                  }
                  return const SizedBox();
                },
              ),
            );
          }
        },
      ),
    );
  }
}
