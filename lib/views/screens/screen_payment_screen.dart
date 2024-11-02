import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';
import '../../constants/fonts.dart'; 
import '../../widgets/custom_button.dart';
import '../../widgets/custom_description_input_field.dart';
import '../../widgets/custom_text_field.dart';
import '../items/bottom_sheets/bottom_sheet_payment.dart';
import '../layouts/layout_my_profile/layout_purchase_receipt.dart';

class ScreenPaymentScreen extends StatelessWidget {
  final double totalPrice;
  List<Product> cartItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        leading: InkWell(
          onTap: () => Get.back(),
          child: CircleAvatar(
            radius: 15.r,
            backgroundColor: const Color(0xff4C6042),
            child: const Icon(Icons.arrow_back, color: Colors.white),
          ).marginSymmetric(
            horizontal: 10.w,
            vertical: 10.h,
          ),
        ),
        title: Text(
          "Payment",
          style: AppFontsStyle.profileAppBar,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  _buildShippingAddressSection(),
                  _buildDressDetailsSection(context),
                  _buildDeliveryServiceSection(context),
                  _buildDescriptionSection(),
                  _buildPaymentSummarySection(),
                ],
              ),
            ),
            _buildBottomCheckoutSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildShippingAddressSection() {
    return GestureDetector(
      onTap: () {
        // Navigate to address editing
      },
      child: Container(
        padding: EdgeInsets.all(20.0),
        margin: EdgeInsets.symmetric(vertical: 8.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            boxShadow: [AppColors.myCustomBoxShadow],
            color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset("assets/icons/Location_Icon.svg"),
                SizedBox(width: 8.w),
                Text("Shipping Address", style: AppFontsStyle.profileDetails),
                const Spacer(),
                Text("Edit", style: AppFontsStyle.editButton)
                    .marginOnly(right: 10.w),
                SvgPicture.asset("assets/icons/next_button.svg"),
              ],
            ),
            Divider(color: AppColors.appGreyColor, height: 20.h),
            _buildShippingDetails(),
          ],
        ),
      ),
    );
  }

  Widget _buildShippingDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("User data not found", style: AppFontsStyle.introScrTitle),
      ],
    );
  }

  Widget _buildDressDetailsSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 27.w, bottom: 10.h, right: 15.h, top: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [AppColors.myCustomBoxShadow],
      ),
      child: Column(
        children: cartItem.map((selected) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildDressImage("https://cdn-icons-png.flaticon.com/512/9584/9584876.png"),
              SizedBox(width: 19.w),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("dress Name", style: AppFontsStyle.profileDetails),
                    SizedBox(height: 4.h),
                    Text(
                      textAlign: TextAlign.start,
                      maxLines: 3,
                      "Color: color | Size: size",
                      style: AppFontsStyle.editButton,
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("\$ 44", style: AppFontsStyle.profileDetails),
                        Text("x\ quantity", style: AppFontsStyle.profileDetails)
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ).marginOnly(bottom: 24.h);
        }).toList(),
      ),
    );
  }

  Widget _buildDressImage(String imageUrl) {
    return Container(
      height: 77.29.h,
      width: 77.29.w,
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [AppColors.myCustomBoxShadow],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Center(
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(height: 60.h, width: 60.w, color: Colors.grey),
          ),
        ),
      ),
    );
  }

  Widget _buildDeliveryServiceSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      margin: EdgeInsets.symmetric(vertical: 8.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [AppColors.myCustomBoxShadow],
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              // Show payment type sheet
            },
            child: Row(
              children: [
                Text("Delivery Service", style: AppFontsStyle.editButton),
                const Spacer(),
                Text("Edit", style: AppFontsStyle.profileAppBar).marginOnly(right: 5.w),
                SvgPicture.asset("assets/icons/next_button.svg").paddingAll(4.h),
              ],
            ),
          ),
          Divider(color: AppColors.appGreyColor, height: 20.h),
          Text("Express Delivery", style: AppFontsStyle.profileDetails),
        ],
      ),
    );
  }

  Widget _buildDescriptionSection() {
    return Container(
      padding: EdgeInsets.all(20.0),
      margin: EdgeInsets.symmetric(vertical: 8.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [AppColors.myCustomBoxShadow],
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Add Description", style: AppFontsStyle.profileDetails),
          SizedBox(height: 8.h),
          DescriptionInputField(
            height: 84.h,
            hint: "Tell us how you feel about our products...",
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentSummarySection() {
    return Container(
      padding: EdgeInsets.all(20.0),
      margin: EdgeInsets.symmetric(vertical: 8.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [AppColors.myCustomBoxShadow],
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text("Payment Method", style: AppFontsStyle.editButton),
              const Spacer(),
              const Icon(CupertinoIcons.folder, color: Color(0xff4C6042)),
              SizedBox(width: 8.w),
              Text("My Pay", style: AppFontsStyle.profileAppBar).marginOnly(right: 5.w),
              GestureDetector(
                onTap: () {},
                child: SvgPicture.asset("assets/icons/next_button.svg").paddingAll(4.h),
              ),
            ],
          ),
          Divider(color: AppColors.appGreyColor, height: 20.h),
          _buildPaymentDetails(),
        ],
      ),
    );
  }

  Widget _buildPaymentDetails() {
    return Column(
      children: [
        _buildSummaryRow("Subtotals for products", "\$${totalPrice.toStringAsFixed(0)}"),
        _buildSummaryRow("Subtotals for shipping", "\$0.00"),
        Divider(color: Colors.grey.withOpacity(0.5), height: 20.h),
        _buildSummaryRow("Total Payment", "\$${totalPrice.toStringAsFixed(0)}", isTotal: true),
      ],
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Row(
      children: [
        Text(label, style: isTotal ? AppFontsStyle.profileTitle : AppFontsStyle.editButton),
        const Spacer(),
        Text(value, style: isTotal ? AppFontsStyle.profileTitle.copyWith(color: Colors.red) : AppFontsStyle.editButton),
      ],
    ).marginSymmetric(vertical: 4.h);
  }

  Widget _buildBottomCheckoutSection(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.09),
            blurRadius: 10.0,
            spreadRadius: 0.3,
            offset: Offset(0, -5),
          )
        ],
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 28.w),
        child: Column(
          children: [
            Row(
              children: [
                Text("Total", style: AppFontsStyle.profileDetails),
                const Spacer(),
                Text("\$${totalPrice.toStringAsFixed(0)}", style: TextStyle(fontSize: 18.sp, color: Colors.red, fontWeight: FontWeight.w600)),
              ],
            ).marginOnly(bottom: 20.h),
            CustomButton(
              textColor: Colors.white,
              buttonColor: Colors.black,
              height: 62,
              onTap: () {
                // Handle buy action
              },
              text: "BUY NOW",
            ).marginOnly(bottom: 0.h),
          ],
        ),
      ),
    );
  }

  ScreenPaymentScreen({
    required this.totalPrice,
    required this.cartItem,
  });
}
