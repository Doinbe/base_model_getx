
import 'package:base_model_getx/entity/base/base_response.dart';
import 'package:base_model_getx/generated/json/base/json_convert_content.dart';

BaseResponse<T> $BaseResponseFromJson<T>(Map<String, dynamic> json) {
	final BaseResponse<T> baseResponse = BaseResponse<T>();
	final int? code = jsonConvert.convert<int>(json['code']);
	if (code != null) {
		baseResponse.code = code;
	}
	final String? msg = jsonConvert.convert<String>(json['msg']);
	if (msg != null) {
		baseResponse.msg = msg;
	}
	final T? data = jsonConvert.convert<T>(json['data']);
	if (data != null) {
		baseResponse.data = data;
	}
	return baseResponse;
}

Map<String, dynamic> $BaseResponseToJson(BaseResponse entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['code'] = entity.code;
	data['msg'] = entity.msg;
	data['data'] = entity.data;
	return data;
}