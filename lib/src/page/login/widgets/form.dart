import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:another_flushbar/flushbar.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wang_logistic/src/constants/api.dart';
import 'package:wang_logistic/src/constants/setting.dart';
import 'package:wang_logistic/src/models/provider/profile_emp.dart';
import 'package:wang_logistic/src/page/home/home_page.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late TextEditingController usernameController;
  late TextEditingController passwordController;

  late String _errorUsername;
  late String _errorPassword;

  @override
  void initState() {
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    _errorUsername = '';
    _errorPassword = '';
    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FormInput(
          usernameController: usernameController,
          passwordController: passwordController,
          errorUsername: _errorUsername,
          errorPassword: _errorPassword,
        ),
        _buildSubmitFormButton(title: 'เข้าสู่ระบบ'),
      ],
    );
  }

  Container _buildSubmitFormButton({title}) => Container(
        margin: const EdgeInsets.only(top: 3),
        //width: double.infinity,
        width: 220,
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(color: Setting.themeColorTitle),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        alignment: Alignment.center,
        // ignore: deprecated_member_use
        child: FlatButton(
          onPressed: _onLogin,
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              color: Setting.themeColorTitle,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      );

  void showAlertBar() {
    Flushbar(
      title: 'Username or Password is incorrect',
      message: 'Please try again.',
      icon: const Icon(Icons.error, size: 28.0, color: Colors.red),
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(8),
      borderRadius: const BorderRadius.all(Radius.circular(8)),
    ).show(context);
  }

  void showLoading() {
    // ignore: avoid_single_cascade_in_expression_statements
    Flushbar(
      message: 'Loading...',
      showProgressIndicator: true,
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.GROUNDED,
    )..show(context);
  }

  void _onLogin() {
    String username = usernameController.text;
    String password = passwordController.text;

    _errorUsername = '';
    _errorPassword = '';

    // print('Username : ' + username);
    // print('Password : ' + password);
    if ((username == '') ||
        // ignore: unnecessary_null_comparison
        (username == null) ||
        (password == '') ||
        // ignore: unnecessary_null_comparison
        (password == null)) {
      // ignore: unnecessary_null_comparison
      if ((username == '') || (username == null)) {
        _errorUsername = 'กรุณากรอก ชื่อบัญชีผู้ใช้ เพื่อเข้าสู่ระบบ';
      }
      // ignore: unnecessary_null_comparison
      if ((password == '') || (password == null)) {
        _errorPassword = 'กรุณากรอก รหัสผ่าน เพื่อเข้าสู่ระบบ';
      }
      // ignore: unnecessary_null_comparison
      if (((username == '') || (username == null)) &&
          // ignore: unnecessary_null_comparison
          ((password == '') || (password == null))) {
        _errorUsername = 'กรุณากรอก ชื่อบัญชีผู้ใช้ เพื่อเข้าสู่ระบบ';
        _errorPassword = 'กรุณากรอก รหัสผ่าน เพื่อเข้าสู่ระบบ';
      }
      setState(() {});
    } else {
      if (username.length != 4) {
        _errorUsername = 'ชื่อบัญชีผู้ใช้ 4 หลัก';
      }
      if (password.length != 4) {
        _errorPassword = 'รหัสผ่าน 4 หลัก';
      }
      // ignore: unnecessary_null_comparison
      if ((_errorUsername == null && _errorPassword == null) ||
          (_errorUsername == '' && _errorPassword == '')) {
        showLoading();
        Future.delayed(const Duration(seconds: 2)).then((value) async {
          Navigator.pop(context);
          Map data = {'Username': username, 'Password': password};
          // print(data.toString());
          // ignore: unnecessary_string_interpolations
          var url = Uri.https('${API.API_URL}', '${API.API_LOGIN}');
          // print(url);
          final response = await http.post(
            url,
            headers: {
              "Accept": "application/json charset=UTF-8",
              "Content-Type": "application/x-www-form-urlencoded"
            },
            body: data,
          );
          if (response.statusCode == 200) {
            var resposne =
                convert.jsonDecode(response.body) as Map<String, dynamic>;
            var token = resposne['token'];
            if (!resposne['error']) {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setString(Setting.token, token); // เก็บค่า
              prefs.setString(Setting.emp_code, username); // เก็บค่า
              var empProfile = context.read<ProviderProfile>();
              empProfile.empProfice();

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            } else if (response.statusCode == 404) {
              showAlertBar();
              setState(() {});
            }
          } else {
            showAlertBar();
            setState(() {});
          }
        });
      } else {
        showAlertBar();
        setState(() {});
      }
    }
  }
}

