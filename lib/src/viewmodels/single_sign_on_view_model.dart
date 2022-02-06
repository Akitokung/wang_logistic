import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SingleSignOn {
  final IconData icon;
  final Color backgroundColor;
  final VoidCallback onPress;

  SingleSignOn({
    required this.icon,
    required this.backgroundColor,
    required this.onPress,
  });
}

class SingleSignOnViewModel {
  List<SingleSignOn> get items => <SingleSignOn>[
        SingleSignOn(
          icon: FontAwesomeIcons.googlePlusG,
          backgroundColor: Colors.grey.shade300,
          onPress: () {
            //todo
          },
        ),
        SingleSignOn(
          icon: FontAwesomeIcons.googlePlusG,
          backgroundColor: Colors.grey.shade300,
          onPress: () {
            //todo
          },
        ),
        SingleSignOn(
          icon: FontAwesomeIcons.googlePlusG,
          backgroundColor: Colors.grey.shade300,
          onPress: () {
            //todo
          },
        ),
        SingleSignOn(
          icon: FontAwesomeIcons.googlePlusG,
          backgroundColor: Colors.grey.shade300,
          onPress: () {
            //todo
          },
        ),
      ];
}
