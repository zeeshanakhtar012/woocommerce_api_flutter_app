import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class TRatingBarIndicator extends StatelessWidget {
  const TRatingBarIndicator({
    Key? key, required this.rating,
  }) : super(key: key);
final double rating;
  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      rating: rating,
      itemSize: 20,
      unratedColor: Colors.grey,
      itemBuilder:(_,__)=>Icon(CupertinoIcons.star,color: Colors.red,),
    );
  }
}