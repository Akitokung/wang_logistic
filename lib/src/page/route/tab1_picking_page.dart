import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: implementation_imports
import 'package:provider/src/provider.dart';
import 'package:wang_logistic/src/models/picking.dart';
import 'package:wang_logistic/src/page/route/widgets/imgcarout_page.dart';
import 'package:wang_logistic/src/services/network_service.dart';
import 'package:wang_logistic/src/models/provider/profile_emp.dart';
import 'package:wang_logistic/src/page/route/widgets/pickingbox_page.dart';

class PickingPage extends StatefulWidget {
  const PickingPage(
      {Key? key,
      required this.code,
      required this.name,
      required this.cus,
      required this.box})
      : super(key: key);
  final String code;
  final String name;
  final String cus;
  final String box;

  @override
  // ignore: no_logic_in_create_state
  State<PickingPage> createState() => _PickingPageState(code);
}

class _PickingPageState extends State<PickingPage> {
  String code;
  bool alive = true;

  _PickingPageState(this.code);

  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  // void _showSnackBar(String message) {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(content: Text(message)),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      // backgroundColor: Colors.grey.shade200,
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {});
        },
        child: _buildNetwork(code),
      ),
    );
  }

  FutureBuilder<List<Picking>> _buildNetwork(String code) {
    return FutureBuilder<List<Picking>>(
      future: NetworkService().getPicking(code),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Picking>? data = snapshot.data;
          if (data == null || data.isEmpty) {
            return Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/bg-image.png"),
                  scale: 1.7,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 200),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 64.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Wang',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 18),
                          Text(
                            'Enterprise',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        top: 10, bottom: 18, left: 18, right: 18),
                    width: 220,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.lightBlue,
                        padding: const EdgeInsets.all(8),
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(FontAwesomeIcons.shippingFast),
                          SizedBox(width: 16),
                          Text('ออกเดินทาง'),
                        ],
                      ),
                      onPressed: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ImgcarOut(
                              rcode: widget.code,
                              rname: widget.name,
                            ),
                          ),
                        )
                      },
                    ),
                  ),
                ],
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: () async {
              setState(() {
                var empProfile = context.read<ProviderProfile>();
                empProfile.empProfice();
              });
            },
            child: Container(
              margin: const EdgeInsets.only(top: 4),
              child: _buildCardBlock(data),
            ),
          );
        }
        if (snapshot.hasError) {
          return Container(
            margin: const EdgeInsets.only(top: 22),
            alignment: Alignment.topCenter,
            child: Text((snapshot.error as DioError).message),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _buildCardBlock(List<Picking> data) {
    return Scrollbar(
      isAlwaysShown: true,
      showTrackOnHover: false,
      child: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          Picking result = data[index];
          // final GlobalKey<ExpansionTileCardState> card = GlobalKey();
          return Card(
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: Colors.red, width: 0.5),
              borderRadius: BorderRadius.circular(6),
            ),
            shadowColor: Colors.black54,
            elevation: 15,
            child: ClipPath(
              clipper: ShapeBorderClipper(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  border: const Border(
                    left: BorderSide(color: Colors.red, width: 8),
                  ),
                  color: Colors.yellowAccent.shade100,
                ),
                padding: const EdgeInsets.all(0),
                alignment: Alignment.centerLeft,
                child: ListTile(
                  contentPadding: const EdgeInsets.only(
                    top: 0,
                    bottom: 0,
                    left: 6,
                    right: 14,
                  ),
                  horizontalTitleGap: 8,
                  leading: Column(
                    mainAxisSize: MainAxisSize.min,
                    verticalDirection: VerticalDirection.up,
                    children: <Widget>[
                      Text(
                        result.memNo,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.red,
                        backgroundImage: NetworkImage(result.memImg),
                        // child: GestureDetector(onTap: () {}),
                      ),
                    ],
                  ),
                  title: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          const Text(
                            '[ ',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 12),
                          ),
                          Text(
                            result.memCode,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            ' ]',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      const SizedBox(width: 4),
                      Row(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              SizedBox(
                                width: MediaQuery.of(context).size.width -
                                    (MediaQuery.of(context).size.width / 1.7),
                                child: Text(
                                  result.memName,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  subtitle: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 2, bottom: 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                const Text(
                                  'ดูแล',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 8),
                                ),
                                const SizedBox(width: 4),
                                const Text(':', style: TextStyle(fontSize: 8)),
                                const SizedBox(width: 4),
                                Text(
                                  result.memSale,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                const Text(
                                  'แพ็ค',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 8),
                                ),
                                const SizedBox(width: 4),
                                const Text(':', style: TextStyle(fontSize: 8)),
                                const SizedBox(width: 4),
                                Text(
                                  result.memPack,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 2, bottom: 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                const Text(
                                  'แท็ก',
                                  style: TextStyle(fontSize: 10),
                                ),
                                const SizedBox(width: 4),
                                const Text(':', style: TextStyle(fontSize: 8)),
                                const SizedBox(width: 4),
                                Text(
                                  result.lgStdate,
                                  style: const TextStyle(fontSize: 10),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  result.lgSttime,
                                  style: const TextStyle(fontSize: 10),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                const Text('ตรวจ',
                                    style: TextStyle(fontSize: 8)),
                                const SizedBox(width: 4),
                                const Text(':', style: TextStyle(fontSize: 8)),
                                const SizedBox(width: 4),
                                Text(
                                  result.memQc,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 2, bottom: 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                const Text(
                                  'ส่งล่าสุด',
                                  maxLines: 1,
                                  style: TextStyle(fontSize: 10),
                                ),
                                const SizedBox(width: 4),
                                const Text(':', style: TextStyle(fontSize: 8)),
                                const SizedBox(width: 4),
                                Text(
                                  result.lastDship,
                                  maxLines: 1,
                                  style: const TextStyle(fontSize: 10),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  result.lastTship,
                                  maxLines: 1,
                                  style: const TextStyle(fontSize: 10),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                const Text(
                                  'โดย',
                                  maxLines: 1,
                                  style: TextStyle(fontSize: 8),
                                ),
                                const SizedBox(width: 4),
                                const Text(':', style: TextStyle(fontSize: 8)),
                                const SizedBox(width: 4),
                                Text(
                                  result.memLogistic,
                                  maxLines: 1,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  trailing: Text(
                    result.lgBox,
                    style: const TextStyle(fontSize: 24),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PickingBox(
                          memCode: result.memCode,
                          // memName: result.memName,
                          // routeCode: widget.code,
                          routeName: widget.name,
                          amountCus: widget.cus,
                          amountBox: widget.box,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

void doNothing(BuildContext context) {}
