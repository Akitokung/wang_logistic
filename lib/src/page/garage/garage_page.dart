import 'package:flutter/material.dart';

class GaragePage extends StatefulWidget {
  const GaragePage({Key? key}) : super(key: key);

  @override
  _GaragePageState createState() => _GaragePageState();
}

class _GaragePageState extends State<GaragePage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('กรมการขนส่งทางบก'),
    );
  }
}
