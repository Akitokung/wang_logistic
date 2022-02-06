// To parse this JSON data, do
//
//     final onshipping = onshippingFromJson(jsonString);

import 'dart:convert';

List<Onshipping> onshippingFromJson(String str) => List<Onshipping>.from(json.decode(str).map((x) => Onshipping.fromJson(x)));

String onshippingToJson(List<Onshipping> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Onshipping {
  Onshipping({
    // required this.Date,
    // ignore: non_constant_identifier_names
    required this.Emp,
    // ignore: non_constant_identifier_names
    required this.Cuss,
    // ignore: non_constant_identifier_names
    required this.Boxs,
  });

  // String Date;
  // ignore: non_constant_identifier_names
  String Emp;
  // ignore: non_constant_identifier_names
  String Cuss;
  // ignore: non_constant_identifier_names
  String Boxs;

  factory Onshipping.fromJson(Map<String, dynamic> json) => Onshipping(
    // Date: json["sh_date"],
    Emp: json["sh_emp"],
    Cuss: json["sh_cuss"],
    Boxs: json["sh_boxs"],
  );

  Map<String, dynamic> toJson() => {
    // "sh_date": Date,
    "sh_emp": Emp,
    "sh_cuss":  Cuss,
    "sh_boxs": Boxs,
  };
}
