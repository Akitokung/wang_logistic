// To parse this JSON data, do
//
//     final readyShipping = readyShippingFromJson(jsonString);

import 'dart:convert';

ReadyShipping readyShippingFromJson(String str) => ReadyShipping.fromJson(json.decode(str));

String readyShippingToJson(ReadyShipping data) => json.encode(data.toJson());

class ReadyShipping {
  ReadyShipping({
    required this.shEmp,
    required this.shCuss,
    required this.shBoxs,
  });

  String shEmp;
  String shCuss;
  String shBoxs;

  factory ReadyShipping.fromJson(Map<String, dynamic> json) => ReadyShipping(
    shEmp: json["sh_emp"],
    shCuss: json["sh_cuss"],
    shBoxs: json["sh_boxs"],
  );

  Map<String, dynamic> toJson() => {
    "sh_emp": shEmp,
    "sh_cuss": shCuss,
    "sh_boxs": shBoxs,
  };
}
