import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zrj/views/items/item_wish_list_product.dart';
import '../../../constants/colors.dart';
import '../../../constants/fonts.dart';
import '../../../utils/status_bar.dart';
import '../../screens/screen_test.dart';
import '../layout_my_profile/layout_purchase_receipt.dart';

class ScreenFavouriteProduct extends StatelessWidget {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  // Sample list of products for demonstration purposes
  final List<Product> wishListProducts = []; // Populate with your data

  Widget _cartFavItem(Product item, Animation<double> animation, int index) {
    return SizeTransition(
      sizeFactor: animation,
      child: ItemWishListProduct(
        product: item,
        index: index,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    AppStatusBar.light();

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        title: Text(
          "MY Favourites",
          style: AppFontsStyle.profileAppBar,
        ),
        centerTitle: true,
        leading: AppFontsStyle.buildBackButton(context),
      ),
      body: SafeArea(
        child: SizedBox(
          height: Get.height,
          child: Stack(
            children: [
              Positioned(
                top: 0.h,
                left: 132.w,
                right: 91.w,
                bottom: 0,
                child: AnimatedSvg(
                  svgAssetPath: "assets/icons/home_line.svg",
                  color: Colors.black.withOpacity(.2),
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: (wishListProducts.isEmpty) 
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/icons/no_result.png',
                          color: Colors.black,
                          width: 50,
                        ),
                        Text(
                          'No favorites found.',
                          style: TextStyle(
                            fontSize: 18, 
                            fontWeight: FontWeight.w500,
                          ),
                        ).marginSymmetric(vertical: 10.h),
                        Text(
                          "You haven't added any items to your wishlists yet! Browse our collection and discover something special to add today.",
                          textAlign: TextAlign.center,
                        ).marginSymmetric(horizontal: 50.w),
                      ],
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.only(top: 12.sp),
                    child: AnimatedList(
                      key: _listKey,
                      initialItemCount: wishListProducts.length,
                      itemBuilder: (context, index, animation) {
                        return _cartFavItem(
                          wishListProducts[index],
                          animation,
                          index,
                        );
                      },
                    ),
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
