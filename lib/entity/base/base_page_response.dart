import 'dart:convert';

import 'package:base_model_getx/entity/base/base_page_response.g.dart';
class BasePageResponse<T> {
  BasePageResponseData<T>? data;
	int? code;
	String? msg;
	int? timestamp;

  BasePageResponse();

  factory BasePageResponse.fromJson(Map<String, dynamic> json) => $BasePageResponseFromJson(json);

  Map<String, dynamic> toJson() => $BasePageResponseToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

class BasePageResponseData<T> {

	int? total;
	int? pages;
	List<T>? records;

  BasePageResponseData();

  factory BasePageResponseData.fromJson(Map<String, dynamic> json) => $BasePageResponseDataFromJson(json);

  Map<String, dynamic> toJson() => $BasePageResponseDataToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}