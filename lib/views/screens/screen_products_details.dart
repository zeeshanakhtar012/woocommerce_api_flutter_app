import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../constants/colors.dart';
import '../../controllers/controller_product.dart';
import '../../widgets/rating_indicator.dart';
import '../home/home_layouts/layout_cart.dart';

class ScreenProductDetails extends StatefulWidget {
  final String productName;
  final int? productId;
  final List<String> productImages;
  final String productPrice;
  final String? rating;
  final String? productDescription;
  final List<String> sizes;
  final List<String> colors;

  ScreenProductDetails({
    required this.productName,
    required this.productPrice,
    required this.productImages,
    this.productId,
    this.productDescription,
    this.rating,
    required this.sizes,
    required this.colors,
  });

  @override
  _ScreenProductDetailsState createState() => _ScreenProductDetailsState();
}

class _ScreenProductDetailsState extends State<ScreenProductDetails> {
  final ProductWooCommerceController controller = Get.put(ProductWooCommerceController());

  Color _selectedColor = Colors.red;
  String _selectedSize = 'S';
  int _quantity = 1;

  String getTotalPrice() {
    try {
      double unitPrice = double.parse(widget.productPrice.replaceAll(RegExp(r'[^\d.]'), ''));
      return (unitPrice * _quantity).toStringAsFixed(2);
    } catch (e) {
      return '0.00';
    }
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
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: CircleAvatar(
            radius: 25.r,
            backgroundColor: AppColors.appRedColor,
            child: Icon(Icons.arrow_back, color: Colors.white),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => Get.to(() => LayoutCart(isHome: true)),
            icon: CircleAvatar(
              radius: 25.r,
              backgroundColor: AppColors.buttonColor,
              child: SvgPicture.asset("assets/icons/icon_store.svg"),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: 300.0,
                  autoPlay: true,
                  enlargeCenterPage: true,
                ),
                items: widget.productImages.map((imageUrl) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.white,
                    ),
                    child: Image.network(imageUrl, fit: BoxFit.cover),
                  );
                }).toList(),
              ),
              _buildProductDetailsSection(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () async {
            if (widget.productId != null) {
              // await controller.addProductToCartLocal;
            } else {
              print('Product ID is null');
            }
          },
          child: controller.isLoading.value? CircularProgressIndicator() : Text('Add to Cart'),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.buttonColor,
            padding: EdgeInsets.symmetric(vertical: 15),
          ),
        ),
      ),

    );
  }

  Widget _buildProductDetailsSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topRight: Radius.circular(15), topLeft: Radius.circular(15)),
        boxShadow: [BoxShadow(color: Color(0xFF6B6B6B).withOpacity(.25), blurRadius: 5)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          _buildPriceAndNameRow(),
          SizedBox(height: 40.sp),
          _buildSizeSelectionRow(),
          SizedBox(height: 40.sp),
          _buildColorSelectionRow(),
          _buildQuantitySelector(),
          SizedBox(height: 10.sp),
          Text("Description", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 14.sp)),
          Text(
            widget.productDescription ?? '',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300, fontSize: 12.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceAndNameRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(widget.productName, style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w400, color: Colors.black)),
        Text('\$${getTotalPrice()}', style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.w600, color: Colors.black)),
      ],
    );
  }

  Widget _buildSizeSelectionRow() {
    return Row(
      children: [
        Text('Size:', style: TextStyle(color: Colors.black, fontSize: 14.sp, fontWeight: FontWeight.w600)),
        Spacer(),
        for (String size in widget.sizes)
          GestureDetector(
            onTap: () => setState(() {
              _selectedSize = size;
            }),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 4.sp),
              padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 8.sp),
              decoration: BoxDecoration(
                color: _selectedSize == size ? Colors.black : Color(0xFFF6F6F7),
                borderRadius: BorderRadius.circular(5.sp),
              ),
              child: Text(size, style: TextStyle(color: _selectedSize == size ? Colors.white : Colors.grey)),
            ),
          ),
      ],
    );
  }

  Widget _buildColorSelectionRow() {
    return Row(
      children: [
        Text('Choose Color', style: TextStyle(color: Colors.black, fontSize: 14.sp, fontWeight: FontWeight.w600)),
        Spacer(),
        for (String color in widget.colors)
          GestureDetector(
            onTap: () => setState(() {
              _selectedColor = _getColorFromName(color);
            }),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 4.sp),
              width: 30.w,
              height: 30.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _getColorFromName(color),
                border: Border.all(color: _selectedColor == _getColorFromName(color) ? Colors.black : Colors.transparent),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildQuantitySelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Quantity:', style: TextStyle(fontSize: 14.sp, color: Colors.black, fontWeight: FontWeight.w600)),
        Row(
          children: [
            IconButton(onPressed: _decreaseQuantity, icon: Icon(Icons.remove, size: 21.74.sp)),
            Container(
              width: 60.w,
              height: 30.h,
              decoration: BoxDecoration(color: Color(0xFFF6F6F7), borderRadius: BorderRadius.circular(4)),
              child: Center(child: Text(_quantity.toString(), style: TextStyle(fontSize: 18.sp))),
            ),
            IconButton(onPressed: _increaseQuantity, icon: Icon(Icons.add, size: 21.74.sp)),
          ],
        ),
      ],
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
