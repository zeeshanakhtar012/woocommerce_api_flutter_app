import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../constants/colors.dart';
import '../../../constants/fonts.dart';
import '../../../utils/status_bar.dart';
import '../../../widgets/calendar_format.dart';
import '../../../widgets/custom_listview_builder.dart';
import '../../../widgets/skeleton/custom_skeleton.dart/cart_skeleton.dart';
class OrderItem {
  final String id;
  final Shipment shipment;
  final List<Product> products;
  final int quantity;
  final String totalPrice;

  OrderItem({
    required this.id,
    required this.shipment,
    required this.products,
    required this.quantity,
    required this.totalPrice,
  });
}

class Shipment {
  final String stateOrProvince;
  final String city;
  final String streetAddress;
  final DateTime updatedAt;

  Shipment({
    required this.stateOrProvince,
    required this.city,
    required this.streetAddress,
    required this.updatedAt,
  });
}

// Product model definition
class Product {
  final String name;
  final List<Images> images;
  final ProductPivot pivot;

  Product({
    required this.name,
    required this.images,
    required this.pivot,
  });
}

// Images model definition for product images
class Images {
  final String imagePath;

  Images({
    required this.imagePath,
  });
}

// ProductPivot model for order details
class ProductPivot {
  final String price;
  final int quantity;
  final String color;
  final String size;

  ProductPivot({
    required this.price,
    required this.quantity,
    required this.color,
    required this.size,
  });
}

class LayoutPurchaseReceipt extends StatefulWidget {
  final String purchaseNoReceipt;
  final String purchaseDateReceipt;
  final String purchasePriceReceipt;

  LayoutPurchaseReceipt({
    this.purchaseNoReceipt = ' ',
    this.purchaseDateReceipt = ' ',
    this.purchasePriceReceipt = ' ',
    Key? key,
  }) : super(key: key);

  @override
  _LayoutPurchaseReceiptState createState() => _LayoutPurchaseReceiptState();
}

class _LayoutPurchaseReceiptState extends State<LayoutPurchaseReceipt> {
  bool isLoadingSingle = true;
  List<OrderItem> singleOrderList = [];

  @override
  void initState() {
    super.initState();
    fetchOrderDetails(); // Fetch order details when the widget is initialized
  }

  Future<void> fetchOrderDetails() async {
    // Simulate a network call
    await Future.delayed(Duration(seconds: 2));

    // Simulated received data
    setState(() {
      singleOrderList = [
        OrderItem(
          id: '12345',
          shipment: Shipment(
            stateOrProvince: 'State',
            city: 'City',
            streetAddress: '123 Street',
            updatedAt: DateTime.now(),
          ),
          products: [
            Product(
              name: 'Product 1',
              images: [Images(imagePath: 'https://example.com/image.png')],
              pivot: ProductPivot(price: '20', quantity: 1, color: 'Red', size: 'M'),
            ),
          ],
          quantity: 1,
          totalPrice: '20.00',
        ),
      ];
      isLoadingSingle = false; // Stop loading
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
          "RECEIPT DETAILS",
          style: AppFontsStyle.profileAppBar,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 20.h),
              padding: EdgeInsets.symmetric(horizontal: 29.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.r),
                boxShadow: [AppColors.myCustomBoxShadow],
              ),
              child: isLoadingSingle
                  ? CustomListviewBuilder(
                scrollDirection: CustomDirection.vertical,
                itemCount: 6,
                itemBuilder: (context, index) {
                  return CartSkeleton(height: 200);
                },
              )
                  : singleOrderList.isNotEmpty
                  ? buildReceiptDetails(singleOrderList[0])
                  : Text("No order found."),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildReceiptDetails(OrderItem order) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Receipt No. ${order.id}",
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: Color(0xff4C6042),
          ),
        ),
        Text(
          "${widget.purchaseDateReceipt}",
          style: TextStyle(
            fontSize: 12.sp,
            color: AppColors.appPrimaryColor,
            fontWeight: FontWeight.w300,
          ),
        ).marginSymmetric(vertical: 4.h),
        if (order.shipment != null)
          Text(
            "${order.shipment.stateOrProvince}, ${order.shipment.city}, ${order.shipment.streetAddress}",
            style: TextStyle(
              fontSize: 12.sp,
              color: AppColors.appPrimaryColor,
              fontWeight: FontWeight.w300,
            ),
          ),
        Divider(
          color: AppColors.appGreyColor,
          height: 5.h,
          thickness: 0.2.h,
        ).marginOnly(bottom: 8.h, top: 4.h),
        buildOrderDetailRow("Receipt No.", order.id),
        buildOrderDetailRow("PROCESSED ON", calendarFormat(order.shipment.updatedAt.toString())),
        Divider(
          color: AppColors.appGreyColor,
          height: 5.h,
          thickness: 0.2.h,
        ).marginOnly(bottom: 8.h, top: 4.h),
        for (var product in order.products) buildProductDetail(product),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Total", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
            Text(order.totalPrice, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
          ],
        ).paddingSymmetric(vertical: 8.h),
      ],
    );
  }

  Widget buildOrderDetailRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500)),
        Text(value, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400)),
      ],
    ).paddingSymmetric(vertical: 4.h);
  }

  Widget buildProductDetail(Product product) {
    return Row(
      children: [
        CachedNetworkImage(
          imageUrl: product.images.isNotEmpty ? product.images[0].imagePath : '',
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error),
          width: 60.w,
          height: 60.h,
          fit: BoxFit.cover,
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(product.name, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500)),
              Text("Color: ${product.pivot.color} | Size: ${product.pivot.size}", style: TextStyle(fontSize: 12.sp)),
              Text("Qty: ${product.pivot.quantity}", style: TextStyle(fontSize: 12.sp)),
            ],
          ),
        ),
        Text(product.pivot.price, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500)),
      ],
    ).paddingSymmetric(vertical: 8.h);
  }
}
