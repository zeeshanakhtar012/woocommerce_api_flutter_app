import 'package:flutter/cupertino.dart';

import '../skeleton.dart';

class PopularSkeleton extends StatelessWidget {
  const PopularSkeleton({
    Key? key,
  }) : super(key: key);

  static const double defaultPadding = 16.0;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      width: double.infinity,
      margin: EdgeInsets.only(left:16, bottom: 16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Skeleton(height: 150, width: 130),
          Container(
            height: 120,
              child: 
              Skeleton(height: 120, width: 160)
              
              ),
        ],
      ),
    );
  }
}
