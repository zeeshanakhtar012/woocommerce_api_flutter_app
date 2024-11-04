import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../constants/colors.dart';
import '../../../constants/fonts.dart';
import '../../../utils/status_bar.dart';
import '../../../widgets/calendar_format.dart';
import '../../../widgets/custom_listview_builder.dart';
import '../../../widgets/skeleton/custom_skeleton.dart/cart_skeleton.dart';

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

    // Here you would fetch your data
    // Simulate received data
    setState(() {
      // This would be replaced with your actual data fetching logic
      singleOrderList = [
        // Example data structure
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
              images: [ImagePath(imagePath: 'https://example.com/image.png')],
              pivot: ProductPivot(price: '20', quantity: 1, color: 'Red', size: 'M'),
            ),
            // Add more products as needed
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
        child: SingleChildScrollView(
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
            Text('${order.quantity} items',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: Color(0xffA7A7A7),
                )),
          ],
        ).marginOnly(top: 5.sp),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Total',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                )),
            Text('\$ ${order.totalPrice.split('.')[0]}',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.appPrimaryColor,
                )),
          ],
        ).marginOnly(top: 8.h),
      ],
    );
  }

  Widget buildOrderDetailRow(String title, String value) {
    return Row(
      children: [
        SvgPicture.asset("assets/icons/receipt.svg").marginOnly(right: 10.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  color: Colors.black26,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
              ).marginOnly(top: 4.h)
            ],
          ),
        )
      ],
    );
  }

  Widget buildProductDetail(Product product) {
    return Wrap(children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 69.h,
            width: 69.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
              color: Colors.white,
              boxShadow: [AppColors.myCustomBoxShadow],
            ),
            child: Center(
              child: product.images.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: product.images[0].imagePath,
                      placeholder: (context, url) => CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    )
                  : Icon(Icons.image_not_supported),
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${product.name}",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff4C6042),
                  ),
                ),
                Text(
                  "Color : ${product.pivot.color}",
                  style: TextStyle(
                      fontSize: 10.sp,
                      color: AppColors.appPrimaryColor,
                      fontWeight: FontWeight.w300),
                ).marginSymmetric(vertical: 3.h),
                Text(
                  "Size : ${product.pivot.size}",
                  style: TextStyle(
                      fontSize: 10.sp,
                      color: AppColors.appPrimaryColor,
                      fontWeight: FontWeight.w300),
                ),
                Text(
                  "\$ ${(double.parse(product.pivot.price)).toStringAsFixed(0)}",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff4C6042),
                  ),
                ).marginOnly(top: 3.h),
              ],
            ),
          ),
        ],
      ),
      Divider(
        color: AppColors.appGreyColor,
        height: 5.h,
        thickness: 0.2.h,
      ).marginOnly(bottom: 8.h, top: 4.h),
    ]);
  }
}

// Example models to simulate your data structure
class OrderItem {
  final String id;
  final Shipment shipment;
  final List<Product> products;
  final int quantity;
  final String totalPrice;

  OrderItem({required this.id, required this.shipment, required this.products, required this.quantity, required this.totalPrice});
}

class Shipment {
  final String stateOrProvince;
  final String city;
  final String streetAddress;
  final DateTime updatedAt;

  Shipment({required this.stateOrProvince, required this.city, required this.streetAddress, required this.updatedAt});
}

class Product {
  final String name;
  final List<ImagePath> images;
  final ProductPivot pivot;

  Product({required this.name, required this.images, required this.pivot});
}

class ProductPivot {
  final String price;
  final int quantity;
  final String color;
  final String size;

  ProductPivot({required this.price, required this.quantity, required this.color, required this.size});
}

class ImagePath {
  final String imagePath;

  ImagePath({required this.imagePath});
}
