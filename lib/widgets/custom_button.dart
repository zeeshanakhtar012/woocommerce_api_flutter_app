import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final double? fontSize;
  final VoidCallback? onTap;
  final bool isRound; // Changed to required
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final Color? textColor;
  final Color? buttonColor;
  final bool loading;
  final bool isBorder;
  final BorderRadiusGeometry? borderRadius; // Added borderRadius property

  const CustomButton({
    required this.text,
    this.fontSize,
    this.onTap,
    this.isRound = false,
    this.width,
    this.height,
    this.margin,
    this.textColor,
    this.buttonColor,
    this.loading = false,
    this.isBorder = false,
    this.borderRadius, // Added borderRadius parameter
  });

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.onTap != null && !widget.loading) {
          widget.onTap!();
        }
      },
      child: Container(
        alignment: Alignment.center,
        height: widget.height ?? 62.h,
        width: widget.width ?? MediaQuery.of(context).size.width,
        margin: widget.margin,
        decoration: BoxDecoration(
          color: widget.buttonColor ?? Colors.blue, // Default button color
          borderRadius: widget.borderRadius ?? // Use custom border radius or default
              (widget.isRound
                  ? BorderRadius.circular(50)
                  : BorderRadius.circular(8)),
          border: Border.all(
            color: widget.isBorder ? Color(0xFFA7713F) : Colors.transparent,
          ),
        ),
        child: widget.loading
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
