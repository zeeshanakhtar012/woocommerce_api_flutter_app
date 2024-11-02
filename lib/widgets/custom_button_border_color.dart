import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButtonBorder extends StatefulWidget {
  String text;
  double? fontSize;
  VoidCallback? onTap;
  bool? isRound;
  double? width;
  double? height;
  EdgeInsetsGeometry? margin;
  Color? textColor;
  Color? buttonColor;
  bool? loading;
  bool? isBorder;

  @override
  _CustomButtonBorderState createState() => _CustomButtonBorderState();

  CustomButtonBorder({
    required this.text,
    this.fontSize,
    this.onTap,
    this.isRound,
    this.width,
    this.height,
    this.margin,
    this.textColor,
    this.buttonColor,
    this.loading = false,
    this.isBorder = false,
  });
}

class _CustomButtonBorderState extends State<CustomButtonBorder> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.onTap != null) {
          widget.onTap!();
        }
      },
      child: Container(
        alignment: Alignment.center,
        height: widget.height ?? 62.sp,
        width: widget.width ?? MediaQuery.of(context).size.width,
        margin: widget.margin,
        decoration: BoxDecoration(
            color: widget.buttonColor,
            borderRadius: widget.isRound == true
                ? BorderRadius.circular(50)
                : BorderRadius.circular(15),
            border: Border.all(
              color: widget.isBorder! ? Colors.black: Colors.transparent,
            )// Check if buttonGradient is null and use black if it is
        ),
        child: widget.loading!
            ? CircularProgressIndicator(
          color: Colors.brown,
        )
            : Text(
          widget.text,
          style: TextStyle(
            fontSize: widget.fontSize ?? 16,
            decoration: TextDecoration.none,
            fontWeight: FontWeight.w700,
            color: widget.textColor ?? Colors.white,
          ),
        ),
      ),
    );
  }
}
