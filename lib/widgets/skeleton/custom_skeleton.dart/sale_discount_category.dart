import 'package:flutter/cupertino.dart';

import '../skeleton.dart';

class SaleDiscountSkeleton extends StatelessWidget {
  const SaleDiscountSkeleton({
    Key? key,
  }) : super(key: key);

  static const double defaultPadding = 16.0;
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 100,
      margin: EdgeInsets.only(right: 16),
      child: Column(
        children: [
        
          const Skeleton(height: 110, width: 100),
          const SizedBox(height: defaultPadding/4),
          const Skeleton(width: 70, borderRadius: 12, height: 8,),
          const SizedBox(height: defaultPadding / 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Skeleton(width: 30, borderRadius: 12, height: 8,),
              const Skeleton(width: 30, borderRadius: 12, height: 8,),
           
              const Skeleton(width: 20, borderRadius: 8, height: 20,),

            ],
          ),

        ],
      ),
    );
  }
}
