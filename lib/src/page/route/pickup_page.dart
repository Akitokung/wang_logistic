import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:wang_logistic/src/models/provider/profile_emp.dart';
import 'package:wang_logistic/src/page/route/tab2_inprocess_page.dart';
import 'package:wang_logistic/src/page/route/tab1_picking_page.dart';
import 'package:wang_logistic/src/page/route/tab3_self_page.dart';
import 'package:wang_logistic/src/services/network_service.dart';

class PickUpPage extends StatefulWidget {
  const PickUpPage({
    Key? key,
    required this.code,
    required this.name,
  }) : super(key: key);

  final String code;
  final String name;

  @override
  // ignore: no_logic_in_create_state
  State<PickUpPage> createState() => _PickUpPageState(code, name);
}

class _PickUpPageState extends State<PickUpPage> {
  late String code = '';
  late String name = '';
  late String cus = '';
  late String box = '';

  fetchLable() async {
    var raday = await NetworkService.getReadyShipping(code);
    setState(() {
      cus = raday.shCuss;
      box = raday.shBoxs;
    });
  }

  road() {
    List<Widget> childrenbody = [
      PickingPage(code: code, name: name, cus: cus, box: box),
      InProcessPage(code: code),
      SelfPage(code: code, name: name, cus: cus, box: box),
    ];
    return childrenbody;
  }

  _PickUpPageState(this.code, this.name);

  List<Tab> tabs = [
    Tab(
      child: Row(
        children: const <Widget>[
          Icon(Icons.list, size: 18, color: Colors.white),
          SizedBox(width: 8),
          Text('ต้องนำส่ง'),
        ],
      ),
    ),
    Tab(
      child: Row(
        children: const <Widget>[
          Icon(Icons.pending_actions, size: 18, color: Colors.white),
          SizedBox(width: 8),
          Text('จัดเสร็จ รอคิว'),
        ],
      ),
    ),
    Tab(
      child: Row(
        children: const <Widget>[
          Icon(Icons.baby_changing_station, size: 18, color: Colors.white),
          SizedBox(width: 8),
          Text('ลูกค้ารับเอง'),
        ],
      ),
    ),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchLable();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle _eshipStyle() => const TextStyle(
          fontSize: 12,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        );
    TextStyle _ereadyStyle() => const TextStyle(
          fontSize: 8,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        );

    final emp = Provider.of<ProviderProfile>(context);
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            // tooltip: "Cancel and Return to List",
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
          elevation: 10,
          leadingWidth: 32,
          automaticallyImplyLeading: false,
          // centerTitle: true,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '[ ${emp.empCode} ]   ${emp.empNickname}',
                    style: const TextStyle(fontSize: 14),
                  ),
                  Text('[ $name ]', style: const TextStyle(fontSize: 14)),
                ],
              ),
              Row(
                children: <Widget>[
                  const Text('นับแล้ว', style: TextStyle(fontSize: 12)),
                  const SizedBox(width: 12),
                  Text(emp.shippingShop, style: _eshipStyle()),
                  const SizedBox(width: 12),
                  const Text('ร้าน', style: TextStyle(fontSize: 12)),
                  const SizedBox(width: 12),
                  Text(emp.shippingBoxs, style: _eshipStyle()),
                  const SizedBox(width: 12),
                  const Text('ลัง', style: TextStyle(fontSize: 12)),
                ],
              ),
            ],
          ),
          actions: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    top: 3.0,
                    bottom: 2.0,
                    left: 8.0,
                    right: 8.0,
                  ),
                  child: Column(
                    children: <Widget>[
                      const Icon(Icons.add_business, size: 23),
                      Row(
                        children: <Widget>[
                          Text(cus, style: _ereadyStyle()),
                          const SizedBox(width: 6),
                          const Text(
                            ' ร้าน',
                            style:
                                TextStyle(fontSize: 8, color: Colors.black38),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 3.0,
                    bottom: 2.0,
                    left: 8.0,
                    right: 12,
                  ),
                  child: Column(
                    children: <Widget>[
                      const Icon(Icons.view_in_ar, size: 23),
                      Row(
                        children: <Widget>[
                          Text(box, style: _ereadyStyle()),
                          const SizedBox(width: 6),
                          const Text(
                            ' ลัง ',
                            style:
                                TextStyle(fontSize: 8, color: Colors.black38),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(30),
            child: TabBar(
              indicatorSize: TabBarIndicatorSize.label,
              isScrollable: true,
              indicatorWeight: 2,
              indicatorColor: Colors.black,
              tabs: tabs,
              unselectedLabelColor: Colors.white70,
            ),
          ),
        ),
        body: TabBarView(
          children: road(),
        ),
      ),
    );
  }
}
