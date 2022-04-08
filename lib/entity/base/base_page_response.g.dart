
import 'package:base_model_getx/entity/base/base_page_response.dart';
import 'package:base_model_getx/generated/json/base/json_convert_content.dart';

BasePageResponse<T> $BasePageResponseFromJson<T>(Map<String, dynamic> json) {
	final BasePageResponse<T> response = BasePageResponse<T>();
	final BasePageResponseData<T>? data = BasePageResponseData<T>.fromJson(json['data']);
	if (data != null) {
		response.data = data;
	}
	final int? code = jsonConvert.convert<int>(json['code']);
	if (code != null) {
		response.code = code;
	}
	final String? msg = jsonConvert.convert<String>(json['msg']);
	if (msg != null) {
		response.msg = msg;
	}
	final int? timestamp = jsonConvert.convert<int>(json['timestamp']);
	if (timestamp != null) {
		response.timestamp = timestamp;
	}
	return response;
}

Map<String, dynamic> $BasePageResponseToJson(BasePageResponse entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['data'] = entity.data?.toJson();
	data['code'] = entity.code;
	data['msg'] = entity.msg;
	data['timestamp'] = entity.timestamp;
	return data;
}

BasePageResponseData<T> $BasePageResponseDataFromJson<T>(Map<String, dynamic> json) {
	final BasePageResponseData<T> responseData = BasePageResponseData<T>();
	final int? total = jsonConvert.convert<int>(json['total']);
	if (total != null) {
		responseData.total = total;
	}
	final int? pages = jsonConvert.convert<int>(json['pages']);
	if (pages != null) {
		responseData.pages = pages;
	}
	final List<T>? records = jsonConvert.convertListNotNull<T>(json['records']);
	if (records != null) {
		responseData.records = records;
	}
	return responseData;
}

Map<String, dynamic> $BasePageResponseDataToJson(BasePageResponseData entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['total'] = entity.total;
	data['pages'] = entity.pages;
	data['records'] =  entity.records;
	return data;
}