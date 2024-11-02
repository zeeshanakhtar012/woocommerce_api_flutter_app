import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatefulWidget {
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
  _CustomButtonState createState() => _CustomButtonState();

  CustomButton({
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

class _CustomButtonState extends State<CustomButton> {
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
        height: widget.height ?? 62.h,
        width: widget.width ?? MediaQuery.of(context).size.width,
        margin: widget.margin,
        decoration: BoxDecoration(
          color: widget.buttonColor,
            borderRadius: widget.isRound == true
                ? BorderRadius.circular(50)
                : BorderRadius.circular(50),
            border: Border.all(
              color: widget.isBorder! ? Color(0xFFA7713F): Colors.transparent,
            )// Check if buttonGradient is null and use black if it is
        ),
        child: widget.loading!
            ? CircularProgressIndicator(
          color: Color(0xff4C6042),
        )
            : Text(
          widget.text,
          style: TextStyle(
            fontSize: widget.fontSize ?? 14.sp,
            decoration: TextDecoration.none,
            fontWeight: FontWeight.w700,
            fontFamily: "AvenirBlack",
            color: widget.textColor ?? Colors.white,
          ),
        ),
      ),
    );
  }
}
