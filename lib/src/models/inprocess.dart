// To parse this JSON data, do
//
//     final inprocess = inprocessFromJson(jsonString);

import 'dart:convert';

List<Inprocess> inprocessFromJson(String str) => List<Inprocess>.from(json.decode(str).map((x) => Inprocess.fromJson(x)));

String inprocessToJson(List<Inprocess> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Inprocess {
  Inprocess({
    required this.memNo,
    required this.memImg,
    required this.memCode,
    required this.memName,
    required this.memRoute,
    required this.memAddress,
    required this.memAddress1,
    required this.memAddress2,
    required this.memSale,
    required this.memBill,
    required this.memList,
    required this.memUpload,
    required this.billStatus,
    required this.billList,
  });

  String memNo;
  String memImg;
  String memCode;
  String memName;
  String memRoute;
  String memAddress;
  String memAddress1;
  String memAddress2;
  String memSale;
  String memBill;
  String memList;
  String memUpload;
  String billStatus;
  List<BillList> billList;

  factory Inprocess.fromJson(Map<String, dynamic> json) => Inprocess(
    memNo: json["mem_no"],
    memImg: json["mem_img"],
    memCode: json["mem_code"],
    memName: json["mem_name"],
    memRoute: json["mem_route"],
    memAddress: json["mem_address"],
    memAddress1: json["mem_address1"],
    memAddress2: json["mem_address2"],
    memSale: json["mem_sale"],
    memBill: json["mem_bill"],
    memList: json["mem_list"],
    memUpload: json["mem_upload"],
    billStatus: json["bill_status"],
    billList: List<BillList>.from(json["bill_list"].map((x) => BillList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "mem_no": memNo,
    "mem_img": memImg,
    "mem_code": memCode,
    "mem_name": memName,
    "mem_route": memRoute,
    "mem_address": memAddress,
    "mem_address1": memAddress1,
    "mem_address2": memAddress2,
    "mem_sale": memSale,
    "mem_bill": memBill,
    "mem_list": memList,
    "mem_upload": memUpload,
    "bill_status": billStatus,
    "bill_list": List<dynamic>.from(billList.map((x) => x.toJson())),
  };
}

class BillList {
  BillList({
    required this.billCode,
    required this.billList,
  });

  String billCode;
  String billList;

  factory BillList.fromJson(Map<String, dynamic> json) => BillList(
    billCode: json["bill_code"],
    billList: json["bill_list"],
  );

  Map<String, dynamic> toJson() => {
    "bill_code": billCode,
    "bill_list": billList,
  };
}
