import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../constants/colors.dart';

class MyAddressCostomTexttField extends StatefulWidget {
  final String? hint;
  final String? label;
  final bool? isPasswordField;
  final TextStyle? textStyle;
  final Function(String? value)? onChange;
  final TextInputType? keyboardType;
  final void Function(String)? onFieldSubmitted;
  final Widget? prefix;
  final int? limit;
  final double? height;
  final double? width;
  final TextEditingController? controller;
  final VoidCallback? onTap;
  final bool? readOnly;
  final Color? fillColor;
  final int? maxLines;
  final int? minLines;
  final String? text;
  final Color? counterColor;
  final bool? showCounter;
  final bool? showBorder;
  final bool? isDense;
  final Key? key;
  final FocusNode? focusNode;
  final EdgeInsetsGeometry? margin;
  final String? Function(String?)? validator;
  final Future<String?> Function(String?)? asyncValidator;
  final Widget? suffix;
  final InputBorder? border;
  final InputBorder? enabledBorder;
  final InputBorderType? borderType;
  final EdgeInsetsGeometry? padding;

  MyAddressCostomTexttField(
      {this.hint,
        this.isPasswordField,
        this.onChange,
        this.padding,
        this.keyboardType,
        this.prefix,
        this.limit,
        this.height,
        this.controller,
        this.onTap,
        this.readOnly,
        this.fillColor,
        this.maxLines,
        this.text,
        this.showCounter,
        this.counterColor,
        this.showBorder,
        this.minLines,
        this.margin,
        this.suffix,
        this.validator,
        this.isDense,
        this.onFieldSubmitted,
        this.asyncValidator,
        this.label,
        this.key,
        this.textStyle,
        this.border,
        this.enabledBorder,
        this.borderType,
        this.focusNode,
        this.width})
      : super(key: key);

  final _state = _MyAddressCostomTexttFieldState();

  @override
  _MyAddressCostomTexttFieldState createState() {
    return _state;
  }

  Future<void> validate() async {
    if (asyncValidator != null) {
      await _state.validate();
    }
  }
}

class _MyAddressCostomTexttFieldState extends State<MyAddressCostomTexttField> {
  late bool _isHidden;
  String text = "";
  bool isPasswordField = false;

  @override
  void initState() {
    isPasswordField = widget.isPasswordField ?? false;
    _isHidden = isPasswordField;
    errorMessage = null;
    if (widget.validator != null && widget.asyncValidator != null) {
      throw "validator and asyncValidator are not allowed at same time";
    }

    if (widget.controller != null && widget.text != null) {
      widget.controller!.text = widget.text!;
    }

    super.initState();
  }

  var isValidating = false;
  var isValid = false;
  var isDirty = false;

  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return

      // Container(
      //   padding: EdgeInsets.only(
      //     top: 6.h,
      //     left: 6.w,
      //   ),
      //   decoration: BoxDecoration(
      //     // color: Color(0xffF6F6F7),
      //     borderRadius: BorderRadius.circular(50),
      //     // boxShadow: [
      //     //   BoxShadow(
      //     //     blurStyle: BlurStyle.inner,
      //     //     color: Colors.grey.withOpacity(.12),
      //     //   )
      //     // ]
      //   ),
      //   alignment: Alignment.center,
      //   margin: EdgeInsets.symmetric(vertical: 6),
      //   // padding: EdgeInsets.only(top: 2),
      //   // height:widget.height,
      //   width: widget.width ?? Get.width,

      //   child:

