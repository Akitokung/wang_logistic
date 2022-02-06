// To parse this JSON data, do
//
//     final set = setFromJson(jsonString);

import 'dart:convert';

List<Set> setFromJson(String str) => List<Set>.from(json.decode(str).map((x) => Set.fromJson(x)));

String setToJson(List<Set> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Set {
  Set({
    required this.setId,
    required this.setNo,
    required this.setBoxs,
    required this.setBill1,
    required this.setBill2,
    required this.setBill3,
    required this.setBill4,
    required this.setBill5,
    required this.setBill6,
    required this.setStatus,
    required this.setQc,
    required this.setPack,
    required this.setCreate,
    required this.setSticker,
  });

  String setId;
  String setNo;
  String setBoxs;
  String setBill1;
  String setBill2;
  String setBill3;
  String setBill4;
  String setBill5;
  String setBill6;
  String setStatus;
  String setQc;
  String setPack;
  String setCreate;
  String setSticker;

  factory Set.fromJson(Map<String, dynamic> json) => Set(
    setId: json["set_id"],
    setNo: json["set_no"],
    setBoxs: json["set_boxs"],
    setBill1: json["set_bill1"],
    setBill2: json["set_bill2"],
    setBill3: json["set_bill3"],
    setBill4: json["set_bill4"],
    setBill5: json["set_bill5"],
    setBill6: json["set_bill6"],
    setStatus: json["set_status"],
    setQc: json["set_qc"],
    setPack: json["set_pack"],
    setCreate: json["set_create"],
    setSticker: json["set_sticker"],
  );

  Map<String, dynamic> toJson() => {
    "set_id": setId,
    "set_no": setNo,
    "set_boxs": setBoxs,
    "set_bill1": setBill1,
    "set_bill2": setBill2,
    "set_bill3": setBill3,
    "set_bill4": setBill4,
    "set_bill5": setBill5,
    "set_bill6": setBill6,
    "set_status": setStatus,
    "set_qc": setQc,
    "set_pack": setPack,
    "set_create": setCreate,
    "set_sticker": setSticker,
  };
}
