import 'package:flutter/material.dart';

class ChecklistPage extends StatefulWidget {
  const ChecklistPage({Key? key}) : super(key: key);

  @override
  _ChecklistPageState createState() => _ChecklistPageState();
}

class _ChecklistPageState extends State<ChecklistPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('ตรวจสภาพ'),
    );
  }
}
