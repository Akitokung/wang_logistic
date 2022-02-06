import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wang_logistic/src/viewmodels/single_sign_on_view_model.dart';

class SingleSignOn extends StatefulWidget {
  const SingleSignOn({Key? key}) : super(key: key);

  @override
  State<SingleSignOn> createState() => _SingleSignOnState();
}

class _SingleSignOnState extends State<SingleSignOn> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSingleSignOnButton(),
      ],
    );
  }

  Padding _buildSingleSignOnButton() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: SingleSignOnViewModel()
              .items
              .map(
                (item) => FloatingActionButton(
                  heroTag: item.icon.toString(),
                  onPressed: item.onPress,
                  backgroundColor: item.backgroundColor,
                  child: FaIcon(
                    item.icon,
                    color: Colors.red,
                    size: 32,
                  ),
                  elevation: 20,
                ),
              )
              .toList(),
        ),
      );
}