      _fieldContainer(
        TextFormField(
          maxLength: widget.limit,
          cursorColor: AppColors.appPrimaryColor,
          key: widget.key,
          onChanged: widget.asyncValidator == null
              ? widget.onChange
              : (value) {
            text = value.toString();
            validateValue(text);
            if (widget.onChange != null) {
              widget.onChange!(text);
            }
          },
          style: widget.textStyle ??
              TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                  color: Color(0xff4C6042)),
          obscureText: _isHidden,
          onTap: widget.onTap,
          validator: widget.validator ??
              (widget.asyncValidator != null
                  ? (value) {
                text = value.toString();
                return errorMessage;
                // return null;
              }
                  : null),
          maxLines: widget.maxLines ?? 1,
          minLines: widget.minLines,
          readOnly: widget.readOnly ?? false,
          keyboardType: widget.keyboardType,
          controller: widget.controller,
          initialValue: widget.controller == null ? widget.text : null,
          onFieldSubmitted: widget.onFieldSubmitted,
          focusNode: widget.focusNode,
          enabled: widget.keyboardType != TextInputType.none,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          buildCounter: (_,
              {required currentLength, maxLength, required isFocused}) {
            return Visibility(
                visible: widget.showCounter ?? false,
                child: visibilityPadding(currentLength, maxLength));
          },
          cursorHeight: 22.sp,
          autocorrect: true,
          decoration: InputDecoration(
              prefixIcon: widget.prefix,
              hintText: widget.hint,
              labelText: widget.label,
              labelStyle: customText(fontSize: 13.sp, color: Color(0xFF000000)),
              isDense: widget.isDense,
              fillColor: Color(0xFFFFFFFF),
              filled: true,
              suffixIconConstraints: BoxConstraints(minWidth: 10.w),
              suffixIcon: widget.suffix ??
                  (isPasswordField
                      ? IconButton(
                    onPressed: () {
                      if (isPasswordField) {
                        if (mounted) {
                          setState(() {
                            _isHidden = !_isHidden;
                          });
                        }
                      }
                    },
                    icon: Visibility(
                      visible: isPasswordField,
                      child: Icon(
                        isPasswordField
                            ? (_isHidden
                            ? Icons.visibility
                            : Icons.visibility_off)
                            : null,
                        color: Color(0xFFA7A7A7),
                      ),
                    ),
                  )
                      : (widget.asyncValidator != null
                      ? _getSuffixIcon()
                      : null)),
              hintStyle:
              TextStyle(color: AppColors.appGreyColor, fontSize: 14.sp),
              contentPadding:
              EdgeInsets.only(top: 23.h, bottom: 21.h, left: 23.w),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50.r),
                borderSide: BorderSide(color: Colors.transparent, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.r),
                  borderSide: BorderSide(color: Colors.transparent, width: 1)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.r),
                  borderSide: BorderSide(color: Colors.transparent, width: 1)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.r),
                  borderSide: BorderSide(color: Colors.red, width: 1))
            // border: InputBorder.none,
            // filled: true,
            // fillColor: Color(0xF0BBBBBB),
          ),
        ),
      );
  }

  Widget _fieldContainer(Widget child) {
    return Container(
      // padding: EdgeInsets.only(
      //   top: 6.h,
      //   left: 6.w,
      // ),
        decoration: BoxDecoration(
            color: Color(0xffF6F6F7),
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                blurStyle: BlurStyle.inner,
                color: Colors.grey.withOpacity(.12),
              )
            ]),
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(vertical: 6),
        // padding: EdgeInsets.only(top: 2),
        // height:widget.height,
        width: widget.width ?? Get.width,
        child: child);
  }

  TextStyle customText({Color color = Colors.black, var fontSize = 13.0}) {
    return TextStyle(color: color, fontSize: fontSize);
  }

  Widget visibilityPadding(var currentLength, maxLength) {
    return Padding(
      padding: EdgeInsets.only(left: 16.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
        ),
        alignment: Alignment.centerRight,
        child: Text(
          currentLength.toString() +
              (widget.limit != null ? "/" + maxLength.toString() : ""),
          style: TextStyle(color: widget.counterColor),
        ),
      ),
    );
  }

//   @override
// Widget build(BuildContext context) {
//   return Container(
//     padding: EdgeInsets.only(
//       top: 6.h,
//       left: 6.w,
//     ),
//     alignment: Alignment.center,
//     margin: EdgeInsets.symmetric(vertical: 6),
//     width: widget.width ?? Get.width,