class FormInput extends StatefulWidget {
  final TextEditingController usernameController;
  final TextEditingController passwordController;

  final String errorUsername;
  final String errorPassword;

  const FormInput({
    Key? key,
    required this.usernameController,
    required this.passwordController,
    required this.errorUsername,
    required this.errorPassword,
  }) : super(key: key);

  @override
  State<FormInput> createState() => _FormInputState();
}

class _FormInputState extends State<FormInput> {
  bool showPass = true;

  late bool _obscureTextPassword;
  final _passwordFocusNode = FocusNode();

  @override
  void initState() {
    _obscureTextPassword = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 0, bottom: 0, left: 28, right: 28),
        child: Column(
          children: <Widget>[
            _buildUsername(
              input: widget.usernameController,
              lable: 'Username',
              hint: 'ชื่อบัญชีผู้ใช้ / Username',
              icon: Icons.account_circle,
              error: widget.errorUsername,
            ),
            _buildPassword(
              input: widget.passwordController,
              lable: 'Password',
              hint: 'รหัสผ่าน / Password',
              icon: Icons.lock,
              error: widget.errorPassword,
            ),
          ],
        ),
      ),
    );
  }

  TextStyle _lebleStyle() => const TextStyle(
      fontWeight: FontWeight.w500, color: Setting.themeColorTitle);

  TextStyle _hintStyle() => const TextStyle(
      fontWeight: FontWeight.normal, color: Setting.themeColorSubtitle);

  Container _buildUsername({input, hint, icon, lable, error}) {
    return Container(
      margin: const EdgeInsets.only(top: 3, bottom: 3),
      padding: const EdgeInsets.all(0),
      child: TextField(
        focusNode: _passwordFocusNode,
        controller: input,
        autofocus: false,
        obscureText: false,
        // รูปแบบ password *****
        //keyboardType: TextInputType.emailAddress,
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.next,
        //initialValue: 'abc',
        decoration: InputDecoration(
          labelText: lable,
          labelStyle: _lebleStyle(),
          //counterText: '0 characters',
          //contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          //filled: true,
          //fillColor: Colors.white,
          hintText: hint,
          hintStyle: _hintStyle(),
          errorText: widget.errorUsername,
          errorStyle: const TextStyle(color: Colors.black, wordSpacing: 3.0),
          prefixIcon: Icon(icon, color: Setting.themeColorIcon, size: 36),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(width: 1),
          ),
          // onfocus_input required=""
          errorBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(
              width: 1,
              color: error.isEmpty ? Setting.themeColorTitle : Colors.red,
            ),
          ),
          // onfocus_input
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(
              width: 1,
              color: error.isEmpty ? Setting.themeColorSubtitle : Colors.red,
            ),
          ),
        ),
        cursorColor: Colors.white,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  Container _buildPassword({input, hint, icon, lable, error}) {
    return Container(
      //margin: EdgeInsets.only(top: 20),
      margin: const EdgeInsets.only(top: 3, bottom: 3),
      padding: const EdgeInsets.all(0),
      child: TextField(
        controller: input,
        autofocus: false,
        // obscureText: true, // รูปแบบ password *****
        obscureText: _obscureTextPassword,
        //keyboardType: TextInputType.emailAddress,
        keyboardType: TextInputType.number,
        //textInputAction: TextInputAction.next,
        //initialValue: 'abc',
        decoration: InputDecoration(
          labelText: lable,
          labelStyle: _lebleStyle(),
          hintText: hint,
          hintStyle: _hintStyle(),
          errorText: widget.errorPassword,
          errorStyle: const TextStyle(color: Colors.black, wordSpacing: 3.0),
          prefixIcon: Icon(icon, color: Setting.themeColorIcon, size: 36),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                _obscureTextPassword = !_obscureTextPassword;
              });
            },
            child: Icon(
              _obscureTextPassword ? Icons.visibility_off : Icons.visibility,
              color: Setting.themeColorIcon,
            ),
          ),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(width: 1)),
          // onfocus_input required=""
          errorBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(
              width: 1,
              color: error.isEmpty ? Setting.themeColorTitle : Colors.red,
            ),
          ),
          // onfocus_input
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(
              width: 1,
              color: error.isEmpty ? Setting.themeColorSubtitle : Colors.red,
            ),
          ),
        ),
        cursorColor: Colors.white,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white),
        onSubmitted: (String value) {
          FocusScope.of(context).requestFocus(_passwordFocusNode);
        },
      ),
    );
  }
}
