import 'package:flights/utils/local/local_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});
  final LocalController localController = Get.find<LocalController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocalController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: ListTile(
                title: Text("Language".tr),
                leading: const Icon(Icons.language),
                subtitle: Text("lang".tr),
                trailing: TextButton(
                  onPressed: () {
                    final newLang = controller.initialLang.languageCode == "ar"
                        ? "en"
                        : "ar";
                    controller.changeLang(newLang);
                  },
                  child: Text("change".tr),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
