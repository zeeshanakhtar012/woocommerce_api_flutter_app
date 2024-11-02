import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../constants/colors.dart';
import '../../../constants/fonts.dart';
import '../../../utils/status_bar.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_field.dart';

class LayoutPayment extends StatefulWidget {
  LayoutPayment({super.key});

  @override
  State<LayoutPayment> createState() => _LayoutPaymentState();
}

class _LayoutPaymentState extends State<LayoutPayment> {
  final TextEditingController accountNameController = TextEditingController();
  final TextEditingController bankNameController = TextEditingController();
  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController expireDateController = TextEditingController();
  final TextEditingController securityCodeController = TextEditingController();

  bool isLoadingDelete = false;
  bool isLoadingAdd = false;
  bool isLoadingUpdate = false;

  @override
  void initState() {
    super.initState();
    fetchCardDetails();
  }

  Future<void> fetchCardDetails() async {
    setState(() {
      isLoadingAdd = true; // Start loading
    });
    // Fetch your card details here
    // Simulating fetching data
    await Future.delayed(Duration(seconds: 2));
    // After fetching, populate the controllers with fetched data if available
    // Example:
    // accountNameController.text = fetchedData.accountName;
    setState(() {
      isLoadingAdd = false; // Stop loading
    });
  }

  Future<void> deleteDebitCard() async {
    setState(() {
      isLoadingDelete = true; // Start loading
    });
    // Call your delete card API here
    await Future.delayed(Duration(seconds: 2)); // Simulating network call
    setState(() {
      isLoadingDelete = false; // Stop loading
    });
  }

  Future<void> addCard() async {
    setState(() {
      isLoadingAdd = true; // Start loading
    });
    // Add your card logic here
    await Future.delayed(Duration(seconds: 2)); // Simulating network call
    setState(() {
      isLoadingAdd = false; // Stop loading
    });
  }

  Future<void> updateCard() async {
    setState(() {
      isLoadingUpdate = true; // Start loading
    });
    // Update your card logic here
    await Future.delayed(Duration(seconds: 2)); // Simulating network call
    setState(() {
      isLoadingUpdate = false; // Stop loading
    });
  }

  @override
  Widget build(BuildContext context) {
    AppStatusBar.light();

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        actions: [
          isLoadingDelete
              ? Center(
                  child: CircularProgressIndicator(
                    color: Color(0xff4C6042),
                  ),
                )
              : InkWell(
                  onTap: deleteDebitCard,
                  child: CircleAvatar(
                    radius: 25.r,
                    backgroundColor: Color(0xff4C6042),
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ).marginSymmetric(
                    horizontal: 10.sp,
                    vertical: 10.sp,
                  ),
                ),
        ],
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: CircleAvatar(
            radius: 10.r,
            backgroundColor: Color(0xff4C6042),
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ).marginSymmetric(
            horizontal: 10.sp,
            vertical: 10.sp,
          ),
        ),
        title: Text(
          "Add Debit Card",
          style: AppFontsStyle.profileAppBar,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: isLoadingAdd
            ? Center(
                child: CircularProgressIndicator(
                  color: Color(0xff4C6042),
                ),
              )
            : Padding(
                padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 29.sp),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Add a debit card",
                        style: AppFontsStyle.profileTitle,
                      ),
                    ).marginOnly(top: 20.sp, bottom: 10.h),
                    CustomTextField(
                      controller: accountNameController,
                      hintText: 'Account name',
                    ),
                    CustomTextField(
                      controller: bankNameController,
                      hintText: 'Bank',
                      suffixIcon: CircleAvatar(
                        radius: 8.r,
                        backgroundColor: Color(0xff4C6042),
                        child: InkWell(
                          onTap: () {
                            // _showPopupMenu(context);
                          },
                          child: Icon(
                            Icons.keyboard_arrow_down_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ).marginSymmetric(
                        horizontal: 10.sp,
                        vertical: 10.sp,
                      ),
                    ),
                    CustomTextField(
                      controller: accountNumberController,
                      hintText: 'Account number',
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: CustomTextField(
                            suffixIcon: IconButton(
                              onPressed: () async {
                                final DateTime? picked = await showDatePicker(
                                  builder: (context, child) {
                                    return Theme(
                                      data: Theme.of(context).copyWith(
                                        colorScheme: ColorScheme.light(
                                          primary: Color(0xff4C6042),
                                          onPrimary: Colors.black,
                                          onSurface: Colors.black,
                                        ),
                                        textButtonTheme: TextButtonThemeData(
                                          style: TextButton.styleFrom(
                                            foregroundColor: Colors.black,
                                          ),
                                        ),
                                      ),
                                      child: child!,
                                    );
                                  },
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime(2101),
                                );
                                if (picked != null && picked != DateTime.now()) {
                                  expireDateController.text = "${picked.toLocal()}".split(' ')[0];
                                  setState(() {}); // Refresh the UI
                                }
                              },
                              icon: Icon(
                                CupertinoIcons.calendar,
                                color: Color(0xff4C6042),
                              ),
                            ),
                            controller: expireDateController,
                            hintText: 'Expiry Date',
                            readOnly: true,
                          ).marginSymmetric(horizontal: 5.sp),
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          flex: 1,
                          child: CustomTextField(
                            obscureText: true,
                            controller: securityCodeController,
                            hintText: 'Security code',
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    CustomButton(
                      loading: isLoadingAdd,
                      onTap: addCard,
                      text: "ADD DEBIT CARD",
                      textColor: Colors.white,
                      buttonColor: AppColors.appGreyColor,
                    ),
                    CustomButton(
                      loading: isLoadingUpdate,
                      onTap: updateCard,
                      text: "UPDATE DEBIT CARD",
                      textColor: Colors.white,
                      buttonColor: Colors.black,
                    ).marginSymmetric(vertical: 10.h),
                  ],
                ),
              ),
      ),
    );
  }
}
