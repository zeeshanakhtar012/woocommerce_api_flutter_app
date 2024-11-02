import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ItemCartList extends StatefulWidget {
  final String productName;
  final String imageUrl;
  final double price;
  final String color;
  final String size;
  final int quantity;
  final ValueChanged<bool> onSelected;
  final VoidCallback? onDelete;

  ItemCartList({
    required this.productName,
    required this.imageUrl,
    required this.price,
    required this.color,
    required this.size,
    required this.quantity,
    required this.onSelected,
    this.onDelete,
  });

  @override
  _ItemCartListState createState() => _ItemCartListState();
}

class _ItemCartListState extends State<ItemCartList> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        if (details.delta.dx < -5) {
          setState(() {
            isExpanded = true;
          });
        }
      },
      onHorizontalDragEnd: (details) {
        if (details.velocity.pixelsPerSecond.dx > 0) {
          setState(() {
            isExpanded = false;
          });
        }
      },
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              flex: 6,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                padding: EdgeInsets.only(left: 29.w, right: 21.w, top: 14.h, bottom: 8.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(15), bottomLeft: Radius.circular(15)),
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 4)],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: false,
                          onChanged: (v){},
                        ),
                        SizedBox(width: 16.w),
                        Container(
                          height: 112.h,
                          width: 112.w,
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 4)],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: CachedNetworkImage(
                              imageUrl: widget.imageUrl,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => CircularProgressIndicator(),
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      widget.productName,
                                      style: TextStyle(fontSize: 14.sp, color: Color(0xff4C6042), fontWeight: FontWeight.w700),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                  if (!isExpanded)
                                    InkWell(
                                      child: SvgPicture.asset("assets/icons/delete.svg"),
                                      onTap: widget.onDelete,
                                    ),
                                ],
                              ),
                              SizedBox(height: 3.5.h),
                              Text("Color: ${widget.color}", style: TextStyle(fontSize: 10.sp, color: Color(0xff4C6042))),
                              SizedBox(height: 3.5.h),
                              Text("Size: ${widget.size}", style: TextStyle(fontSize: 10.sp, color: Color(0xff4C6042))),
                              SizedBox(height: 3.5.h),
                              Text("\$${widget.price.toStringAsFixed(2)}", style: TextStyle(fontSize: 18.sp, color: Color(0xff4C6042))),
                              SizedBox(height: 3.5.h),
                              Container(
                                height: 23.h,
                                width: 93.w,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Color(0xff4C6042), width: 0.2),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(onPressed: () {}, icon: Icon(Icons.remove, size: 18.sp)),
                                    Text("${widget.quantity}", style: TextStyle(fontSize: 12.sp)),
                                    IconButton(onPressed: () {}, icon: Icon(Icons.add, size: 18.sp)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Divider(color: Colors.grey, thickness: 0.2),
                    Row(
                      children: [
                        Spacer(),
                        Text("SubTotal:", style: TextStyle(fontSize: 12.sp, color: Color(0xff4C6042), fontWeight: FontWeight.w700)),
                        Text("\$${(widget.price * widget.quantity).toStringAsFixed(2)}", style: TextStyle(fontSize: 12.sp, color: Color(0xFFFF0000), fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            if (isExpanded)
              Flexible(
                fit: FlexFit.loose,
                child: Container(
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(16), bottomRight: Radius.circular(16)),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.delete, color: Colors.white),
                    onPressed: widget.onDelete,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
