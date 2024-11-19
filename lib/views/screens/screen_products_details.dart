
import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';
import '../../constants/fonts.dart';
import '../../controllers/controller_authentication.dart';
import '../../controllers/controller_cart.dart';
import '../../controllers/controller_payment.dart';
import '../../controllers/controller_product.dart';
import '../../model/model_images.dart';
import '../../model/product.dart';
import '../../model/user.dart';
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
  Product? product;
  UserModel? user;

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
  PaymentsController paymentsController = Get.put(PaymentsController());
  ControllerAuthentication authentication = Get.put(ControllerAuthentication());
  CartController cartController = Get.put(CartController());
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

  @override
  void initState() {
    super.initState();
    // _fetchUsrDetails();
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

  void fetchUsrDetails() async {
    final String userId = authentication.getUserId().toString();
    try {
      if (userId != null && userId != null) {
        authentication.fetchUserDetailsById();
        log("${widget.user!.id}");
      } else {
        authentication.fetchUserDetailsById();
        log("${widget.user!.id}");
      }
    }catch(t){
      log("$t");
    }
    }

  @override
  Widget build(BuildContext context) {
    log('Product Name: ${widget.productName}');
    log('Product ID: ${widget.productId}');
    log('Product Price: ${widget.productPrice}');
    log('Product Images: ${widget.productImages}');
    log('Product Description: ${widget.productDescription}');
    fetchUsrDetails();
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
        // actions: [
        //   IconButton(
        //     onPressed: () => Get.to(() => LayoutCart(isHome: true)),
        //     icon: CircleAvatar(
        //       radius: 25.r,
        //       backgroundColor: AppColors.buttonColor,
        //       child: SvgPicture.asset("assets/icons/icon_store.svg"),
        //     ),
        //   ),
        // ],
        centerTitle: true,
        title: Text("${widget.productName}", style: AppFontsStyle.profileAppBar),
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
              final String? userId = await authentication.getUserId();
              Product product = Product(
                id: widget.productId!,
                name: widget.productName ?? "N/A",
                price: "${widget.productPrice}" ,
                description: widget.productDescription ?? "N/A",
                size: (widget.sizes != null && widget.sizes!.isNotEmpty) ? widget.sizes![0] : "N/A",
                images: widget.productImages != null
                    ? widget.productImages!.map((url) => ProductImage(src: url)).toList()
                    : [],
                color: (widget.colors != null && widget.colors!.isNotEmpty) ? widget.colors![0] : "N/A",
                slug: widget.product?.slug ?? "default-slug",
                permalink: widget.product?.permalink ?? "default-permalink",
              );
              log("Product details $product");
              Billing billing = Billing(
                phone: widget.user?.billing?.phone ?? "N/A",
                address2: widget.user?.billing?.address2 ?? "N/A",
                address1: widget.user?.billing?.address1 ?? "N/A",
                city: widget.user?.shipping?.city ?? "N/A",
                state: widget.user?.shipping?.state ?? "N/A",
                country: widget.user?.shipping?.country ?? "N/A",
              );

              Shipping shipping = Shipping(
                address1: widget.user?.shipping?.address1 ?? "N/A",
                city: widget.user?.shipping?.city ?? "N/A",
                state: widget.user?.shipping?.state ?? "N/A",
                country: widget.user?.shipping?.country ?? "N/A",
              );
              UserModel user = UserModel(
                id: userId,
                firstName: widget.user?.firstName ?? "John",
                lastName: widget.user?.lastName ?? "Doe",
                email: widget.user?.email ?? "example@example.com",
                avatarUrl: widget.user?.avatarUrl ?? "https://via.placeholder.com/150",
                billing: billing,
                shipping: shipping,
                isPayingCustomer: true,
              );
              log("User data : $user");
              log("User Id : ${user.id}");
              // Call the payment controller
              paymentsController.makePayment(
                getTotalPrice(),
                product,
                user,
                onSuccess: (infoData) {
                  print("Payment successful: $infoData");
                  Get.snackbar('Success', 'Your order has been placed.');
                },
                onError: (error) {
                  print("Payment failed: $error");
                  Get.snackbar('Error', 'Payment failed. Please try again.');
                },
              );
            } else {
              print('Product ID is null');
            }
          },
//           onPressed: () async {
//             // Check for productId and the necessary fields
//             if (widget.productId == null || widget.productPrice.isEmpty || widget.productName.isEmpty) {
//               log("Product details are missing.");
//               Get.snackbar(
//                 snackPosition: SnackPosition.BOTTOM,
//                 backgroundColor: Colors.red,
//                 colorText: Colors.white,
//                 duration: Duration(seconds: 2),
//                 'Error', 'Product details are missing.',
//               );
//               return;
//             }
//
//             // Create a list of ProductImage objects from widget.productImages (which is likely a list of image URLs)
//             List<ProductImage> productImages = widget.productImages.isNotEmpty
//                 ? widget.productImages.map((url) => ProductImage(src: url)).toList()  // Convert strings to ProductImage objects
//                 : [];  // Empty list if no images
//
// // Create product with the images
//             final product = Product(
//               id: widget.productId ?? 0,
//               name: widget.productName ?? 'Unknown Product',
//               price: widget.productPrice ?? '0.0',
//               quantity: _quantity,
//               color: _selectedColor.toString(),
//               size: _selectedSize,
//               images: productImages,
//             );
//             // Add product to the cart
//             cartController.addProductToCart(product);
//
//             // Show success message
//             Get.snackbar(
//               'Success',
//               '${product.name} has been added to the cart!',
//               snackPosition: SnackPosition.BOTTOM,
//               backgroundColor: Colors.green,
//               colorText: Colors.white,
//               duration: Duration(seconds: 2),
//             );
//             log("Product added to cart successfully.");
//           },
          child: Text('Order Now', style: TextStyle(color: Colors.white, fontSize: 16.sp)),
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
