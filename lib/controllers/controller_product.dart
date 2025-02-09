import 'dart:developer';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/category.dart';
import '../model/product.dart';
import '../utils/wordpress_endpoints.dart';

class ProductWooCommerceController extends GetxController {
  var isLoading = false.obs;
  var product = Rxn<Product>();
  var productList = <Product>[].obs;
  var filteredProductList = <Product>[].obs;
  var selectedCategories = <String>[].obs;
  var selectedCategory = ''.obs;
  var cartItems = [].obs;
  var categoryList = [].obs;
  var wishlistItems = <Product>[].obs;

  final String baseUrl = ConsumerId.baseUrl;
  final String consumerKey = ConsumerId.consumerKey;
  final String consumerSecret = ConsumerId.consumerSecret;

  @override
  void onInit() {
    super.onInit();
    fetchAllProducts();
    fetchCategories();  // Fetch categories on initialization
    loadCartAndWishlist();  // Load cart and wishlist from local storage
  }

  var products = [].obs;

  // Fetch categories from WooCommerce API
  Future<void> fetchCategories() async {
    try {
      isLoading(true);
      final String consumerKey = ConsumerId.consumerKey;
      final String consumerSecret = ConsumerId.consumerSecret;
      final String basicAuth = 'Basic ' + base64Encode(utf8.encode('$consumerKey:$consumerSecret'));
      final response = await http.get(
        Uri.parse('https://zrjfashionstyle.com/wp-json/wc/v3/products/categories'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': basicAuth,
        },
      );
      if (response.statusCode == 200) {
        String responseBody = response.body;
        if (responseBody.startsWith('JWT route is registered[')) {
          responseBody = responseBody.substring(responseBody.indexOf('['));
        }
        final List<dynamic> data = jsonDecode(responseBody);
        categoryList.value = data.map((json) => Category.fromJson(json)).toList();
      } else {
        log('Failed to load categories with status code: ${response.statusCode}');
      }
    } catch (e) {
      log('Failed to fetch categories: $e');
    } finally {
      isLoading(false);
    }
  }
  // Get Products based on selected category ID
  Future<void> fetchProductsByCategory(String categoryId) async {
    isLoading.value = true;
    try {
      // Get the token from shared preferences
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString('token');
      log("token is $token");

      if (token == null) {
        return;  // Return early if no token exists
      }
      final String url = "$baseUrl/products?category=$categoryId&consumer_key=$consumerKey&consumer_secret=$consumerSecret";

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      // log("Response Status Code: ${response.statusCode}");
      log("Response Body: ${response.body}");
      if (response.statusCode == 200) {
        filteredProductList.value = jsonDecode(response.body).map((product) => Product.fromJson(product)).toList();
      } else {
        // Get.snackbar("Error", response.body.isNotEmpty ? response.body : "Failed to load products.");
      }
    } catch (e) {
      log("Error to fetch products by category: $e");
      // Get.snackbar("Error", "An error occurred while fetching products.");
    } finally {
      isLoading.value = false;
    }
  }
  void selectCategory(String categoryId) {
    selectedCategory.value = categoryId;
    fetchProductsByCategory(categoryId);
  }

  void toggleCategory(String category) {
    if (selectedCategories.contains(category)) {
      selectedCategories.remove(category);
    } else {
      selectedCategories.add(category);
    }
  }

  bool isSelected(String category) {
    return selectedCategories.contains(category);
  }

