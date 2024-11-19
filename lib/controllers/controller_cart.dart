import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zrj/model/product.dart';

class CartController extends ChangeNotifier {
  List<Product> _cartItems = [];

  List<Product> get cartItems => _cartItems;

  // Load cart items from local storage
  Future<void> loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final String? cartData = prefs.getString('cart_items');

    if (cartData != null) {
      final List<dynamic> decodedCart = jsonDecode(cartData);
      _cartItems = decodedCart.map((item) => Product.fromJson(item as Map<String, dynamic>)).toList();
    }
    notifyListeners();
  }

  // Save cart items to local storage
  Future<void> saveCart() async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedCart = jsonEncode(_cartItems.map((product) => _productToJson(product)).toList());
    await prefs.setString('cart_items', encodedCart);
  }

  // Add product to the cart
  // Add product to the cart
  Future<void> addProductToCart(Product product) async {
    // Search for the existing product in the cart
    final existingProduct = _cartItems.firstWhere(
          (item) => item.id == product.id,
      orElse: () => Product(), // Return an empty product if no match is found
    );

    if (existingProduct.id != null && existingProduct.id != 0) {
      // If an existing product is found, update its quantity
      existingProduct.quantity = (existingProduct.quantity ?? 0) + (product.quantity ?? 1);
    } else {
      // If no matching product is found, add the new product to the cart
      product.quantity = product.quantity ?? 1;
      _cartItems.add(product);
    }

    // Save the updated cart and notify listeners
    await saveCart();
    notifyListeners();
  }


  // Remove product from the cart
  Future<void> removeProductFromCart(int productId) async {
    _cartItems.removeWhere((item) => item.id == productId);
    Get.snackbar(
        'Success', 'Product removed from cart',
        backgroundColor: Colors.green, colorText: Colors.white
    );
    await saveCart();
    notifyListeners();
  }

  // Update product quantity
  Future<void> updateProductQuantity(int productId, int quantity) async {
    final product = _cartItems.firstWhere((item) => item.id == productId, orElse: () => Product());
    if (product.id != null) {
      product.quantity = quantity;
      if (quantity <= 0) _cartItems.remove(product);
      await saveCart();
      notifyListeners();
    }
  }

  // Clear the cart
  Future<void> clearCart() async {
    _cartItems.clear();
    await saveCart();
    notifyListeners();
  }

  // Convert Product to JSON with safe handling
  Map<String, dynamic> _productToJson(Product product) {
    return {
      'id': product.id,
      'name': product.name,
      'price': product.price,
      'quantity': product.quantity,
      // 'categories': product.categories?.map((e) => e.toJson()).toList(),
      'images': product.images![0].src,
      // 'attributes': product.attributes?.map((e) => e.toJson()).toList(),
      'color': product.color,
      'size': product.size,
    };
  }

}
