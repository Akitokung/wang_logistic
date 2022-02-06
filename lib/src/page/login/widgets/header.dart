import 'package:flutter/material.dart';
import 'package:wang_logistic/src/constants/setting.dart';

class Header extends StatelessWidget {
  const Header({Key? key, required this.title, required this.subtitle})
      : super(key: key);

  final String title, subtitle;

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
          width: 80.0,
          height: 1.0,
        );

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          line(gradientColor),
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 24.0,
                    color: Setting.themeColorTitle,
                  ),
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Setting.themeColorSubtitle,
                ),
              ),
            ],
          ),
          line(gradientColor.reversed.toList()),
        ],
      ),
    );
  }
}
