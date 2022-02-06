import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:wang_logistic/src/constants/setting.dart';
import 'package:wang_logistic/src/page/login/widgets/footer.dart';
import 'package:wang_logistic/src/page/login/widgets/form.dart';
import 'package:wang_logistic/src/page/login/widgets/header.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool showbar = true;

  Future showStatusBar() {
    // showbar = showbar ? false : true;
    //
    // if (showbar) {
    //   return SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
    //       overlays: SystemUiOverlay.values);
    // } else {
    //   return SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
    //       overlays: []);
    // }
    return SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showStatusBar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Listener(
        onPointerDown: (_) {
          FocusScopeNode currentFocus = FocusScope.of(context);
          showStatusBar();
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.focusedChild?.unfocus();
          }
        },
        child: Container(
          decoration: const BoxDecoration(color: Color(0xFFff0000)),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(top: 38, bottom: 16),
                    child: Image.asset('assets/icon/icon.png', scale: 5),
                  ),
                  const Header(
                    title: Setting.app_name,
                    subtitle: Setting.company_nameEng,
                  ),
                  const LoginForm(),
                  const Footer(
                    title: Setting.company_nameTH,
                    subtitle: Setting.company_nameEng,
                    detial: Setting.company_address,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
