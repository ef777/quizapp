// ignore_for_file: avoid_print, depend_on_referenced_packages

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../const/const.dart';
import '../../model/auth/login_model.dart';
import '../token_service.dart';

Future<LoginModel?> loginService(
    {required String email, required String password}) async {
  final url = Uri.parse('https://aciksoru.com.tr/api/login');
  final headers = {'Content-Type': 'application/json'};
  final body = jsonEncode({'email': email, 'password': password});
  final response = await http.post(url, headers: headers, body: body);
  print(response.body);

  if (response.statusCode == 200) {
    var model = LoginModel.fromJson(jsonDecode(response.body));
    Config.bareerToken = model.data?.token;
    Config.userId = model.data?.id;
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("rolemm", (model.data?.role ?? ""));
    SharedService().saveLogin(model.data?.token, model.data?.id.toString());
    print('Başarılı yanıt: ${response.body}');

    return model;
  } else {
    var model = ErrorModel.fromJson(jsonDecode(response.body));

    return LoginModel(
        success: false,
        message: model.data?.error == ""
            ? "Giriş Bilgilerinizi Kontrol Ediniz"
            : model.data?.error);
  }
}

class ErrorModel {
  bool? success;
  String? message;
  Data? data;

  ErrorModel({this.success, this.message, this.data});

  ErrorModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? error;

  Data({this.error});

  Data.fromJson(Map<String, dynamic> json) {
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    return data;
  }
}
