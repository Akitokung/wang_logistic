import 'dart:convert';

List<RouteList> routeFromJson(String str) =>
    List<RouteList>.from(json.decode(str).map((x) => RouteList.fromJson(x)));

String routeToJson(List<RouteList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RouteList {
  RouteList({
    required this.msId,
    required this.msCode,
    required this.msName,
    required this.msStickname,
    required this.msNonr,
    required this.msWeek,
    required this.msCusAll,
    required this.msCus0,
    required this.msBox0,
    required this.msCus2,
    required this.msBox2,
    required this.msImg,
    required this.msENow,
    required this.msNNow,
    required this.msTNow,
    required this.msELast,
    required this.msNLast,
    required this.msTLast,
  });

  String msId;
  String msCode;
  String msName;
  String msStickname;
  String msNonr;
  String msWeek;
  String msCusAll;
  String msCus0;
  String msBox0;
  String msCus2;
  String msBox2;
  String msImg;
  String msENow;
  String msNNow;
  String msTNow;

  String msELast;
  String msNLast;
  String msTLast;

  factory RouteList.fromJson(Map<String, dynamic> json) => RouteList(
        msId: json["ms_id"],
        msCode: json["ms_code"],
        msName: json["ms_name"],
        msStickname: json["ms_stickname"],
        msNonr: json["ms_NONR"],
        msWeek: json["ms_Week"],
        msCusAll: json["ms_Cusall"],
        msCus0: json["ms_Cus0"],
        msBox0: json["ms_Box0"],
        msCus2: json["ms_Cus2"],
        msBox2: json["ms_Box2"],
        msImg: json["ms_img"],
        msENow: json["ms_now"],
        msNNow: json["ms_Nnow"],
        msTNow: json["ms_Ntime"],
        msELast: json["ms_Nlast"],
        msNLast: json["ms_Nlast"],
        msTLast: json["ms_Ltime"],
      );

  Map<String, dynamic> toJson() => {
        "ms_id": msId,
        "ms_code": msCode,
        "ms_name": msName,
        "ms_stickname": msStickname,
        "ms_NONR": msNonr,
        "ms_Week": msWeek,
        "ms_Cusall": msCusAll,
        "ms_Cus0": msCus0,
        "ms_Box0": msBox0,
        "ms_Cus2": msCus2,
        "ms_Box2": msBox2,
        "ms_img": msImg,
        "ms_now": msENow,
        "ms_Nnow": msNNow,
        "ms_Ntime": msTNow,
        "ms_last": msELast,
        "ms_Nlast": msNLast,
        "ms_Ltime": msTLast,
      };
}
