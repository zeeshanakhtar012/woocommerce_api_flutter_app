import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zrj/controllers/controller_cart.dart';
import 'package:zrj/model/product.dart';
import 'package:zrj/widgets/cart_item_widget.dart';

class LayoutCart extends StatefulWidget {
  final bool isHome;

  LayoutCart({required this.isHome});

  @override
  _LayoutCartState createState() => _LayoutCartState();
}

class _LayoutCartState extends State<LayoutCart> {
  final CartController cartController = Get.put(CartController());
  List<int> selectedProductIds = [];  // Track selected products

  // Calculate the total price of selected products
  double calculateTotalPrice() {
    double total = 0;
    for (var product in cartController.cartItems) {
      if (selectedProductIds.contains(product.id)) {
        // Parse the price from String to double, and quantity to int.
        total += (double.tryParse(product.price ?? '0') ?? 0) * (product.quantity?.toInt() ?? 1);
      }
    }
    return total;
  }
  // Handle product selection and deselection
  void toggleProductSelection(int productId, bool isSelected) {
    setState(() {
      if (isSelected) {
        selectedProductIds.add(productId);  // Add to selection
      } else {
        selectedProductIds.remove(productId);  // Remove from selection
      }
    });
  }

  // Handle removal of selected products
  void removeSelectedProducts() async {
    for (var productId in selectedProductIds) {
      await cartController.removeProductFromCart(productId);
    }
    setState(() {
      selectedProductIds.clear(); // Clear the selected products after removal
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        title: Text("My Cart"),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () async {
              await cartController.clearCart();
              setState(() {}); // Reload cart after clearing
            },
            child: Text("Clear Cart"),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cartController.cartItems.length,
                itemBuilder: (context, index) {
                  Product product = cartController.cartItems[index];
                  return CartItemWidget(
                    product: product,
                    onSelectionChanged: toggleProductSelection,
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total: \$${calculateTotalPrice().toStringAsFixed(2)}"),
                  ElevatedButton(
                    onPressed: () {
                      // Handle Order Now action
                      // Get.to(YourOrderScreen());
                    },
                    child: Text("Order Now"),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: removeSelectedProducts,
                child: Text("Remove Selected Products"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
