// To parse this JSON data, do
//
//     final member = memberFromJson(jsonString);

import 'dart:convert';

// List<Member> memberFromJson(String str) => List<Member>.from(json.decode(str).map((x) => Member.fromJson(x)));
//
// String memberToJson(List<Member> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

Member memberFromJson(String str) => Member.fromJson(json.decode(str));

String memberToJson(Member data) => json.encode(data.toJson());

class Member {
  Member({
    required this.memId,
    required this.memCode,
    required this.memName,
    required this.memAddress,
    required this.memAddshipping,
    required this.memImg1,
    required this.memImg2,
    required this.memImg3,
    required this.memMobile,
    required this.memLineadd,
    required this.memLatitude,
    required this.memLongitude,
    required this.saleName,
    required this.salePhone,
  });

  String memId;
  String memCode;
  String memName;
  String memAddress;
  String memAddshipping;
  String memImg1;
  String memImg2;
  String memImg3;
  String memMobile;
  String memLineadd;
  String memLatitude;
  String memLongitude;
  String saleName;
  String salePhone;

  factory Member.fromJson(Map<String, dynamic> json) => Member(
    memId: json["mem_id"],
    memCode: json["mem_code"],
    memName: json["mem_name"],
    memAddress: json["mem_address"],
    memAddshipping: json["mem_addshipping"],
    memImg1: json["mem_img1"],
    memImg2: json["mem_img2"],
    memImg3: json["mem_img3"],
    memMobile: json["mem_mobile"],
    memLineadd: json["mem_lineadd"],
    memLatitude: json["mem_latitude"],
    memLongitude: json["mem_longitude"],
    saleName: json["sale_name"],
    salePhone: json["sale_phone"],
  );

  Map<String, dynamic> toJson() => {
    "mem_id": memId,
    "mem_code": memCode,
    "mem_name": memName,
    "mem_address": memAddress,
    "mem_addshipping": memAddshipping,
    "mem_img1": memImg1,
    "mem_img2": memImg2,
    "mem_img3": memImg3,
    "mem_mobile": memMobile,
    "mem_lineadd": memLineadd,
    "mem_latitude": memLatitude,
    "mem_longitude": memLongitude,
    "sale_name": saleName,
    "sale_phone": salePhone,
  };
}
