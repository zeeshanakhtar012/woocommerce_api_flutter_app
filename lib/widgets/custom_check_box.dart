import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCheckbox extends StatefulWidget {
  final bool initialValue;
  final ValueChanged<bool> onChanged;
  final double size;
  final Color activeColor;
  final Color inactiveColor;
  final Widget? label;

  const CustomCheckbox({
    Key? key,
    required this.initialValue,
    required this.onChanged,
    this.size = 24.0,
    this.activeColor = Colors.green,
    this.inactiveColor = Colors.white,
    this.label,
  }) : super(key: key);

  @override
  _CustomCheckboxState createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  late bool _isChecked ;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.initialValue;
  }

  void _toggleCheckbox() {
    setState(() {
      _isChecked = !_isChecked;
    });
    widget.onChanged(_isChecked);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleCheckbox,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: widget.size.sp,
            height: widget.size.sp,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey
              ),
              color: _isChecked ? widget.activeColor : widget.inactiveColor,
              borderRadius: BorderRadius.circular(5),
            ),
            child: _isChecked
                ? Icon(Icons.check, color: Colors.white, size: widget.size * 0.6.sp)
                : null,
          ),
          if (widget.label != null) ...[
            SizedBox(width: 8.sp),
            widget.label!,
          ],
        ],
      ),
    );
  }
}
