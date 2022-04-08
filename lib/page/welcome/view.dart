import 'package:base_model_getx/components/base_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class WelcomePage extends StatelessWidget {
  final logic = Get.find<WelcomeLogic>();
  final state = Get.find<WelcomeLogic>().state;

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: Center(child: Text('GetX 项目模型')),
    );
  }
}
