// To parse this JSON data, do
//
//     final profice = proficeFromJson(jsonString);

import 'dart:convert';

Profice proficeFromJson(String str) => Profice.fromJson(json.decode(str));

String proficeToJson(Profice data) => json.encode(data.toJson());

class Profice {
  Profice({
    required this.empId,
    required this.empCode,
    required this.empNickname,
    required this.empFullname,
    required this.empImg,
    required this.empMobileS,
    required this.empLogistic,
    required this.empSale,
    required this.empSalesupport,
    required this.shippingShop,
    required this.shippingBoxs,
  });

  String empId;
  String empCode;
  String empNickname;
  String empFullname;
  String empImg;
  String empMobileS;
  bool empLogistic;
  bool empSale;
  bool empSalesupport;
  String shippingShop;
  String shippingBoxs;

  factory Profice.fromJson(Map<String, dynamic> json) => Profice(
    empId: json["emp_id"],
    empCode: json["emp_code"],
    empNickname: json["emp_nickname"],
    empFullname: json["emp_fullname"],
    empImg: json["emp_img"],
    empMobileS: json["emp_mobileS"],
    empLogistic: json["emp_logistic"],
    empSale: json["emp_sale"],
    empSalesupport: json["emp_salesupport"],
    shippingShop: json["shipping_shop"],
    shippingBoxs: json["shipping_boxs"],
  );

  Map<String, dynamic> toJson() => {
    "emp_id": empId,
    "emp_code": empCode,
    "emp_nickname": empNickname,
    "emp_fullname": empFullname,
    "emp_img": empImg,
    "emp_mobileS": empMobileS,
    "emp_logistic": empLogistic,
    "emp_sale": empSale,
    "emp_salesupport": empSalesupport,
    "shipping_shop": shippingShop,
    "shipping_boxs": shippingBoxs,
  };
}
