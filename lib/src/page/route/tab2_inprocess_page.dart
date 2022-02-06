import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';

import 'package:wang_logistic/src/models/inprocess.dart';
import 'package:wang_logistic/src/models/provider/profile_emp.dart';
import 'package:wang_logistic/src/services/network_service.dart';

class InProcessPage extends StatefulWidget {
  const InProcessPage({Key? key, required this.code}) : super(key: key);
  final String code;

  @override
  // ignore: no_logic_in_create_state
  State<InProcessPage> createState() => _InProcessPageState(code);
}

class _InProcessPageState extends State<InProcessPage> {
  String code;
  bool alive = true;

  _InProcessPageState(this.code);

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
      body: _buildNetwork(code),
    );
  }

  FutureBuilder<List<Inprocess>> _buildNetwork(String code) {
    return FutureBuilder<List<Inprocess>>(
      future: NetworkService().getInProcess(code),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Inprocess>? data = snapshot.data;
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
                              fontSize: 32, fontWeight: FontWeight.bold),
                        )
                      ],
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

  Widget _buildCardBlock(List<Inprocess> data) {
    return Scrollbar(
      isAlwaysShown: true,
      showTrackOnHover: false,
      child: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          Inprocess result = data[index];
          // final GlobalKey<ExpansionTileCardState> card = GlobalKey();
          return Card(
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: Colors.red, width: 0.5),
              borderRadius: BorderRadius.circular(8),
            ),
            shadowColor: Colors.black54,
            elevation: 15,
            child: ClipPath(
              clipper: ShapeBorderClipper(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
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
                    children: [
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
                  title: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 4, bottom: 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  result.billStatus,
                                  maxLines: 1,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  result.memBill,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Text(
                                  '  บิล  ',
                                  maxLines: 1,
                                  style: TextStyle(fontSize: 8),
                                ),
                                Text(
                                  result.memList,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Text(
                                  '  รก.',
                                  style: TextStyle(fontSize: 8),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
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
                                    fontWeight: FontWeight.bold),
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
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context)
                                        .size
                                        .width -
                                        (MediaQuery.of(context).size.width /
                                            1.7),
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
                    ],
                  ),
                  subtitle: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 4, bottom: 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  'เปิดบิล',
                                  maxLines: 1,
                                  style: TextStyle(fontSize: 10),
                                ),
                                const SizedBox(width: 4),
                                const Text(':', style: TextStyle(fontSize: 8)),
                                const SizedBox(width: 4),
                                Text(
                                  result.memUpload,
                                  maxLines: 1,
                                  style: const TextStyle(fontSize: 10),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text(
                                  'ผู้ดูแล',
                                  maxLines: 1,
                                  style: TextStyle(fontSize: 8),
                                ),
                                const SizedBox(width: 4),
                                const Text(':', style: TextStyle(fontSize: 8)),
                                const SizedBox(width: 4),
                                Text(
                                  result.memSale,
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
                      Padding(
                        padding: const EdgeInsets.only(top: 2, bottom: 2),
                        child: Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width -
                                  (MediaQuery.of(context).size.width / 2.9),
                              child: Text(
                                result.memAddress,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 10),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // trailing: Column(
                  //   children: [
                  //     Padding(
                  //       padding: const EdgeInsets.all(0),
                  //       child: Text(result.memBill),
                  //     ),
                  //     Padding(
                  //       padding: const EdgeInsets.all(0),
                  //       child: Text(result.memBill),
                  //     ),
                  //   ],
                  // ),
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