  Future<void> fetchAllProducts() async {
    try {
      isLoading(true);
      int page = 1;
      int perPage = 50;
      List<Product> allProducts = [];

      do {
        final response = await http.get(
          Uri.parse('$baseUrl/products?consumer_key=$consumerKey&consumer_secret=$consumerSecret&per_page=$perPage&page=$page'),
          headers: {
            'Content-Type': 'application/json',
          },
        );

        log('Response Status Code: ${response.statusCode}');
        log('Response Body: ${response.body}');

        if (response.statusCode == 200) {
          String responseBody = response.body;
          if (responseBody.startsWith('JWT route is registered[')) {
            responseBody = responseBody.substring(responseBody.indexOf('['));
          }
          List<dynamic> data = json.decode(responseBody);

          log('Decoded Data: $data');
          if (data.isNotEmpty) {
            allProducts.addAll(data.map((json) => Product.fromJson(json)).toList());
            page++;
          } else {
            break;
          }
        } else {
          log('Failed to fetch products: ${response.statusCode}');
          break;
        }
      } while (true);
      productList.value = allProducts;
      filteredProductList.assignAll(productList);

    } catch (e) {
      log('Failed to fetch products: $e');
    } finally {
      isLoading(false);
    }
  }

  // Filter products by search query
  void filterProducts(String query) {
    if (query.isEmpty) {
      filteredProductList.assignAll(productList);  // Show all if query is empty
    } else {
      filteredProductList.assignAll(
        productList.where((product) => product.name!.toLowerCase().contains(query.toLowerCase())).toList(),
      );
    }
  }

  // Fetch product by ID
  Future<void> fetchProductById(int id) async {
    try {
      isLoading(true);

      final response = await http.get(
        Uri.parse('$baseUrl/products/$id?consumer_key=$consumerKey&consumer_secret=$consumerSecret'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        product.value = Product.fromJson(json.decode(response.body));
      } else {
        Get.snackbar('Error', 'Failed to fetch product: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch product: $e');
    } finally {
      isLoading(false);
    }
  }

  // Load cart and wishlist from local storage
  Future<void> loadCartAndWishlist() async {
    final prefs = await SharedPreferences.getInstance();
    final cartData = prefs.getString('cartItems');
    final wishlistData = prefs.getString('wishlistItems');
    if (cartData != null) {
      cartItems.assignAll((jsonDecode(cartData) as List)
          .map((data) => Product.fromJson(data))
          .toList());
    }
    if (wishlistData != null) {
      wishlistItems.assignAll((jsonDecode(wishlistData) as List)
          .map((data) => Product.fromJson(data))
          .toList());
    }
  }
  // Save cart and wishlist to local storage
  Future<void> saveCartAndWishlist() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('cartItems', jsonEncode(cartItems));
    await prefs.setString('wishlistItems', jsonEncode(wishlistItems));
  }

  // Add product to cart
  void addProductToCartLocal(Product product) {
    if (!cartItems.contains(product)) {
      cartItems.add(product);
      saveCartAndWishlist();
      log("Product added to cart!");
      Get.snackbar('Success', 'Product added to cart!',
          backgroundColor: Colors.green, colorText: Colors.white);
    } else {
      Get.snackbar('Info', 'Product already in cart.',
          backgroundColor: Colors.blue, colorText: Colors.white);
    }
  }

  // Remove product from cart
  void removeProductFromCart(Product product) {
    cartItems.remove(product);
    saveCartAndWishlist();
    Get.snackbar('Info', 'Product removed from cart.',
        backgroundColor: Colors.orange, colorText: Colors.white);
  }
  // Add product to wishlist
  void addProductToWishlist(Product product) {
    if (!wishlistItems.contains(product)) {
      wishlistItems.add(product);
      saveCartAndWishlist();
      Get.snackbar('Success', 'Product added to wishlist!',
          backgroundColor: Colors.pink, colorText: Colors.white);
    } else {
      Get.snackbar('Info', 'Product already in wishlist.',
          backgroundColor: Colors.blue, colorText: Colors.white);
    }
  }

  // Remove product from wishlist
  void removeProductFromWishlist(Product product) {
    wishlistItems.remove(product);
    saveCartAndWishlist();
    Get.snackbar('Info', 'Product removed from wishlist.',
        backgroundColor: Colors.orange, colorText: Colors.white);
  }
}
