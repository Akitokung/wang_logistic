import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wang_logistic/src/constants/setting.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool showbar = true;
  Future showStatusBar() {
    showbar = showbar ? false:true;
    if (showbar) {return SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);}
    else {return SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);}
    // return SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showStatusBar();
  }

  @override
  Widget build(BuildContext context) {
    bool lightMode =
        MediaQuery.of(context).platformBrightness == Brightness.light;
    return Scaffold(
      backgroundColor: lightMode
          ? const Color(0xFFff0000).withOpacity(1.0)
          : const Color(0xFFff0000).withOpacity(1.0),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            lightMode
                ? Image.asset('assets/icon/icon.png', scale: 3)
                : Image.asset('assets/images/splash-icon.png'),
            const SizedBox(
              height: 20,
            ),
            const Text(
              Setting.app_name,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const Text(
              Setting.app_subname,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Init {
  Init._();
  static final instance = Init._();
  Future initialize() async {
    await Future.delayed(const Duration(seconds: 3));
  }
}
