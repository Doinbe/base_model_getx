import 'dart:convert';
import 'package:base_model_getx/entity/base/base_response.g.dart';
import 'package:base_model_getx/http/app_exceptions.dart';

class BaseResponse<T> {
  Status? status;
	int? code;
	String? msg;
	T? data;
  AppException? exception;
  BaseResponse.completed(this.data) : status = Status.COMPLETED;
  BaseResponse.error(this.exception) : status = Status.ERROR;

  BaseResponse();

  factory BaseResponse.fromJson(Map<String, dynamic> json) => $BaseResponseFromJson<T>(json);

  Map<String, dynamic> toJson() => $BaseResponseToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

enum Status { COMPLETED, ERROR }