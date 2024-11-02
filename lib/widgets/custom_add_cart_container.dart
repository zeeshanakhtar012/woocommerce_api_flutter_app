import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CustomContainer extends StatelessWidget {
  final String productId; // Only using the product ID
  final bool isInWishlist; // Indicates if the product is in the wishlist
  final Function(String) onToggleWishlist; // Callback to handle wishlist toggle

  const CustomContainer({
    Key? key,
    required this.productId,
    required this.isInWishlist,
    required this.onToggleWishlist,
  }) : super(key: key);

  static const String _favIconFilled = 'assets/icons/fav_icon_fill.svg';
  static const String _favIconOutline = 'assets/icons/icon_heart.svg';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onToggleWishlist(productId); // Trigger the callback
      },
      child: SvgPicture.asset(
        isInWishlist ? _favIconFilled : _favIconOutline,
      ).paddingAll(5),
    );
  }
}
