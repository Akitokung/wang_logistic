import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:wang_logistic/src/services/network_service.dart';

class ProviderProfile with ChangeNotifier {

  String _empId = '';
  String _empCode = '';
  String _empNickname = '';
  String _empFullname = '';
  String _empImg = '';
  String _empMobileS = '';
  bool _empLogistic = false;
  bool _empSale = false;
  bool _empSalesupport = false;
  String _shippingShop = '';
  String _shippingBoxs = '';

  String get empId => _empId;
  String get empCode => _empCode;
  String get empNickname => _empNickname;
  String get empFullname => _empFullname;
  String get empImg => _empImg;
  String get empMobileS => _empMobileS;
  bool get empLogistic => _empLogistic;
  bool get empSale => _empSale;
  bool get empSalesupport => _empSalesupport;
  String get shippingShop => _shippingShop;
  String get shippingBoxs => _shippingBoxs;

  Future empProfice() async {
    var respon = await NetworkService.getProfice();
    // print('respon empProfice => ${respon.empCode}');
    empCode = respon.empCode;
    empNickname = respon.empNickname;
    empFullname = respon.empFullname;
    empImg = respon.empImg;
    empMobileS = respon.empMobileS;
    empLogistic = respon.empLogistic;
    empSale = respon.empSale;
    empSalesupport = respon.empSalesupport;
    shippingShop = respon.shippingShop;
    shippingBoxs = respon.shippingBoxs;
  }

  set empId(String empId) {
    _empId = empId;
    notifyListeners();
  }

  set empCode(String nempCode) {
    _empCode = nempCode;
    notifyListeners();
  }

  set empNickname(String empNickname) {
    _empNickname = empNickname;
    notifyListeners();
  }

  set empFullname(String empFullname) {
    _empFullname = empFullname;
    notifyListeners();
  }

  set empImg(String empImg) {
    _empImg = empImg;
    notifyListeners();
  }

  set empMobileS(String empMobileS) {
    _empMobileS = empMobileS;
    notifyListeners();
  }

  set empLogistic(bool empLogistic) {
    _empLogistic = empLogistic;
    notifyListeners();
  }

  set empSale(bool empSale) {
    _empSale = empSale;
    notifyListeners();
  }

  set empSalesupport(bool empSalesupport) {
    _empSalesupport = empSalesupport;
    notifyListeners();
  }

  set shippingShop(String shippingShop) {
    _shippingShop = shippingShop;
    notifyListeners();
  }

  set shippingBoxs(String shippingBoxs) {
    _shippingBoxs = shippingBoxs;
    notifyListeners();
  }

}
