import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wang_logistic/src/models/pickingbox.dart';
import 'package:wang_logistic/src/services/network_service.dart';

class BoxsSet extends StatefulWidget {
  final String memCode;

  const BoxsSet({
    Key? key,
    required this.memCode,
  }) : super(key: key);

  @override
  State<BoxsSet> createState() => _BoxsSetState();
}

class _BoxsSetState extends State<BoxsSet> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  // ignore: non_constant_identifier_names
  void PostData(String id) async {
    int status = await NetworkService.postPickup(id);
    if (status == 200) {
      const CircularProgressIndicator();
      setState(() {
        
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildNetwork(widget.memCode),
    );
  }

  FutureBuilder<List<Set>> _buildNetwork(memCode) {
    return FutureBuilder<List<Set>>(
      future: NetworkService.getPickingBox(memCode),
      builder: (context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          List<Set>? set = snapshot.data;
          if (set == null || set.isEmpty) {
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
          return Container(
            margin: const EdgeInsets.only(top: 4),
            child: Container(
              child: _buildListBox(set),
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

  Widget _buildListBox(List<Set> set) {
    TextStyle _titleStyle() => const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
        );
    TextStyle _subtitleStyle() => const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
        );
    TextStyle _subdataStyle() => const TextStyle(fontSize: 10);
    late Color colorbg, colortex;
    late String statusname;

    return ListView.builder(
      itemCount: set.length,
      itemBuilder: (context, index) {
        Set box = set[index];

        if (box.setStatus == 'เตรียมส่ง') {
          colorbg = Colors.orange;
          colortex = Colors.black;
          statusname = 'เตรียมส่ง รอขึ้นของนะ';
        } else if (box.setStatus == 'กำลังส่ง') {
          colorbg = Colors.lightBlue;
          colortex = Colors.black54;
          statusname = 'ขึ้นของแล้ว';
        }

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
                onTap: () {
                  PostData(box.setId);
                  // NetworkService.postPickup(box.setId);
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => PickUpPage(),
                  //   ),
                  // );
                },
                visualDensity: const VisualDensity(horizontal: -4, vertical: 0),
                contentPadding: const EdgeInsets.only(
                  top: 0,
                  bottom: 0,
                  left: 6,
                  right: 14,
                ),
                horizontalTitleGap: 1,
                leading: Padding(
                  padding: const EdgeInsets.only(left: 7, top: 18),
                  child: Text(
                    box.setNo,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                title: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(box.setBill1, style: _titleStyle()),
                        Text(box.setBill2, style: _titleStyle()),
                        Text(box.setBill3, style: _titleStyle()),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(box.setBill4, style: _titleStyle()),
                        Text(box.setBill5, style: _titleStyle()),
                        Text(box.setBill6, style: _titleStyle()),
                      ],
                    ),
                  ],
                ),
                subtitle: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text('Qc  :  ', style: _subtitleStyle()),
                            Text(box.setCreate, style: _subdataStyle()),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text('Tag  :  ', style: _subtitleStyle()),
                            Text(box.setSticker, style: _subdataStyle()),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text('ตรวจ  :  ', style: _subtitleStyle()),
                            Text(box.setQc, style: _subdataStyle()),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text('แพ็ค  :  ', style: _subtitleStyle()),
                            Text(box.setPack, style: _subdataStyle()),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          // margin: EdgeInsets.all(10),
                          padding: const EdgeInsets.only(
                            top: 2,
                            bottom: 2,
                            left: 8,
                            right: 8,
                          ),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: colorbg,
                            border: Border.all(color: Colors.pink, width: 1),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(3.0),
                            ),
                          ),
                          child: Text(
                            // box.setStatus,
                            statusname,
                            style: TextStyle(fontSize: 12, color: colortex),
                          ),
                        ),
                        Container(
                          // margin: EdgeInsets.all(10),
                          padding: const EdgeInsets.only(
                            top: 1,
                            bottom: 1,
                            left: 8,
                            right: 8,
                          ),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            border: Border.all(color: Colors.pink, width: 1),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(3.0),
                            ),
                          ),
                          child: Row(
                            children: <Widget>[
                              Text(
                                box.setBoxs,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text('ลัง', style: _subdataStyle()),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                trailing: const Padding(
                  padding: EdgeInsets.only(top: 18),
                  child: Icon(FontAwesomeIcons.plus, size: 16),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
