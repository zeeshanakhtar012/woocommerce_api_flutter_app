import 'package:flutter/cupertino.dart';

import '../skeleton.dart';

class ImageSkeleton extends StatelessWidget {
  final double height;
  final double? width;

  const ImageSkeleton({Key? key, this.height = 100, this.width})
      : super(key: key);

  static const double defaultPadding = 16.0;
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 100,
      child: Column(
        children: [
          Skeleton(
              height: height,
              width: width != null ? width : MediaQuery.sizeOf(context).width),
        ],
      ),
    );
  }
}
