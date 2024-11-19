import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zrj/controllers/controller_cart.dart';
import 'package:zrj/model/product.dart';

class CartItemWidget extends StatefulWidget {
  final Product product;
  final Function onSelectionChanged; // Callback to notify selection change

  const CartItemWidget({Key? key, required this.product, required this.onSelectionChanged}) : super(key: key);

  @override
  State<CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  CartController cartController = Get.put(CartController());
  bool isSelected = false;  // Track selection state

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Product Image
          Image.network(
            "${widget.product.images![0].src}",  // Assuming images is a list of image URLs
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 12),
          // Product Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${widget.product.name}",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '\$${widget.product.price}', // Assuming price is a string representing a number
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                Row(
                  children: [
                    Text('Qty: ${widget.product.quantity}', style: TextStyle(fontSize: 14)),
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.remove_circle_outline),
                      onPressed: () {
                        if (widget.product.id != null) {
                          cartController.removeProductFromCart(widget.product.id!);
                        } else {
                          log('Product ID is null');
                        }
                      },
                    ),
                    Checkbox(
                      value: isSelected,
                      onChanged: (bool? value) {
                        setState(() {
                          isSelected = value!;
                          widget.onSelectionChanged(widget.product.id!, isSelected); // Notify parent
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
