import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zrj/controllers/controller_authentication.dart';
import 'package:zrj/model/user.dart';
import '../../../constants/colors.dart';
import '../../../constants/fonts.dart';
import '../../../utils/form_valid.dart';
import '../../../utils/status_bar.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/my_address_costom_textt_field.dart';

class LayoutMyAccount extends StatefulWidget {
  @override
  State<LayoutMyAccount> createState() => _LayoutMyAccountState();
}

class _LayoutMyAccountState extends State<LayoutMyAccount> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ControllerAuthentication controller = Get.put(ControllerAuthentication());
  UserModel? user;
  @override
  void initState() {
    super.initState();
    // controller.fetchUserIdByToken();
    // log("user data ${controller.fetchUserIdByToken()}");
  }
  @override
  Widget build(BuildContext context) {
    AppStatusBar.light();
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        leading: _buildBackButton(),
        title: Text("MY ACCOUNT", style: AppFontsStyle.profileAppBar),
        centerTitle: true,
      ),
      body: _buildUserDetailsForm(),
    );
  }

  Widget _buildBackButton() {
    return InkWell(
      onTap: () => Get.back(),
      child: CircleAvatar(
        radius: 10.r,
        backgroundColor: Colors.red,
        child: Icon(Icons.arrow_back, color: Colors.white),
      ).marginSymmetric(horizontal: 10.sp, vertical: 10.sp),
    );
  }

  Widget _buildUserDetailsForm() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: 27.h,
            left: 22.w,
            right: 41.w,
            top: 15.h,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildSectionTitle("Your Details"),
                _buildTextField(controller.firstName.value, user?.firstName ?? "First Name"),
                _buildTextField(controller.lastName.value, user?.lastName ?? "Last Name"),
                _buildTextFieldEmail(controller.email.value, user?.email ?? "Email"),
                _buildPhoneField(),
                _buildSectionTitle("Main Address"),
                _buildTextField(controller.country.value, user?.shipping!.country ?? "Country"),
                _buildTextField(controller.city.value, user?.shipping!.city ?? "City"),
                _buildTextField(controller.state.value, user?.shipping!.state ?? "State"),
                _buildUpdateDetailsButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(title, style: AppFontsStyle.profileTitle),
    ).marginOnly(top: 15.h, bottom: 25.h);
  }

  Widget _buildTextField(TextEditingController controller, String hint) {
    return MyAddressCostomTexttField(
      controller: controller,
      hint: hint,
      // validator: (value) => FormValidator.validateName(value), // Example validation
    );
  }
  Widget _buildTextFieldEmail(TextEditingController controller, String hint) {
    return MyAddressCostomTexttField(
      controller: controller,
      hint: hint,
      validator: (value) => FormValidator.validateEmail(value), // Example validation
    );
  }

  Widget _buildPhoneField() {
    return MyAddressCostomTexttField(
      controller: controller.phoneNumber.value,
      hint: 'Phone Number',
    );
  }

  Widget _buildUpdateDetailsButton() {
    return CustomButton(
      onTap: () async {
        final userId = await controller.getUserId();
        if (_formKey.currentState!.validate()) {
          if (userId != null) {
            controller.updateUserDetails(userId);
            Get.back();
          }else {
            log("No User ID found in local storage.");
          }
        }
      },
      text: "UPDATE DETAILS",
      textColor: Colors.white,
      buttonColor: AppColors.buttonColor,
    ).marginSymmetric(vertical: 8.sp);
  }
}
