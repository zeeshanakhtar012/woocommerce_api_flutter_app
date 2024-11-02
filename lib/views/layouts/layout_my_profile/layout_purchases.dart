import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../constants/colors.dart';
import '../../../constants/fonts.dart';
import '../../../utils/status_bar.dart';
import '../../../widgets/calendar_format.dart';
import '../../../widgets/custom_listview_builder.dart';
import '../../../widgets/skeleton/custom_skeleton.dart/cart_skeleton.dart';
import '../../items/item_profile_purchases.dart';
import 'layout_purchase_receipt.dart';

class LayoutPurchases extends StatefulWidget {
  const LayoutPurchases({super.key});

  @override
  _LayoutPurchasesState createState() => _LayoutPurchasesState();
}

class _LayoutPurchasesState extends State<LayoutPurchases> {
  bool isLoading = true;
  List<Order> orderList = [];

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    // Simulate a network call
    await Future.delayed(Duration(seconds: 2));

    // Here you would fetch your actual order data
    setState(() {
      // Simulated data for orders
      orderList = [
        Order(
          id: '1',
          updatedAt: DateTime.now(),
          paymentMethod: 'credit_card',
          totalPrice: '76.00',
        ),
        // Add more orders as needed
      ];
      isLoading = false; // Stop loading
    });
  }

  @override
  Widget build(BuildContext context) {
    AppStatusBar.light();

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
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
          "MY PURCHASES",
          style: AppFontsStyle.profileAppBar,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Online Purchases",
                  style: AppFontsStyle.profileTitle,
                ),
              ).marginOnly(left: 29.w, bottom: 10.h, top: 20.h),
              if (isLoading)
                CustomListviewBuilder(
                  scrollDirection: CustomDirection.vertical,
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return CartSkeleton(height: 100);
                  },
                )
              else if (orderList.isEmpty)
                Center(
                  heightFactor: 4.h,
                  child: Text(
                    "No Orders Found",
                    style: TextStyle(fontSize: 16.sp),
                  ),
                )
              else
                CustomListviewBuilder(
                  itemCount: orderList.length,
                  scrollDirection: CustomDirection.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    var order = orderList[index];
                    var updatedAt = calendarFormat(order.updatedAt.toString());
                    var typePayment = order.paymentMethod == "credit_card"
                        ? "Purchase Online"
                        : "Purchase On Delivery";

                    return ItemProfilePurchases(
                      onTap: () {
                        // Navigate to purchase receipt layout
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LayoutPurchaseReceipt(
                              purchaseNoReceipt: "No. ${order.id}",
                              purchaseDateReceipt: '${updatedAt}',
                              purchasePriceReceipt: '\$ ${order.totalPrice}',
                            ),
                          ),
                        );
                      },
                      purchaseNo: "No. ${order.id}",
                      purchaseDate: '${updatedAt}',
                      purchaseType: '${typePayment}',
                      purchasePrice: '\$ ${order.totalPrice}',
                      purchaseButtonText: '',
                    ).marginOnly(top: 20.sp);
                  },
                ),
            ],
          ).marginSymmetric(vertical: 10.sp),
        ),
      ),
    );
  }
}

// Example model to simulate your order structure
class Order {
  final String id;
  final DateTime updatedAt;
  final String paymentMethod;
  final String totalPrice;

  Order({
    required this.id,
    required this.updatedAt,
    required this.paymentMethod,
    required this.totalPrice,
  });
}
