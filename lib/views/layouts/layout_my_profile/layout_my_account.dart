 
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../constants/colors.dart';
import '../../../constants/fonts.dart';
import '../../../utils/form_valid.dart';
import '../../../utils/status_bar.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_button_border_color.dart';
import '../../../widgets/my_address_costom_textt_field.dart';
import '../../screens/authentication_screens/screen_set_new_password.dart';

class LayoutMyAccount extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
      body: SafeArea(
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
                children: [
                  _buildSectionTitle("Your Details"),
                  _buildTextField('First Name'),
                  _buildTextField('Last Name'),
                  _buildDOBField(context), // Pass context here
                  _buildPhoneField(),
                  _buildSectionTitle("Main Address"),
                  _buildTextField('Address'),
                  _buildTextField('Further information (Optional)'),
                  _buildAddressFields(),
                  _buildUpdatePasswordButton(),
                  _buildUpdateDetailsButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton() {
    return InkWell(
      onTap: () => Get.back(),
      child: CircleAvatar(
        radius: 10.r,
        backgroundColor: Color(0xff4C6042),
        child: Icon(Icons.arrow_back, color: Colors.white),
      ).marginSymmetric(horizontal: 10.sp, vertical: 10.sp),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(title, style: AppFontsStyle.profileTitle),
    ).marginOnly(top: 15.h, bottom: 25.h);
  }

  Widget _buildTextField(String hint) {
    return MyAddressCostomTexttField(
      hint: hint,
      validator: (value) =>
          FormValidator.validateName(value), // Example validation
    );
  }

  Widget _buildDOBField(BuildContext context) {
    // Accept context as a parameter
    return MyAddressCostomTexttField(
      suffix: IconButton(
        onPressed: () async {
          final DateTime? picked = await showDatePicker(
            builder: (context, child) {
              return Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: ColorScheme.light(primary: Color(0xff4C6042)),
                  textButtonTheme: TextButtonThemeData(
                      style:
                          TextButton.styleFrom(foregroundColor: Colors.black)),
                ),
                child: child!,
              );
            },
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime(2101),
          );
          // Handle date selection
        },
        icon: Icon(CupertinoIcons.calendar, color: Color(0xff4C6042)),
      ),
      hint: 'Date of birth',
      readOnly: true,
    );
  }

  Widget _buildPhoneField() {
    return Row(
      children: [
        MyAddressCostomTexttField(
          width: 100.w,
          readOnly: true,
          prefix: CountryCodePicker(
            padding: EdgeInsets.symmetric(horizontal: 5),
            onChanged: (value) {
              // Handle country code change
            },
            textStyle: TextStyle(
                fontSize: 14.sp, fontFamily: "Arial", color: Colors.black),
            showCountryOnly: false,
            showOnlyCountryWhenClosed: false,
            alignLeft: false,
          ),
          hint: '+1', // Default hint
        ).marginSymmetric(horizontal: 5.sp),
        SizedBox(width: 8.w),
        Expanded(
          flex: 2,
          child: MyAddressCostomTexttField(
            hint: 'Enter phone number',
            keyboardType: TextInputType.phone,
            validator: FormValidator.validatePhone,
          ),
        ),
      ],
    );
  }

  Widget _buildAddressFields() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child:
                  _buildTextField('Country').marginSymmetric(horizontal: 5.sp),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: _buildTextField('City'),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: _buildTextField('Governorate')
                  .marginSymmetric(horizontal: 5.sp),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: _buildTextField('Locality'),
            ),
          ],
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: _buildTextField('Region'),
        ),
      ],
    );
  }

  Widget _buildUpdatePasswordButton() {
    return CustomButtonBorder(
      onTap: () {
        Get.to(ScreenSetNewPassword());
      },
      isBorder: true,
      textColor: Colors.black,
      text: 'UPDATE PASSWORD',
      isRound: true,
    ).marginOnly(top: 20.sp);
  }

  Widget _buildUpdateDetailsButton() {
    return CustomButton(
      onTap: () async {
        if (_formKey.currentState!.validate()) {
          // Handle update details
        }
      },
      text: "UPDATE DETAILS",
      textColor: Colors.white,
      buttonColor: Colors.black,
    ).marginSymmetric(vertical: 8.sp);
  }
}
