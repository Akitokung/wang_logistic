import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:wang_logistic/src/constants/setting.dart';
import 'package:wang_logistic/src/models/provider/profile_emp.dart';
import 'package:wang_logistic/src/models/user_location.dart';
import 'package:wang_logistic/src/page/dashboard/dashboard_page.dart';
import 'package:wang_logistic/src/page/energy/energy_page.dart';
import 'package:wang_logistic/src/page/garage/garage_page.dart';
import 'package:wang_logistic/src/page/insurance/insurance_page.dart';
import 'package:wang_logistic/src/page/law/law_page.dart';
import 'package:wang_logistic/src/page/login/login_page.dart';
import 'package:wang_logistic/src/page/maintain/checklist_page.dart';
import 'package:wang_logistic/src/page/maintain/maintain_page.dart';
import 'package:wang_logistic/src/page/map/map_page.dart';
import 'package:wang_logistic/src/page/profile/profile_page.dart';
import 'package:wang_logistic/src/page/pump/pump_page.dart';
import 'package:wang_logistic/src/page/receive/receive_page.dart';
import 'package:wang_logistic/src/page/relations/relations_page.dart';
import 'package:wang_logistic/src/page/route/route_page.dart';
import 'package:wang_logistic/src/page/sale/sale_page.dart';
import 'package:wang_logistic/src/page/shipping/shipping_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextStyle _headStyle() => const TextStyle(fontSize: 12, color: Colors.black);

  String _scanBarcode = '';
  int _currentIndex = 2;

  final PageStorageBucket bucket = PageStorageBucket();
  late Widget _currentScreen = const RoutePage();
  var focusNode = FocusNode();

  @override
  void initState() {
    focusNode.addListener(() {
      // print(focusNode.hasFocus);
      if (focusNode.hasFocus) {
        FocusScope.of(context).unfocus();
        showSearch(context: context, delegate: DataSearch());
      }
    });
    super.initState();
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.QR,
      );
      // print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;
    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    final gps = Provider.of<UserLocation>(context);
    final emp = Provider.of<ProviderProfile>(context);
    return Scaffold(
      appBar: AppBar(
        primary: true,
        centerTitle: true,
        titleSpacing: 0,
        leadingWidth: 28,
        toolbarHeight: 40,
        // ignore: deprecated_member_use
        title: FlatButton(
          onPressed: () {
            setState(() {
              _currentScreen = const DashboardPage();
              _currentIndex = 7;
              _scanBarcode = '';
            });
          },
          child: Column(
            children: <Widget>[
              Text(Setting.company_nameTH, style: _headStyle()),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('[ ${emp.empCode} ]', style: _headStyle()),
                  const SizedBox(width: 6),
                  Text(emp.empFullname, style: _headStyle()),
                  const SizedBox(width: 6),
                  Text('( ${emp.empNickname} )', style: _headStyle()),
                ],
              ),
            ],
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              setState(() {
                _currentScreen = const PumpPage();
                _currentIndex = 8;
                _scanBarcode = '';
              });
            },
            tooltip: 'เติมน้ำมัน',
            icon: Icon(
              FontAwesomeIcons.gasPump,
              color: _currentIndex == 8 ? Colors.white : Colors.black26,
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                _currentScreen = const ChecklistPage();
                _currentIndex = 9;
                _scanBarcode = '';
              });
            },
            tooltip: 'ตรวจสภาพรถ',
            icon: Icon(
              FontAwesomeIcons.clipboardList,
              color: _currentIndex == 9 ? Colors.white : Colors.black26,
            ),
          )
        ],
        bottom: AppBar(
          titleSpacing: 1,
          automaticallyImplyLeading: false,
          toolbarHeight: 46,
          title: Container(
            width: double.infinity,
            height: 35,
            padding: const EdgeInsets.all(0),
            child: Center(
              child: TextFormField(
                readOnly: true,
                autofocus: false,
                showCursor: true,
                obscureText: false,
                focusNode: focusNode,
                controller: TextEditingController(text: _scanBarcode),
                // controller: TextEditingController(text: '${gps.latitude} ${gps.longitude}'),
                keyboardType: TextInputType.text,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.only(
                    top: 4,
                    bottom: 0,
                    left: 16,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'รหัสลูกค้า Customercode',
                  hintStyle: const TextStyle(fontSize: 12, color: Colors.grey),
                  suffixIcon: SizedBox(
                    width: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        IconButton(
                          tooltip: 'Scan Barcode',
                          padding: const EdgeInsets.all(3),
                          onPressed: () {
                            showSearch(
                              context: context,
                              delegate: DataSearch(),
                            );
                          },
                          icon: const Icon(
                            Icons.search_outlined,
                            color: Colors.black54,
                          ),
                        ),
                        IconButton(
                          tooltip: 'Scan Barcode',
                          padding: const EdgeInsets.all(3),
                          // onPressed: () {},
                          // onPressed: () => scanBarcodeNormal(),
                          onPressed: () => scanQR(),
                          icon: const Icon(
                            Icons.qr_code_outlined,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                onTap: () {},
              ),
            ),
          ),
        ),
      ),
      drawer: Drawer(
        elevation: 10,
        child: Column(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  UserAccountsDrawerHeader(
                    accountName: Row(
                      children: <Widget>[
                        Text(
                          '[ ${emp.empCode} ]',
                          style: const TextStyle(
                            fontSize: 18,
                            wordSpacing: 3,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          emp.empNickname,
                          style: const TextStyle(
                            height: 2.3,
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                    accountEmail: Row(
                      children: <Widget>[
                        Text(
                          emp.empFullname,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                    currentAccountPicture: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(emp.empImg, fit: BoxFit.fill),
                    ),
                    otherAccountsPictures: <Widget>[
                      CircleAvatar(
                        child: Icon(
                          FontAwesomeIcons.dolly,
                          size: 24,
                          color:
                              emp.empLogistic ? Colors.white : Colors.black45,
                        ),
                        foregroundColor: Colors.grey,
                        backgroundColor: Colors.grey[1000],
                      ),
                      CircleAvatar(
                        child: Icon(
                          FontAwesomeIcons.teamspeak,
                          size: 24,
                          color: emp.empSale ? Colors.white : Colors.black45,
                        ),
                        foregroundColor: Colors.grey,
                        backgroundColor: Colors.grey[1000],
                      ),
                      CircleAvatar(
                        child: Icon(
                          FontAwesomeIcons.clinicMedical,
                          size: 24,
                          color: emp.empSalesupport
                              ? Colors.white
                              : Colors.black45,
                        ),
                        foregroundColor: Colors.grey,
                        backgroundColor: Colors.grey[1000],
                      )
                    ],
                    onDetailsPressed: () => {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) =>  const ProfilePage(),
                      //   ),
                      // ),

                      setState(() {
                        _currentScreen = const ProfilePage();
                        _scanBarcode = '';
                        Navigator.of(context).pop();
                      }),
                    },
                  ),
                ],
              ),
            ),
            ClipRect(
              child: ListTile(
                dense: true,
                leading: const CircleAvatar(
                  backgroundColor: Colors.red,
                  child: Icon(FontAwesomeIcons.hotjar, color: Colors.black54),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const <Widget>[
                    Text(
                      'กรมพลังงานเชื้อเพลิง',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'รับเข้า + จ่ายออก',
                      style: TextStyle(fontSize: 10),
                    ),
                  ],
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const <Widget>[
                    Text(
                      'กระทรวงพลังงาน',
                      style: TextStyle(
                        fontSize: 10,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      'วังเภสัชฟาร์มาซูติคอล จำกัด',
                      style: TextStyle(
                        fontSize: 10,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  setState(() {
                    _currentScreen = const EnergyPage();
                    _currentIndex = 10;
                    _scanBarcode = '';
                    Navigator.of(context).pop();
                  });
                },
              ),
            ),
            ListTile(
              dense: true,
              leading: const CircleAvatar(
                backgroundColor: Colors.red,
                child: Icon(FontAwesomeIcons.car, color: Colors.black54),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const <Widget>[
                  Text(
                    'กรมการขนส่งทางบก',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'ข้อมูลรถ + คนขับ',
                    style: TextStyle(fontSize: 10),
                  ),
                ],
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const <Widget>[
                  Text(
                    'กระทรวงคมนาคม',
                    style: TextStyle(
                      fontSize: 10,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    'วังเภสัชฟาร์มาซูติคอล จำกัด',
                    style: TextStyle(
                      fontSize: 10,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              onTap: () {
                setState(() {
                  _currentScreen = const GaragePage();
                  _currentIndex = 11;
                  _scanBarcode = '';
                  Navigator.of(context).pop();
                });
              },
            ),
            ListTile(
              dense: true,
              leading: const CircleAvatar(
                backgroundColor: Colors.red,
                child: Icon(FontAwesomeIcons.tools, color: Colors.black54),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const <Widget>[
                  Text(
                    'กรมการช่าง',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'แจ้งซ่อม + อนุมัติ',
                    style: TextStyle(fontSize: 10),
                  ),
                ],
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const <Widget>[
                  Text(
                    'กระทรวงแรงงาน',
                    style: TextStyle(
                      fontSize: 10,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    'วังเภสัชฟาร์มาซูติคอล จำกัด',
                    style: TextStyle(
                      fontSize: 10,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              onTap: () {
                setState(() {
                  _currentScreen = const MaintainPage();
                  _currentIndex = 1;
                  _scanBarcode = '';
                  Navigator.of(context).pop();
                });
              },
            ),
            ListTile(
              dense: true,
              leading: const CircleAvatar(
                backgroundColor: Colors.red,
                child:
                    Icon(FontAwesomeIcons.balanceScale, color: Colors.black54),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const <Widget>[
                  Text(
                    'กรมบังคับคดี',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'ใบสั่งจราจร + อุบัติเหตุ',
                    style: TextStyle(fontSize: 10),
                  ),
                ],
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const <Widget>[
                  Text(
                    'กระทรวงยุติธรรม',
                    style: TextStyle(
                      fontSize: 10,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    'วังเภสัชฟาร์มาซูติคอล จำกัด',
                    style: TextStyle(
                      fontSize: 10,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              onTap: () {
                setState(() {
                  _currentScreen = const LawPage();
                  _currentIndex = 13;
                  _scanBarcode = '';
                  Navigator.of(context).pop();
                });
              },
            ),
            ListTile(
              dense: true,
              leading: const CircleAvatar(
                backgroundColor: Colors.red,
                child: Icon(FontAwesomeIcons.carCrash, color: Colors.black54),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const <Widget>[
                  Text(
                    'กรมการประกันภัย',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'ประกันภัย + ผ่อนชำระ',
                    style: TextStyle(fontSize: 10),
                  ),
                ],
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const <Widget>[
                  Text(
                    'กระทรวงพาณิชย์',
                    style: TextStyle(
                      fontSize: 10,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    'วังเภสัชฟาร์มาซูติคอล จำกัด',
                    style: TextStyle(
                      fontSize: 10,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              onTap: () {
                setState(() {
                  _currentScreen = const InsurancePage();
                  _currentIndex = 14;
                  _scanBarcode = '';
                  Navigator.of(context).pop();
                });
              },
            ),
            ListTile(
              dense: true,
              leading: const CircleAvatar(
                backgroundColor: Colors.red,
                child: Icon(FontAwesomeIcons.bullhorn, color: Colors.black54),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const <Widget>[
                  Text(
                    'กรมประชาสัมพันธ์',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'รายงานการใช้รถ',
                    style: TextStyle(fontSize: 10),
                  ),
                ],
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const <Widget>[
                  Text(
                    'กระทรวงพาณิชย์',
                    style: TextStyle(
                      fontSize: 10,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    'วังเภสัชฟาร์มาซูติคอล จำกัด',
                    style: TextStyle(
                      fontSize: 10,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              onTap: () {
                setState(() {
                  _currentScreen = const RelationsPage();
                  _currentIndex = 15;
                  _scanBarcode = '';
                  Navigator.of(context).pop();
                });
              },
            ),
            ListTile(
              dense: true,
              leading: const CircleAvatar(
                backgroundColor: Colors.red,
                child:
                    Icon(FontAwesomeIcons.mapMarkedAlt, color: Colors.black54),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const <Widget>[
                  Text(
                    'กรมแผนที่ขนส่ง',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'เส้นทาง + กำหนดการ',
                    style: TextStyle(fontSize: 10),
                  ),
                ],
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const <Widget>[
                  Text(
                    'กระทรวงพิธีการ',
                    style: TextStyle(
                      fontSize: 10,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    'วังเภสัชฟาร์มาซูติคอล จำกัด',
                    style: TextStyle(
                      fontSize: 10,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              onTap: () {
                setState(() {
                  _currentScreen = const MapPage();
                  _currentIndex = 5;
                  _scanBarcode = '';
                  Navigator.of(context).pop();
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 18.0, bottom: 6, left: 8, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text('Lat', style: TextStyle(fontSize: 10)),
                      const SizedBox(width: 3),
                      const Text(' : ', style: TextStyle(fontSize: 10)),
                      const SizedBox(width: 3),
                      Text(
                        '${gps.longitude}',
                        style: const TextStyle(fontSize: 10, color: Colors.red),
                      ),
                    ],
                  ),
                  Row(
                    children: const [
                      Text('ตำแหน่งปัจจุบัน', style: TextStyle(fontSize: 10)),
                    ],
                  ),
                  Row(
                    children: [
                      const Text('Long', style: TextStyle(fontSize: 10)),
                      const SizedBox(width: 3),
                      const Text(' : ', style: TextStyle(fontSize: 10)),
                      const SizedBox(width: 3),
                      Text(
                        '${gps.longitude}',
                        style: const TextStyle(fontSize: 10, color: Colors.red),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            Row(
              children: <Widget>[
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: ListTile(
                      dense: true,
                      tileColor: Colors.red,
                      horizontalTitleGap: 0,
                      leading:
                          const Icon(Icons.android_sharp, color: Colors.white),
                      title: Row(
                        children: const <Widget>[
                          Text(
                            'Ver. ${Setting.app_ver}',
                            style: TextStyle(color: Colors.black),
                          ),
                          SizedBox(width: 6),
                          Text(
                            Setting.app_name,
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                      subtitle: const Text(
                        Setting.company_nameTH,
                        style: TextStyle(color: Colors.grey),
                      ),
                      trailing: const Icon(
                        Icons.logout,
                        size: 18,
                        color: Colors.white,
                      ),
                      onLongPress: showDialogLogout,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            var empProfile = context.read<ProviderProfile>();
            empProfile.empProfice();
          });
        },
        child: PageStorage(
          child: _currentScreen,
          bucket: bucket,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'btn1',
        elevation: 12,
        onPressed: () {
          setState(() {
            _currentScreen = const DashboardPage();
            _currentIndex = 7;
            _scanBarcode = '';
          });
        },
        tooltip: 'กดเพื่อไปหน้าค้นหา รายชื่อลูกค้า',
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            children: <Widget>[
              Icon(
                Icons.home,
                size: 32,
                color: _currentIndex == 7 ? Colors.white : Colors.black26,
              ),
              Text(
                'หน้าหลัก',
                maxLines: 1,
                style: TextStyle(
                  fontSize: 8,
                  color: _currentIndex == 7 ? Colors.white70 : Colors.black45,
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        notchMargin: 5,
        color: Colors.red,
        shape: const CircularNotchedRectangle(),
        child: SizedBox(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    padding: const EdgeInsets.only(top: 3),
                    minWidth: 50,
                    onPressed: () {
                      setState(() {
                        _currentScreen = const MaintainPage();
                        _currentIndex = 1;
                        _scanBarcode = '';
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.tools,
                          color: _currentIndex == 1
                              ? Colors.white
                              : Colors.black26,
                        ),
                        Text(
                          'แจ้งซ่อม',
                          style: TextStyle(
                            fontSize: 10,
                            color: _currentIndex == 1
                                ? Colors.white70
                                : Colors.black45,
                          ),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    padding: const EdgeInsets.only(top: 3),
                    minWidth: 50,
                    onPressed: () {
                      setState(() {
                        _currentScreen = const RoutePage();
                        _currentIndex = 2;
                        _scanBarcode = '';
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.truckLoading,
                          color: _currentIndex == 2
                              ? Colors.white
                              : Colors.black26,
                        ),
                        Text(
                          '  ขึ้นของ',
                          style: TextStyle(
                            fontSize: 10,
                            color: _currentIndex == 2
                                ? Colors.white70
                                : Colors.black45,
                          ),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    padding: const EdgeInsets.only(top: 3),
                    minWidth: 50,
                    onPressed: () {
                      setState(() {
                        _currentScreen = const ShippingPage();
                        _currentIndex = 3;
                        _scanBarcode = '';
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.shippingFast,
                          color: _currentIndex == 3
                              ? Colors.white
                              : Colors.black26,
                        ),
                        Text(
                          '   นำส่ง',
                          style: TextStyle(
                            fontSize: 10,
                            color: _currentIndex == 3
                                ? Colors.white70
                                : Colors.black45,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    padding: const EdgeInsets.only(top: 3),
                    minWidth: 50,
                    onPressed: () {
                      setState(() {
                        _currentScreen = const ReceivePage();
                        _currentIndex = 4;
                        _scanBarcode = '';
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.peopleCarry,
                          color: _currentIndex == 4
                              ? Colors.white
                              : Colors.black26,
                        ),
                        Text(
                          '  รับคืน',
                          style: TextStyle(
                            fontSize: 10,
                            color: _currentIndex == 4
                                ? Colors.white70
                                : Colors.black45,
                          ),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    padding: const EdgeInsets.only(top: 3),
                    minWidth: 50,
                    onPressed: () {
                      setState(() {
                        _currentScreen = const MapPage();
                        _currentIndex = 5;
                        _scanBarcode = '';
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.mapMarkedAlt,
                          color: _currentIndex == 5
                              ? Colors.white
                              : Colors.black26,
                        ),
                        Text(
                          ' แผนที่',
                          style: TextStyle(
                            fontSize: 10,
                            color: _currentIndex == 5
                                ? Colors.white70
                                : Colors.black45,
                          ),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    padding: const EdgeInsets.only(top: 3),
                    minWidth: 50,
                    onPressed: () {
                      setState(() {
                        _currentScreen = const SalePage();
                        _currentIndex = 6;
                        _scanBarcode = '';
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.teamspeak,
                          color: _currentIndex == 6
                              ? Colors.white
                              : Colors.black26,
                        ),
                        Text(
                          'ฝ่ายขาย',
                          style: TextStyle(
                            fontSize: 10,
                            color: _currentIndex == 6
                                ? Colors.white70
                                : Colors.black45,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showDialogLogout() {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      // กดนอก dialog แล้วจะออกจาก function , false กดแล้วไม่มีผลอะไร ต้องการ ตัวเลือกที่เราทำหนดไว้เท่านั้น
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          // titlePadding: const EdgeInsets.only(top: 8, left: 16),
          title: const Text('Wangpharmacy'),
          content: const Text('ออกจากระบบ  ใช่  หรือ  ไม่'),
          buttonPadding: const EdgeInsets.all(0),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                SharedPreferences.getInstance().then((prefs) {
                  prefs.remove(Setting.token);
                  //prefs.clear();
                  Navigator.of(dialogContext).pop(); // Dismiss alert dialog
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  );
                });
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

class DataSearch extends SearchDelegate<String> {
  final cities = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
  ];
  final recentCities = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
  ];

  @override
  List<Widget>? buildActions(BuildContext context) {
    // // TODO: implement buildActions
    // throw UnimplementedError();
    // actions for app bar
    return [
      IconButton(
        padding: const EdgeInsets.all(0),
        constraints: const BoxConstraints(minWidth: 10),
        onPressed: () {
          query = "";
        },
        icon: const Icon(Icons.clear),
      ),
      IconButton(
        padding: const EdgeInsets.all(0),
        constraints: const BoxConstraints(minWidth: 50),
        onPressed: () {
          query = "";
        },
        icon: const Icon(Icons.search),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // // TODO: implement buildLeading
    // throw UnimplementedError();
    // leading icon on th left of the app bar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, 'ค้นหา รหัสลูกค้า');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    // throw UnimplementedError();
    // show some based on the selection
    return Center(
      child: SizedBox(
        height: 100.0,
        width: 100.0,
        child: Card(
          color: Colors.red,
          shape: const StadiumBorder(),
          child: Center(
            child: Text(query),
          ),
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // // TODO: implement buildSuggestions
    // throw UnimplementedError();
    // show when someone searches for somthing
    final suggestionList = query.isEmpty
        ? recentCities
        : cities.where((p) => p.startsWith(query)).toList();
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          showResults(context);
        },
        leading: const Icon(Icons.location_city),
        // title: Text(suggestionList[index]),
        title: RichText(
          text: TextSpan(
              text: suggestionList[index].substring(0, query.length),
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(
                  text: suggestionList[index].substring(query.length),
                  style: const TextStyle(color: Colors.grey),
                ),
              ]),
        ),
      ),
      itemCount: suggestionList.length,
    );
  }
}
