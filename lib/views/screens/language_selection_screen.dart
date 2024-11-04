import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/language_controller.dart';

class LanguageSelectionScreen extends StatelessWidget {
  // Initialize the LanguageController
  final LanguageController languageController = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'change_language'.tr,
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          ListTile(
            title: Text('English'),
            onTap: () {
              languageController.changeLanguage('en_US');
            },
          ),
          ListTile(
            title: Text('Français'),
            onTap: () {
              languageController.changeLanguage('fr_FR');
            },
          ),
        ],
      ),
    );
  }
}
