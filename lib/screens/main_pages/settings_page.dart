import 'package:Mate8/controller/settings_controller.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/components.dart';
import '../../styles/static_colors.dart';
import '../../styles/static_styles.dart';

class SettingsPage extends GetView<SettingsController> {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: StaticColors.primaryColor,
      appBar: AppBar(
        title: Text('Settings'.tr),
        centerTitle: true,
        shadowColor: Colors.transparent,
        backgroundColor: StaticColors.primaryColor,
      ),
      body: Container(
        decoration: const BoxDecoration(
            color: StaticColors.secondaryColor,
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(StaticStyles.borderRadius))),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              _buildSettingsPanel(
                  icon: FluentIcons.flag_16_regular,
                  text: 'ChooseLanguage'.tr,
                  onTap: controller.changeLanguage),
              _buildSeperator(),
              _buildSettingsPanel(
                  icon: FluentIcons.wrench_16_regular, text: 'EditProfile'.tr),
              _buildSeperator(),
              _buildSettingsPanel(
                  icon: FluentIcons.password_16_regular,
                  text: 'ChangePassword'.tr,
                  onTap: controller.showChangePasswordDialog),
              _buildSeperator(),
              _buildSettingsPanel(
                  icon: FluentIcons.eye_16_regular,
                  text: 'ChangeVisibility'.tr),
              _buildSeperator(),
              _buildSettingsPanel(
                  icon: FluentIcons.delete_16_regular,
                  text: 'DeleteProfile'.tr),
              _buildSeperator(),
              _buildSettingsPanel(
                  icon: FluentIcons.info_16_regular,
                  text: 'AppInfo'.tr,
                  onTap: controller.showAppInfo),
              _buildSeperator(),
              const SizedBox(
                height: 50,
              ),
              CustomButton(
                "SignOut".tr,
                onTap: controller.signOut,
                fontColor: Colors.white,
                color: Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsPanel(
      {required IconData icon, required String text, void Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Icon(icon),
            const SizedBox(
              width: 5,
            ),
            Text(text),
            const Expanded(
                child: Align(
                    alignment: Alignment.centerRight,
                    child: Icon(FluentIcons.ios_arrow_rtl_24_filled)))
          ],
        ),
      ),
    );
  }

  Widget _buildSeperator() {
    return Container(
      width: double.infinity - 50,
      margin: const Pad(vertical: 5),
      height: 1,
      decoration: BoxDecoration(
          color: Colors.grey, borderRadius: BorderRadius.circular(1)),
    );
  }
}
