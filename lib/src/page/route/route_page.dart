import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: implementation_imports
import 'package:provider/src/provider.dart';
import 'package:wang_logistic/src/models/provider/profile_emp.dart';
import 'package:wang_logistic/src/models/route.dart';
import 'package:wang_logistic/src/page/route/pickup_page.dart';
import 'package:wang_logistic/src/services/network_service.dart';

class RoutePage extends StatefulWidget {
  const RoutePage({Key? key}) : super(key: key);

  @override
  State<RoutePage> createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  late String _cusall2 = '';
  late String _boxall2 = '';

  fetchLable() async {
    var shipping = await NetworkService.getOnShipping();
    setState(() {
      _cusall2 = shipping[0].Cuss;
      _boxall2 = shipping[0].Boxs;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchLable();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      backgroundColor: Colors.grey.shade200,
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            var empProfile = context.read<ProviderProfile>();
            empProfile.empProfice();
          });
        },
        child: _buildNetwork(),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(
          FontAwesomeIcons.boxOpen,
          color: Colors.white,
          size: 14,
        ),
        label: Row(
          children: <Widget>[
            const SizedBox(width: 4),
            Text(
              _cusall2,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(' : ', style: TextStyle(color: Colors.white)),
            Text(
              _boxall2,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        elevation: 5,
        tooltip: 'ลูกค้าในความดูแลทั้งหมด',
        splashColor: Colors.white,
        backgroundColor: Colors.red,
      ),
    );
  }

  FutureBuilder<List<RouteList>> _buildNetwork() {
    return FutureBuilder<List<RouteList>>(
      future: NetworkService.getRoute(),
      builder: (context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          List<RouteList>? route = snapshot.data;
          if (route == null || route.isEmpty) {
            return Container(
              margin: const EdgeInsets.only(top: 22),
              alignment: Alignment.topCenter,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Text(
                      'พนักงานทุกท่าน ทุกตำแหน่งงาน',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: () async {
              setState(() {
                fetchLable();
                var empProfile = context.read<ProviderProfile>();
                empProfile.empProfice();
              });
            },
            child: Container(
              margin: const EdgeInsets.only(top: 4),
              child: _buildCardBlock(route),
            ),
          );
          // return _buildCardBlock(route);
        }
        if (snapshot.hasError) {
          return Container(
            margin: const EdgeInsets.only(top: 22),
            alignment: Alignment.topCenter,
            // child: Text((snapshot.error as DioError).message),
            child: Text('${snapshot.error}'),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _buildCardBlock(List<RouteList> route) {
    return Scrollbar(
      isAlwaysShown: true,
      showTrackOnHover: false,
      child: ListView.builder(
        itemCount: route.length,
        itemBuilder: (context, index) {
          RouteList logistic = route[index];
          return Card(
            elevation: 1.5,
            child: ListTile(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const PickUpPage(route: logistic.msCode),
                //   ),
                // );

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PickUpPage(
                      code: logistic.msCode,
                      name: logistic.msStickname,
                      // cus: logistic.msCus0,
                      // box: logistic.msBox0,
                    ),
                  ),
                );

                // setState(() {
                //   _currentScreen = const RoutePage();
                //   _currentIndex = 0;
                // });
              },
              minVerticalPadding: 8,
              visualDensity: const VisualDensity(horizontal: -4, vertical: 0),
              leading: Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Column(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.red,
                      backgroundImage: NetworkImage(logistic.msImg),
                      // child: GestureDetector(onTap: () {}),
                    ),
                    Text(
                      '${logistic.msCus2} : ${logistic.msBox2}',
                      style: const TextStyle(
                          fontSize: 8,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        logistic.msCode,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        logistic.msStickname,
                        style: const TextStyle(
                          color: Colors.green,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      const Text('วันนี้', style: TextStyle(fontSize: 10)),
                      const SizedBox(width: 6),
                      Text(
                        logistic.msNNow,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Text('ออก', style: TextStyle(fontSize: 8)),
                      const SizedBox(width: 6),
                      Text(
                        logistic.msTNow,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              subtitle: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: MediaQuery.of(context).size.width -
                                (MediaQuery.of(context).size.width / 1.8),
                            child: Text(
                              logistic.msName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            logistic.msCus0,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Padding(
                            padding: EdgeInsets.only(top: 4.0),
                            child: Text('ร้าน', style: TextStyle(fontSize: 6)),
                          ),
                          // const Text(':', style: TextStyle(fontSize: 10)),
                          const SizedBox(width: 6),
                          Text(
                            logistic.msBox0,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Padding(
                            padding: EdgeInsets.only(top: 4.0),
                            child: Text('ลัง', style: TextStyle(fontSize: 6)),
                          ),
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            '[ ${logistic.msWeek} ]',
                            maxLines: 1,
                            style: const TextStyle(fontSize: 10),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          const Text(
                            'ครั้งก่อน',
                            style: TextStyle(fontSize: 10, color: Colors.grey),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            logistic.msELast,
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Text(
                            'ออก',
                            style: TextStyle(fontSize: 8, color: Colors.grey),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            logistic.msTLast,
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
              trailing: PopupMenuButton(
                // elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0),
                  side: const BorderSide(color: Colors.red),
                ),
                child: const Icon(
                  Icons.info_outline,
                  size: 22,
                ),
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      padding: const EdgeInsets.only(left: 12),
                      height: 30,
                      value: '1',
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            logistic.msCode,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            logistic.msStickname,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.green,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      padding: const EdgeInsets.only(left: 12),
                      height: 30,
                      value: '1',
                      child: Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              // color: Color.fromRGBO(0, 83, 79, 1),
                              color: Colors.red,
                              width: 0.27,
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 8.0,
                                bottom: 8.0,
                                left: 4.0,
                                right: 0,
                              ),
                              child: Row(
                                children: const <Widget>[
                                  Icon(
                                    Icons.supervisor_account_outlined,
                                    size: 18,
                                    color: Colors.green,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'ลูกค้าทั้งหมด',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: Text(
                                logistic.msCusAll,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      padding: const EdgeInsets.only(left: 12),
                      height: 30,
                      value: '1',
                      child: Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              // color: Color.fromRGBO(0, 83, 79, 1),
                              color: Colors.red,
                              width: 0.27,
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 8.0,
                                bottom: 8.0,
                                left: 4.0,
                                right: 0,
                              ),
                              child: Row(
                                children: const [
                                  Icon(Icons.pending_actions_outlined,
                                      size: 18, color: Colors.blue),
                                  SizedBox(width: 8),
                                  Text(
                                    'กำลังส่ง',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: Text(
                                '${logistic.msCus2} : ${logistic.msBox2}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      padding: const EdgeInsets.only(left: 12),
                      height: 30,
                      value: '1',
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 8.0,
                              bottom: 8.0,
                              left: 4.0,
                              right: 0,
                            ),
                            child: Row(
                              children: const <Widget>[
                                Icon(
                                  Icons.fact_check_outlined,
                                  size: 18,
                                  color: Colors.orange,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'เตรียมส่ง',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: Text(
                              '${logistic.msCus0} : ${logistic.msBox0}',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      padding: const EdgeInsets.only(left: 12),
                      height: 30,
                      value: '1',
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 8.0,
                              bottom: 8.0,
                              left: 4.0,
                              right: 0,
                            ),
                            child: Row(
                              children: const <Widget>[
                                Icon(
                                  FontAwesomeIcons.shippingFast,
                                  size: 14,
                                  color: Colors.red,
                                ),
                                SizedBox(width: 14),
                                Text(
                                  'รถออก',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: Text(
                              '${logistic.msTNow} น.',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ];
                },
                onSelected: (String value) => actionPopUpItemSelected(
                  value,
                  logistic.msCode,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void actionPopUpItemSelected(String value, String name) {
    // ignore: deprecated_member_use
    _scaffoldkey.currentState!.hideCurrentSnackBar();
    String message;
    if (value == 'edit') {
      message = 'You selected edit for $name';
    } else if (value == 'delete') {
      message = 'You selected delete for $name';
    } else {
      message = 'Not implemented';
    }
    final snackBar = SnackBar(content: Text(message));
    // ignore: deprecated_member_use
    _scaffoldkey.currentState!.showSnackBar(snackBar);
  }
}
