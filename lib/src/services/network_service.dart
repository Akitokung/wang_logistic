import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wang_logistic/src/constants/api.dart';
import 'package:wang_logistic/src/models/inprocess.dart';
import 'package:wang_logistic/src/models/member.dart';
import 'package:wang_logistic/src/models/picking.dart';
import 'package:wang_logistic/src/models/pickingbox.dart';
import 'package:wang_logistic/src/models/profile.dart';
import 'package:wang_logistic/src/models/readyship.dart';
import 'package:wang_logistic/src/models/route.dart';
import 'package:wang_logistic/src/models/self.dart';
import 'package:wang_logistic/src/models/shipping.dart';

class NetworkService {
  NetworkService._internal();

  static final NetworkService _instance = NetworkService._internal();

  factory NetworkService() => _instance;

  static final _dio = Dio()
    ..interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          final token = prefs.getString('token') ?? '';
          options.baseUrl = API.BASE_URL;
          options.connectTimeout = 5000;
          options.receiveTimeout = 3000;
          // options.headers['content-Type'] = 'application/json';
          // options.headers = {
          //   'authorization': 'Bearer $token',
          // };
          options.headers['Authorization'] = "Bearer $token";
          // print(options.baseUrl + options.path + options.headers['Authorization']);
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioError error, handler) {
          return handler.next(error);
        },
      ),
    );

  static Future postPickup(id) async {
    var params = {"lg_id": id};
    const url = API.API_UpCat;
    final Response response = await _dio.post(
      url,
      options: Options(
        headers: {
          // 'Content-Type': 'application/json',
          "Content-Type": "application/x-www-form-urlencoded"
        },
        // contentType: 'application/json',
      ),
      data: params,
    );
    print(response.data);
    if (response.statusCode == 200) {
      return response.statusCode;
    }
    throw Exception('Network failed');
  }

  static Future<Profice> getProfice() async {
    const url = API.API_Profile;
    final Response response = await _dio.get(url);
    if (response.statusCode == 200) {
      return proficeFromJson(jsonEncode(response.data));
    }
    throw Exception('Network failed');
  }

  static Future<Member> getMember(String code) async {
    final url = API.API_Member + '?mem_code=' + code;
    final Response response = await _dio.get(url);
    // print(response.data);
    if (response.statusCode == 200) {
      return memberFromJson(jsonEncode(response.data));
    }
    throw Exception('Network failed');
  }

  static Future<List<RouteList>> getRoute() async {
    const url = API.API_Route;
    final Response response = await _dio.get(url);
    if (response.statusCode == 200) {
      return routeFromJson(jsonEncode(response.data));
    }
    throw Exception('Network failed');
  }

  static Future<ReadyShipping> getReadyShipping(String code) async {
    final url = API.API_ReadyAmount + '?code=' + code;
    final Response response = await _dio.get(url);
    if (response.statusCode == 200) {
      return readyShippingFromJson(jsonEncode(response.data));
    }
    throw Exception('Network failed');
  }

  static Future<List<Onshipping>> getOnShipping() async {
    const url = API.API_ShipAmount;
    final Response response = await _dio.get(url);
    if (response.statusCode == 200) {
      return onshippingFromJson(jsonEncode(response.data));
    }
    throw Exception('Network failed');
  }

  Future<List<Picking>> getPicking(String code) async {
    final url = API.API_Picking + '?route=' + code;
    final Response response = await _dio.get(url);
    // print(url);
    if (response.statusCode == 200) {
      return pickingFromJson(jsonEncode(response.data));
    }
    throw Exception('Network failed');
  }

  static Future<List<Set>> getPickingBox(String code) async {
    final url = API.API_PickingBox + '?mem_code=' + code;
    final Response response = await _dio.get(url);
    // print(url);
    if (response.statusCode == 200) {
      return setFromJson(jsonEncode(response.data));
    }
    throw Exception('Network failed');
  }

  Future<List<Inprocess>> getInProcess(String code) async {
    final url = API.API_InProcess + '?route=' + code;
    final Response response = await _dio.get(url);
    // print(url);
    // print(response.data);
    if (response.statusCode == 200) {
      return inprocessFromJson(jsonEncode(response.data));
    }
    throw Exception('Network failed');
  }

  Future<List<Self>> getSelf(String code) async {
    final url = API.API_Self + '?route=' + code;
    final Response response = await _dio.get(url);
    if (response.statusCode == 200) {
      return selfFromJson(jsonEncode(response.data));
    }
    throw Exception('Network failed');
  }
}
