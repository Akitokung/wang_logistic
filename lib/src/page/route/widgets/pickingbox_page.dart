import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wang_logistic/src/models/member.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wang_logistic/src/services/network_service.dart';
import 'package:wang_logistic/src/models/provider/profile_emp.dart';
import 'package:wang_logistic/src/page/route/widgets/boxset_page.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class PickingBox extends StatefulWidget {
  final String memCode;
  final String routeName;
  final String amountCus;
  final String amountBox;

  const PickingBox({
    Key? key,
    required this.memCode,
    required this.routeName,
    required this.amountCus,
    required this.amountBox,
  }) : super(key: key);

  @override
  _PickingBoxState createState() => _PickingBoxState();
}

class _PickingBoxState extends State<PickingBox> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final emp = Provider.of<ProviderProfile>(context);
    return Scaffold(
      key: _scaffoldkey,
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: "Cancel and Return to List",
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
                Text(
                  '[ ${widget.routeName} ]',
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                const Text('นับแล้ว', style: TextStyle(fontSize: 12)),
                const SizedBox(width: 6),
                const Text(':', style: TextStyle(fontSize: 12)),
                const SizedBox(width: 10),
                Text(
                  emp.shippingShop,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 6),
                const Text('ร้าน', style: TextStyle(fontSize: 12)),
                const SizedBox(width: 16),
                Text(
                  emp.shippingBoxs,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 6),
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
                        Text(
                          widget.amountCus,
                          style: const TextStyle(
                            fontSize: 8,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          ' ร้าน',
                          style: TextStyle(
                            fontSize: 8,
                            color: Colors.black38,
                          ),
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
                        Text(
                          widget.amountBox,
                          style: const TextStyle(
                            fontSize: 8,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          ' ลัง ',
                          style: TextStyle(
                            fontSize: 8,
                            color: Colors.black38,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            var empProfile = context.read<ProviderProfile>();
            empProfile.empProfice();
          });
        },
        child: _buildNetwork(widget.memCode),
      ),
    );
  }

  FutureBuilder<Member> _buildNetwork(memCode) {
    return FutureBuilder<Member>(
      future: NetworkService.getMember(memCode),
      builder: (context, AsyncSnapshot<dynamic> snapshot) {
        final heightT = MediaQuery.of(context).size.height / 2.65;
        final heightC = (MediaQuery.of(context).size.height - heightT) - 79;
        final width = MediaQuery.of(context).size.width;

        if (snapshot.hasData) {
          Member? member = snapshot.data;
          // || member.isEmpty
          if (member == null) {
            return Container(
              margin: const EdgeInsets.only(top: 22),
              alignment: Alignment.topCenter,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Text(
                      'พนักงานทุกท่าน ทุกตำแหน่งงาน',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            );
          }
          return Column(
            children: <Widget>[
              Container(
                height: heightT - 14,
                width: width,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(6),
                    bottomRight: Radius.circular(6),
                  ),
                ),
                padding: const EdgeInsets.only(top: 8),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 3,
                                      child: Column(
                                        children: [
                                          Container(
                                            height: heightT / 6,
                                            width: width,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: NetworkImage(
                                                  member.memImg1,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.only(top: 8.0),
                                            child: Text(
                                              'หน้าร้าน',
                                              style: TextStyle(fontSize: 10),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Column(
                                        children: [
                                          Container(
                                            height: heightT / 4.5,
                                            width: width,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: NetworkImage(
                                                  member.memImg2,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.only(top: 8.0),
                                            child: Text(
                                              'เจ้าของ',
                                              style: TextStyle(fontSize: 10),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Column(
                                        children: [
                                          Container(
                                            height: heightT / 6,
                                            width: width,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: NetworkImage(
                                                  member.memImg3,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.only(top: 8.0),
                                            child: Text(
                                              'เภสัชกร',
                                              style: TextStyle(fontSize: 10),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6.0),
                                Column(
                                  children: <Widget>[
                                    Text(
                                      // widget.memName,
                                      member.memCode,
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      member.memName,
                                      maxLines: 1,
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.black,
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
                    ),
                    Column(
                      children: <Widget>[
                        ListTile(
                          visualDensity:
                              const VisualDensity(horizontal: -4, vertical: -4),
                          contentPadding: const EdgeInsets.only(
                            top: 0,
                            bottom: 0,
                            left: 16,
                            right: 16,
                          ),
                          leading: Column(children: const [
                            Text(
                              'ที่อยู่',
                              style: TextStyle(fontSize: 12),
                            )
                          ]),
                          dense: true,
                          title: Text(
                            member.memAddress,
                            maxLines: 2,
                            overflow: TextOverflow.clip,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                        ListTile(
                          visualDensity:
                              const VisualDensity(horizontal: -4, vertical: -4),
                          contentPadding: const EdgeInsets.only(
                            top: 0,
                            bottom: 0,
                            left: 16,
                            right: 16,
                          ),
                          leading: Column(children: const [
                            Text(
                              'ที่ส่ง',
                              style: TextStyle(fontSize: 12),
                            )
                          ]),
                          dense: true,
                          title: Text(
                            member.memAddshipping,
                            maxLines: 2,
                            overflow: TextOverflow.clip,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            // ignore: deprecated_member_use
                            FlatButton(
                              onPressed: () => {
                                if (member.memMobile != '___-___-____')
                                  {
                                    FlutterPhoneDirectCaller.callNumber(
                                      member.memMobile,
                                    )
                                  }
                              },
                              child: Column(
                                children: const <Widget>[
                                  FaIcon(FontAwesomeIcons.mobile),
                                  Text('โทร', style: TextStyle(fontSize: 10))
                                ],
                              ),
                            ),
                            // ignore: deprecated_member_use
                            FlatButton(
                              onPressed: () {
                                if (member.memLineadd != '__________') {
                                  late String url =
                                      'http://line.me/ti/p/~${member.memLineadd}';
                                  launch(url);
                                }
                              },
                              child: Column(
                                children: const <Widget>[
                                  FaIcon(FontAwesomeIcons.line),
                                  Text('Line', style: TextStyle(fontSize: 10))
                                ],
                              ),
                            ),
                            // ignore: deprecated_member_use
                            FlatButton(
                              onPressed: () => {},
                              child: Column(
                                children: const <Widget>[
                                  FaIcon(FontAwesomeIcons.mapMarkedAlt),
                                  Text('แผนที่', style: TextStyle(fontSize: 10))
                                ],
                              ),
                            ),
                            // ignore: deprecated_member_use
                            FlatButton(
                              onPressed: () => {
                                if (member.memMobile != '___-___-____')
                                  {
                                    FlutterPhoneDirectCaller.callNumber(
                                        member.salePhone)
                                  }
                                else
                                  {
                                    FlutterPhoneDirectCaller.callNumber(
                                        '074-366681')
                                  }
                              },
                              child: Column(
                                children: <Widget>[
                                  const FaIcon(FontAwesomeIcons.teamspeak),
                                  Text(member.saleName,
                                      style: const TextStyle(fontSize: 10))
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: heightC,
                child: BoxsSet(memCode: member.memCode),
              ),
            ],
          );
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
}
