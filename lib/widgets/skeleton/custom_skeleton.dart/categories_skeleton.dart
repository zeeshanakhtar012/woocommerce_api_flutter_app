import 'package:flutter/cupertino.dart';

import '../skeleton.dart';

class CategoriesSkeleton extends StatelessWidget {
  const CategoriesSkeleton({
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
          const Skeleton(height: 70, width: 90),
          const SizedBox(height: defaultPadding/4),
          const Skeleton(width: 70, borderRadius: 12, height: 8,),
          const SizedBox(height: defaultPadding / 4),
          const Skeleton(width: 70, borderRadius: 12, height: 8,),
       
        ],
      ),
    );
  }
}
