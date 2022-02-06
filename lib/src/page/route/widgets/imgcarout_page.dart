import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wang_logistic/src/models/provider/profile_emp.dart';

class ImgcarOut extends StatefulWidget {
  final String rcode;
  final String rname;

  const ImgcarOut({
    Key? key,
    required this.rcode,
    required this.rname,
  }) : super(key: key);

  @override
  _ImgcarOutState createState() => _ImgcarOutState();
}

class _ImgcarOutState extends State<ImgcarOut> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  TextStyle _ereadyStyle() => const TextStyle(
        fontSize: 12,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      );

  TextStyle _lebleStyle() => const TextStyle(
        fontWeight: FontWeight.w500,
        color: Colors.black,
      );

  late File image1 = File('');
  late String image1Base64 = '';

  late File image2 = File('');
  late String image2Base64 = '';

  final imagePicker = ImagePicker();

  FocusNode plateNumberNode = FocusNode();
  TextEditingController plateNumberController = TextEditingController();

  // ignore: non_constant_identifier_names
  Future getImage(String No) async {
    // ignore: deprecated_member_use
    final image = await imagePicker.getImage(source: ImageSource.camera);
    if (image == null) return;

    var imageTemporary = File(image.path);
    var bytes = File(image.path).readAsBytesSync();
    var base64Image = "data:image/png;base64," + base64Encode(bytes);

    if (No == '1') {
      setState(() {
        image1 = imageTemporary;
        image1Base64 = base64Image;
      });
    }
    if (No == '2') {
      setState(() {
        image2 = imageTemporary;
        image2Base64 = base64Image;
      });
    }

    // setState(() {
    //   image1 = File(image!.path);
    // });
  }

  @override
  Widget build(BuildContext context) {
    final emp = Provider.of<ProviderProfile>(context);
    final width = MediaQuery.of(context).size.width / 2.2;
    // final height = MediaQuery.of(context).size.height / 2.65;

    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
        elevation: 10,
        leadingWidth: 32,
        automaticallyImplyLeading: false,
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
                  '[ ${widget.rname} ]',
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(emp.empFullname, style: const TextStyle(fontSize: 14)),
              ],
            ),
          ],
        ),
        actions: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  top: 8.0,
                  bottom: 2.0,
                  left: 8.0,
                  right: 8.0,
                ),
                child: Column(
                  children: <Widget>[
                    const Icon(Icons.add_business, size: 23),
                    Row(
                      children: <Widget>[
                        Text(emp.shippingShop, style: _ereadyStyle()),
                        const SizedBox(width: 6),
                        const Text(
                          ' ร้าน',
                          style: TextStyle(fontSize: 8, color: Colors.black38),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 8.0,
                  bottom: 2.0,
                  left: 8.0,
                  right: 12,
                ),
                child: Column(
                  children: <Widget>[
                    const Icon(Icons.view_in_ar, size: 23),
                    Row(
                      children: <Widget>[
                        Text(emp.shippingBoxs, style: _ereadyStyle()),
                        const SizedBox(width: 6),
                        const Text(
                          ' ลัง ',
                          style: TextStyle(fontSize: 8, color: Colors.black38),
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
      body: Listener(
        onPointerDown: (_) {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.focusedChild?.unfocus();
          }
        },
        child: Container(
          // height: height,
          padding: const EdgeInsets.only(top: 8, bottom: 8, left: 8, right: 8),
          color: Colors.grey.shade100,
          child: Column(
            children: <Widget>[
              Table(
                border: TableBorder.all(),
                // columnWidths: const <int, TableColumnWidth>{
                //   0: IntrinsicColumnWidth(),
                //   1: FlexColumnWidth(),
                //   2: FixedColumnWidth(64),
                // },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: <TableRow>[
                  TableRow(
                    children: <Widget>[
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [Text('ลูกค้า / ร้าน')],
                          ),
                        ),
                      ),
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [Text('สินค้า / ลัง')],
                          ),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: <Widget>[
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                emp.shippingShop,
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                emp.shippingBoxs,
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(widget.rname,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 36),),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        width: width,
                        height: 145,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(6.0),
                          boxShadow: const [
                            BoxShadow(color: Colors.blueAccent)
                          ],
                        ),
                        child: IconButton(
                          icon: image1.path != ''
                              ? Image.file(image1,
                                  width: width, fit: BoxFit.fill)
                              : const Icon(Icons.camera_alt),
                          iconSize: 80.0,
                          onPressed: () async {
                            await getImage('1');
                          },
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'ห้องโดยสาร',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        width: width,
                        height: 145,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(6.0),
                          boxShadow: const [
                            BoxShadow(color: Colors.blueAccent)
                          ],
                        ),
                        child: IconButton(
                          icon: image2.path != ''
                              ? Image.file(image2,
                                  width: width, fit: BoxFit.fill)
                              : const Icon(Icons.camera_alt),
                          iconSize: 80.0,
                          onPressed: () async {
                            await getImage('2');
                          },
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'ตู้บรรทุกสินค้า',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              // checkLoadImage(),
              const SizedBox(height: 14),
              TextFormField(
                autofocus: false,
                obscureText: false,
                cursorColor: Colors.black,
                textAlign: TextAlign.center,
                focusNode: plateNumberNode,
                controller: plateNumberController,
                textInputAction: TextInputAction.next,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  labelText: 'เลขทะเบียนรถ',
                  labelStyle: _lebleStyle(),
                  prefixIcon: const Icon(
                    FontAwesomeIcons.car,
                    color: Colors.grey,
                    size: 28,
                  ),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                    borderSide: BorderSide(width: 0.1),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
                // keyboardType: TextInputType.number,
              ),
              Column(
                children: [
                  Card(
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
                        child: ListTile(
                          dense: true,
                          leading: Column(
                            mainAxisSize: MainAxisSize.min,
                            verticalDirection: VerticalDirection.up,
                            children: <Widget>[
                              const Text(
                                '1',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              CircleAvatar(
                                backgroundColor: Colors.red,
                                backgroundImage: NetworkImage(emp.empImg),
                                // child: GestureDetector(onTap: () {}),
                              ),
                            ],
                          ),
                          title: const Text('01234567899876543210'),
                          subtitle: const Text('01234567899876543210'),
                          trailing: const Icon(FontAwesomeIcons.phone),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),

      // body: Center(
      //   // ignore: unnecessary_null_comparison
      //   child: image1 == null
      //       ? const Text('No Image Selected')
      //       : Image.file(image1),
      // ),

      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.blue,
      //   child: const Icon(Icons.camera_alt),
      //   onPressed: getImage('1'),
      // ),
    );
  }
}
