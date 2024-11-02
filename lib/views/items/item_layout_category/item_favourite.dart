import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../widgets/custom_check_box.dart';
import '../../../constants/colors.dart';

class ItemCartFavourite extends StatefulWidget {
  final String dressName;
  final String dressColor;
  final String dressSize;
  final String dressPrice;
  final String imageUrl;
  int dressQuantity;
  bool? isWish;
  final String? dressTotalPrice;
  final VoidCallback? onDelete;

  ItemCartFavourite({
    required this.dressName,
    required this.dressColor,
    required this.dressSize,
    required this.dressPrice,
    this.dressTotalPrice,
    this.isWish = false,
    this.onDelete,
    required this.imageUrl,
    required this.dressQuantity,
  });

  @override
  State<ItemCartFavourite> createState() => _ItemCartFavouriteState();
}

class _ItemCartFavouriteState extends State<ItemCartFavourite> {
  bool isExpanded = false;


  void _increaseQuantity() {
    setState(() {
      widget.dressQuantity++;
    });
  }

  void _decreaseQuantity() {
    setState(() {
      if (widget.dressQuantity > 1 && widget.dressQuantity > 1) {
        widget.dressQuantity--;
      }
    });
  }

  String _calculateSubtotal() {
    double unitPrice = double.parse(widget.dressPrice);
    double subtotal = unitPrice * widget.dressQuantity;
    return subtotal.toStringAsFixed(2);
  }

  void _deleteIcon() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  void _deleteItem() {
    widget.onDelete?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    padding: EdgeInsets.all(8.w),
                    width: isExpanded ? 0.9.sw : 1.sw,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                      ),
                      border: Border.all(
                          color: Colors.black.withOpacity(.05)
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.09),
                          blurRadius: 10,
                          spreadRadius: 0,
                          // offset: Offset(5, 5),
                        )],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomCheckbox(
                          activeColor: Color(0xff4C6042),
                          initialValue: false,
                          onChanged: (bool value) {},
                        ).marginSymmetric(vertical: 60.h),
                        SizedBox(width: 8.w),
                        Container(
                          height: Get.height * .16,
                          width: 80.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              AppColors.boxShadow
                            ],
                          ),
                          child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(
                                height: MediaQuery.sizeOf(context).height,
                                widget.imageUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      widget.dressName,
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        color: Color(0xff4C6042),
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  SvgPicture.asset(
                                      "assets/icons/icon_heart_fill.svg"),
                                  IconButton(
                                    icon: Icon(Icons.delete, color: Colors.grey),
                                    onPressed: _deleteIcon,
                                  ),
                                ],
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                "Color: ${widget.dressColor}",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Color(0xff4C6042),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                "Size: ${widget.dressSize}",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Color(0xff4C6042),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                "\$${widget.dressPrice}",
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  color: Color(0xff4C6042),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Container(
                                height: 24.h,
                                width: 88.w,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Color(0xff4C6042),
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: _decreaseQuantity,
                                      child: Icon(Icons.remove, size: 18.sp),
                                    ),
                                    VerticalDivider(),
                                    Text(
                                      widget.dressQuantity.toString(),
                                      style: TextStyle(fontSize: 14.sp),
                                    ),
                                    VerticalDivider(),
                                    InkWell(
                                      onTap: _increaseQuantity,
                                      child: Icon(Icons.add, size: 18.sp),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(color: Colors.grey),
                              Row(
                                children: [
                                  Spacer(),
                                  Text(
                                    "Sub Total: ",
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Color(0xff4C6042),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    "\$${_calculateSubtotal()}",
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors.red,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ).marginOnly(left: 40.w),
                                ],
                              ),
                              if (widget.isWish!)
                                InkWell(
                                  child: Container(
                                    height: 40.h,
                                    width: 120.w,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(.15),
                                          blurRadius: 10,
                                          spreadRadius: 0,
                                          offset: Offset(5, 5),
                                        )],
                                      border: Border.all(color: Colors.black54),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Add to basket",
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ),
                                  ).marginSymmetric(vertical: 6.h),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (isExpanded)
                  Container(
                    width: 34.w,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    child: Center(
                      child: IconButton(
                        onPressed: _deleteItem,
                        icon: Icon(
                          CupertinoIcons.delete,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
