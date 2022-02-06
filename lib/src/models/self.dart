// To parse this JSON data, do
//
//     final self = selfFromJson(jsonString);

import 'dart:convert';

List<Self> selfFromJson(String str) => List<Self>.from(json.decode(str).map((x) => Self.fromJson(x)));

String selfToJson(List<Self> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Self {
  Self({
    required this.memNo,
    required this.memImg,
    required this.memCode,
    required this.memName,
    required this.memRoute,
    required this.memAddress,
    required this.memAddress1,
    required this.memAddress2,
    required this.lgSet,
    required this.lgBox,
    required this.lgStdate,
    required this.lgSttime,
    required this.memSale,
    required this.memQc,
    required this.memPack,
    required this.memLogistic,
    required this.lastDship,
    required this.lastTship,
    required this.memOwner,
    required this.memOwnermobile,
    required this.memPharma,
    required this.memPharmamobile,
  });

  String memNo;
  String memImg;
  String memCode;
  String memName;
  String memRoute;
  String memAddress;
  String memAddress1;
  String memAddress2;
  String lgSet;
  String lgBox;
  String lgStdate;
  String lgSttime;
  String memSale;
  String memQc;
  String memPack;
  String memLogistic;
  String lastDship;
  String lastTship;
  String memOwner;
  String memOwnermobile;
  String memPharma;
  String memPharmamobile;

  factory Self.fromJson(Map<String, dynamic> json) => Self(
    memNo: json["mem_no"],
    memImg: json["mem_img"],
    memCode: json["mem_code"],
    memName: json["mem_name"],
    memRoute: json["mem_route"],
    memAddress: json["mem_address"],
    memAddress1: json["mem_address1"],
    memAddress2: json["mem_address2"],
    lgSet: json["lg_set"],
    lgBox: json["lg_box"],
    lgStdate: json["lg_stdate"],
    lgSttime: json["lg_sttime"],
    memSale: json["mem_sale"],
    memQc: json["mem_qc"],
    memPack: json["mem_pack"],
    memLogistic: json["mem_logistic"],
    lastDship: json["last_Dship"],
    lastTship: json["last_Tship"],
    memOwner: json["mem_owner"],
    memOwnermobile: json["mem_ownermobile"],
    memPharma: json["mem_pharma"],
    memPharmamobile: json["mem_pharmamobile"],
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
    "lg_set": lgSet,
    "lg_box": lgBox,
    "lg_stdate": lgStdate,
    "lg_sttime": lgSttime,
    "mem_sale": memSale,
    "mem_qc": memQc,
    "mem_pack": memPack,
    "mem_logistic": memLogistic,
    "last_Dship": lastDship,
    "last_Tship": lastTship,
    "mem_owner": memOwner,
    "mem_ownermobile": memOwnermobile,
    "mem_pharma": memPharma,
    "mem_pharmamobile": memPharmamobile,
  };
}

