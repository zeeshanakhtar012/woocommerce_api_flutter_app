
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:zrj/constants/colors.dart';
import 'package:zrj/widgets/rating_indicator.dart';

import '../home/home_layouts/layout_cart.dart';

class ScreenProductDetails extends StatefulWidget {
  final String productName;
  final String productImage;
  final String productPrice; // Ensure this is a clean numeric string
  final List<String> sizes;
  final List<String> colors;

  ScreenProductDetails({
    required this.productName,
    required this.productPrice,
    required this.productImage,
    required this.sizes,
    required this.colors,
  });

  @override
  _ScreenProductDetailsState createState() => _ScreenProductDetailsState();
}

class _ScreenProductDetailsState extends State<ScreenProductDetails> {
  Color _selectedColor = Colors.red;
  String _selectedSize = 'S';
  int _quantity = 1;

  String getTotalPrice() {
    double unitPrice;
    try {
      // Clean the price string before parsing
      unitPrice =
          double.parse(widget.productPrice.replaceAll(RegExp(r'[^\d.]'), ''));
    } catch (e) {
      // Handle parsing error
      unitPrice = 0.0; // Default to 0 if parsing fails
    }
    return (unitPrice * _quantity).toStringAsFixed(2);
  }

  void _increaseQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decreaseQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Get.back(),
          child: CircleAvatar(
            radius: 10.r,
            backgroundColor: AppColors.appRedColor,
            child: Icon(Icons.arrow_back, color: Colors.white),
          ).marginSymmetric(horizontal: 10.sp, vertical: 10.sp),
        ),
        actions: [
          InkWell(
            onTap: ()=>Get.to(() => LayoutCart(isHome: true,)),
            child: CircleAvatar(
              radius: 25.r,
              backgroundColor: AppColors.buttonColor,
              child: SvgPicture.asset("assets/icons/icon_store.svg"),
            ).marginSymmetric(horizontal: 10.sp),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: 8.sp,
                ),
                height: 300,
                width: double.infinity,
                color: Colors.white,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image.network(widget.productImage)),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      topLeft: Radius.circular(15)),
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xFF6B6B6B).withOpacity(.25),
                        blurRadius: 5)
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(widget.productName,
                            style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.black)),
                        Text('\$${getTotalPrice()}',
                            style: TextStyle(
                                fontSize: 30.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.black)),
                      ],
                    ),
                    TRatingBarIndicator(rating: 3.6),
                    SizedBox(
                        height: 40.sp,
                        child: Row(
                          children: [
                            Text('Size:',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600)),
                            Spacer(),
                            for (String size in widget.sizes)
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedSize = size;
                                  });
                                },
                                child: Container(
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 4.sp),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12.sp, vertical: 8.sp),
                                  decoration: BoxDecoration(
                                    color: _selectedSize == size
                                        ? Colors.black
                                        : Color(0xFFF6F6F7),
                                    borderRadius: BorderRadius.circular(5.sp),
                                  ),
                                  child: Text(size,
                                      style: TextStyle(
                                          color: _selectedSize == size
                                              ? Colors.white
                                              : Colors.grey)),
                                ),
                              ),
                          ],
                        )),
                    SizedBox(
                        height: 40.sp,
                        child: Row(
                          children: [
                            Text('Choose Color',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600)),
                            Spacer(),
                            for (String color in widget.colors)
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedColor = _getColorFromName(color);
                                  });
                                },
                                child: Container(
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 4.sp),
                                  width: 30.w,
                                  height: 30.h,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: _getColorFromName(color),
                                    border: Border.all(
                                        color: _selectedColor ==
                                                _getColorFromName(color)
                                            ? Colors.black
                                            : Colors.transparent),
                                  ),
                                ),
                              ),
                          ],
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Quantity:',
                            style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w600)),
                        Row(
                          children: [
                            IconButton(
                              onPressed: _decreaseQuantity,
                              icon: Icon(Icons.remove, size: 21.74.sp),
                            ),
                            Container(
                              width: 60.w,
                              height: 30.h,
                              decoration: BoxDecoration(
                                  color: Color(0xFFF6F6F7),
                                  borderRadius: BorderRadius.circular(4)),
                              child: Center(
                                  child: Text(_quantity.toString(),
                                      style: TextStyle(fontSize: 18.sp))),
                            ),
                            IconButton(
                              onPressed: _increaseQuantity,
                              icon: Icon(Icons.add, size: 21.74.sp),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10.sp),
                    Text("Description",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp)),
                    Text("Product description goes here.The user interface of the app is quite intvitive. I was able to navigate and make purchases seamlessly. Great job!",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                            fontSize: 12.sp)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.all(8),
        child: ElevatedButton(
          onPressed: () {
            // Add to cart action
          },
          child: Text('Add to Cart'),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.buttonColor,
            padding: EdgeInsets.symmetric(vertical: 15),
          ),
        ),
      ),
    );
  }

  Color _getColorFromName(String colorName) {
    switch (colorName.toLowerCase()) {
      case 'red':
        return Colors.red;
      case 'green':
        return Colors.green;
      case 'blue':
        return Colors.blue;
      case 'yellow':
        return Colors.yellow;
      case 'black':
        return Colors.black;
      default:
        return Colors.grey;
    }
  }
}