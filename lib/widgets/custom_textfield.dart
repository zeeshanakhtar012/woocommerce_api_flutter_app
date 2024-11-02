import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTextfield extends StatefulWidget {
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final bool? isPasswordField;
  final String? hint;
  final Widget? prefix;
  final Widget? suffix;
  final TextStyle? textStyle;
  final int? maxLines;
  final EdgeInsetsGeometry? padding;
  final ValueChanged<String>? onChange;
  final TextInputType? keyboardType;

  const CustomTextfield({
    Key? key,
    this.validator,
    this.controller,
    this.isPasswordField,
    this.hint,
    this.prefix,
    this.suffix,
    this.textStyle,
    this.maxLines,
    this.padding,
    this.onChange,
    this.keyboardType,
  }) : super(key: key);

  @override
  _MyInputFieldState createState() => _MyInputFieldState();
}

class _MyInputFieldState extends State<CustomTextfield> {
  late bool _isHidden;
  var hasError = false.obs;
  
  

  @override
  void initState() {
    super.initState();
    _isHidden = widget.isPasswordField ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding ?? EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Color(0xFFF6F6F6),
        border: Border.all(color: hasError.value ? Colors.red : Colors.transparent),
        borderRadius: BorderRadius.circular(32),
      ),
      child: TextFormField(
        controller: widget.controller,
        cursorColor: Colors.black,
        obscureText: _isHidden,
        keyboardType: widget.keyboardType,
        maxLines: widget.maxLines ?? 1,
        style: widget.textStyle ?? TextStyle(fontSize: 14, color: Colors.black),
        onChanged: (value) {
          widget.onChange?.call(value);
          // setState(() {
            hasError.value = widget.validator != null && widget.validator!(value) != null;
          // });
        },
        validator: (value) {
          final error = widget.validator?.call(value);
          // setState(() {
            hasError.value = error != null;
          // });
          return null;  // No error message shown, only border changes
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          prefixIcon: widget.prefix,
          hintText: widget.hint,
          suffixIcon: widget.suffix ?? (widget.isPasswordField == true
              ? IconButton(
                  icon: Icon(_isHidden ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _isHidden = !_isHidden;
                    });
                  },
                )
              : null),
          fillColor: Color(0xFFF6F6F6),
          filled: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32),
            borderSide: BorderSide(color: Colors.transparent, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32),
            borderSide: BorderSide(color: hasError.value ? Colors.red : Colors.transparent, width: 1),
          ),
        ),
      ),
    );
  }
}
