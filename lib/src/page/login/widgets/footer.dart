import 'package:flutter/material.dart';
import 'package:wang_logistic/src/constants/setting.dart';
import 'package:wang_logistic/src/page/login/widgets/single_sign_on.dart';

class Footer extends StatelessWidget {
  const Footer({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.detial,
  }) : super(key: key);

  final String title, subtitle, detial;

  @override
  Widget build(BuildContext context) {
    final gradientColor = [Colors.white10, Colors.white];
    // ignore: prefer_function_declarations_over_variables
    final line = (List<Color> colors) => Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: colors,
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: const [0.0, 1.0],
            ),
          ),
          width: 50.0,
          height: 1.0,
        );

    TextStyle _styledetial() => const TextStyle(
        fontWeight: FontWeight.normal, color: Setting.themeColorTitle);

    return Container(
      margin: const EdgeInsets.only(top: 38, bottom: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              line(gradientColor),
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Setting.themeColorTitle,
                      ),
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Setting.themeColorSubtitle,
                    ),
                  ),
                ],
              ),
              line(gradientColor.reversed.toList()),
            ],
          ),
          const SizedBox(height: 28),
          const SingleSignOn(),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(Setting.company_address, style: _styledetial()),
                  Text(Setting.company_address2, style: _styledetial()),
                  Text(Setting.company_operatingtime, style: _styledetial()),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
