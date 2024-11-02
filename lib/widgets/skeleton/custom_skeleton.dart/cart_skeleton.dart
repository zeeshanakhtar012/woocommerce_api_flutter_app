import 'package:flutter/cupertino.dart';

import '../skeleton.dart';

class CartSkeleton extends StatelessWidget {
  final double height;
  const CartSkeleton({Key? key, this.height = 200}) : super(key: key);

  static const double defaultPadding = 16.0;
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 100,
      margin: EdgeInsets.only(right: 16, left: 16),
      child: Column(
        children: [
          Skeleton(height: height, width: MediaQuery.sizeOf(context).width - 40),
          const SizedBox(height: defaultPadding),
        ],
      ),
    );
  }
}