//     child: TextFormField(
//       maxLength: widget.limit,
//       cursorColor: AppColors.appPrimaryColor,
//       key: widget.key,
//       onChanged: widget.asyncValidator == null
//           ? widget.onChange
//           : (value) {
//               text = value.toString();
//               validateValue(text);
//               if (widget.onChange != null) {
//                 widget.onChange!(text);
//               }
//             },
//       style: widget.textStyle ??
//           TextStyle(
//               fontWeight: FontWeight.w600,
//               fontSize: 14.sp,
//               color: Color(0xff4C6042)),
//       obscureText: _isHidden,
//       onTap: widget.onTap,
//       validator: widget.validator ??
//           (widget.asyncValidator != null
//               ? (value) {
//                   text = value.toString();
//                   return errorMessage; // We will handle the error message separately
//                 }
//               : null),
//       maxLines: widget.maxLines ?? 1,
//       minLines: widget.minLines,
//       readOnly: widget.readOnly ?? false,
//       keyboardType: widget.keyboardType,
//       controller: widget.controller,
//       initialValue: widget.controller == null ? widget.text : null,
//       onFieldSubmitted: widget.onFieldSubmitted,
//       focusNode: widget.focusNode,
//       enabled: widget.keyboardType != TextInputType.none,
//       // autovalidateMode: AutovalidateMode.onUser Interaction,
//       buildCounter: (_,
//           {required currentLength, maxLength, required isFocused}) {
//         return Visibility(
//           visible: widget.showCounter ?? false,
//           child: Padding(
//             padding: EdgeInsets.only(left: 16.0),
//             child: Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(50),
//               ),
//               alignment: Alignment.centerRight,
//               child: Text(
//                 currentLength.toString() +
//                     (widget.limit != null ? "/" + maxLength.toString() : ""),
//                 style: TextStyle(color: widget.counterColor),
//               ),
//             ),
//           ),
//         );
//       },
//       cursorHeight: 22.sp,
//       autocorrect: true,
//       decoration: InputDecoration(
//           prefixIcon: widget.prefix,
//           hintText: widget.hint,
//           labelText: widget.label,
//           labelStyle: TextStyle(
//             color: Color(0xFF000000),
//             fontSize: 13.sp,
//           ),
//           isDense: widget.isDense,
//           fillColor: Color(0xFFF6F6F6) ,// Set the TextFormField background color to green
//           filled: true, // Make sure the TextFormField is filled
//           suffixIconConstraints: BoxConstraints(minWidth: 10.w),
//           suffixIcon: widget.suffix ??
//               (isPasswordField
//                   ? IconButton(
//                       onPressed: () {
//                         if (isPasswordField) {
//                           if (mounted) {
//                             setState(() {
//                               _isHidden = !_isHidden;
//                             });
//                           }
//                         }
//                       },
//                       icon: Visibility(
//                         visible: isPasswordField,
//                         child: Icon(
//                           isPasswordField
//                               ? (_isHidden
//                                   ? Icons.visibility
//                                   : Icons.visibility_off)
//                               : null,
//                           color: Color(0xFFA7A7A7),
//                         ),
//                       ),
//                     )
//                   : (widget.asyncValidator != null
//                       ? _getSuffixIcon()
//                       : null)),
//           hintStyle:
//               TextStyle(color: AppColors.appGreyColor, fontSize: 14.sp),
//           contentPadding: widget.padding ??
//               EdgeInsets.only(
//                   left: 15,
//                   right: 15,
//                   top: (widget.maxLines != null) ? 15 : 15,
//                   bottom: (widget.maxLines != null) ? 15 : 5),
//           border: InputBorder.none,
//           focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(25),
//               borderSide: BorderSide(color: Colors.transparent, width: 2)),
//           enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(25),
//               borderSide: BorderSide(color: Colors.transparent, width: 1)),
//           errorBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(25),
//               borderSide: BorderSide(color: Colors.red, width: 1)),
//         ),
//       ),
//     );
//   }

  Widget _getSuffixIcon() {
    if (isValidating) {
      return Transform.scale(scale: 0.7, child: CupertinoActivityIndicator());
    } else {
      if (!isValid && isDirty) {
        return Icon(
          Icons.cancel,
          color: Colors.red,
          size: 20,
        );
      } else if (isValid) {
        return Icon(
          Icons.check_circle,
          color: Colors.green,
          size: 20,
        );
      } else {
        return SizedBox(
          height: 1,
          width: 1,
        );
      }
    }
  }

  Future<void> validateValue(String newValue) async {
    isDirty = true;
    if (text.isEmpty) {
      if (mounted) {
        setState(() {
          isValid = false;
        });
      }
      return;
    }
    isValidating = true;
    if (mounted) {
      setState(() {});
    }
    errorMessage = await widget.asyncValidator!(newValue);
    isValidating = false;
    isValid = errorMessage == null;
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> validate() async {
    await validateValue(text);
  }
}

enum InputBorderType { outline, underline }
