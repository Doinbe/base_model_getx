
/// 检查邮箱格式
bool duIsEmail(String? input) {
  if (input == null || input.isEmpty) return false;
  // 邮箱正则
  String regexEmail = "^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*\$";
  return RegExp(regexEmail).hasMatch(input);
}

/// 检查字符长度
bool duCheckStringLength(String? input, int length) {
  if (input == null || input.isEmpty) return false;
  return input.length >= length;
}

/// 检查大陆手机号码11位数
bool isChinaPhoneLegal(String? input) {
  if (input == null || input.isEmpty) return false;
  // 手机号码正则
  String regexPhone =
      '^((13[0-9])|(15[^4])|(166)|(17[0-8])|(18[0-9])|(19[8-9])|(147,145))\\d{8}\$';
  return RegExp(regexPhone).hasMatch(input);
}

/// 时间双位数
String twoDigits(int n) {
  if (n >= 10) return "${n}";
  return "0${n}";
}

/// 时间双位数
String fourDigits(int n) {
  int absN = n.abs();
  String sign = n < 0 ? "-" : "";
  if (absN >= 1000) return "$n";
  if (absN >= 100) return "${sign}0$absN";
  if (absN >= 10) return "${sign}00$absN";
  return "${sign}000$absN";
}

/// 时间显示（yyyy-mm-dd hh:mm:ss）
String dateTimeToDayShow(DateTime value) {
  return '${fourDigits(value.year)}-${twoDigits(value.month)}-${twoDigits(value.day)} ${twoDigits(value.hour)}:${twoDigits(value.minute)}:${twoDigits(value.second)}';
}

/// 时间显示（hh-mm-ss）
String dateTimeToTimeShow(DateTime value) {
  return '${twoDigits(value.hour)}:${twoDigits(value.minute)}:${twoDigits(value.second)}';
}


