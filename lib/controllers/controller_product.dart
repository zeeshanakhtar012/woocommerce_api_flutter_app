import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

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
  }

  var products = [].obs;

  // Fetch categories from WooCommerce API
  Future<void> fetchCategories() async {
    try {
      isLoading(true);
      final response = await http.get(
        Uri.parse('$baseUrl/products/categories?consumer_key=$consumerKey&consumer_secret=$consumerSecret'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        categoryList.value = jsonDecode(response.body);  // Store the categories
      } else {
        Get.snackbar('Error', 'Failed to load categories.');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch categories: $e');
    } finally {
      isLoading(false);
    }
  }

  // Get Products based on selected category ID
  Future<void> fetchProductsByCategory(String categoryId) async {
    final String url = "$baseUrl/products?category=$categoryId&consumer_key=$consumerKey&consumer_secret=$consumerSecret";
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    log("Response Status Code: ${response.body.toString()}");
    if (response.statusCode == 200) {
      products.value = jsonDecode(response.body).map((product) => Product.fromJson(product)).toList();
    } else {
      Get.snackbar("Error", "Failed to load products.");
    }
  }

  // Select Category and fetch products
  void selectCategory(String categoryId) {
    selectedCategory.value = categoryId;
    fetchProductsByCategory(categoryId);
  }

  // Toggle Category (for UI selection)
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

  // Fetch all products (for initial loading)
  Future<void> fetchAllProducts() async {
    try {
      isLoading(true);
      int page = 1;
      int perPage = 50;  // Set the limit of products per request
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
          List<dynamic> data = json.decode(response.body);
          if (data.isNotEmpty) {
            allProducts.addAll(data.map((json) => Product.fromJson(json)).toList());
            page++;  // Increment page for next request
          } else {
            break;  // No more products to fetch
          }
        } else {
          Get.snackbar('Error', 'Failed to fetch products: ${response.statusCode}');
          break;  // Exit if there is an error
        }
      } while (true);

      productList.value = allProducts;  // Update observable list
      filteredProductList.assignAll(productList);  // Show all initially
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch products: $e');
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
        productList.where((product) => product.name.toLowerCase().contains(query.toLowerCase())).toList(),
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

  // Add product to wishlist
  // Future<void> addProductToCart(int productId, {String? color, String? size, int? quantity}) async {
  //   try {
  //     isLoading(true);
  //     final cartUrl = Uri.parse('https://zrjfashionstyle.com/?wc-ajax=add_to_cart');
  //
  //     // Prepare headers, including Basic Auth for WooCommerce API
  //     var headers = {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Basic ' + base64Encode(utf8.encode('$consumerKey:$consumerSecret')),
  //     };
  //
  //     // Prepare the body for the request
  //     var body = {
  //       'product_id': productId, // Include the product ID
  //       'quantity': quantity,     // Include the quantity
  //       if (color != null) 'attributes': [{'name': 'Color', 'option': color}],
  //       if (size != null) 'attributes': [{'name': 'Size', 'option': size}],
  //     };
  //
  //     // Merge the attributes if both color and size are provided
  //     if (color != null && size != null) {
  //       body['attributes'] = [
  //         {'name': 'Color', 'option': color},
  //         {'name': 'Size', 'option': size},
  //       ];
  //     }
  //
  //     var response = await http.post(
  //       cartUrl,
  //       headers: headers,
  //       body: jsonEncode(body), // Encode the body to JSON format
  //     );
  //
  //     log(response.body.toString());
  //     if (response.statusCode == 200) {
  //       log("Product with ID $productId added to cart successfully");
  //       // Optionally, you can fetch updated cart items here
  //       Get.snackbar('Success', 'Product added to cart successfully!',
  //           snackPosition: SnackPosition.BOTTOM,
  //           backgroundColor: Colors.green,
  //           colorText: Colors.white);
  //       await getCartItems();
  //     } else {
  //       log("Failed to add product to cart: ${response.body}");
  //       Get.snackbar('Error', 'Failed to add product to cart.',
  //           snackPosition: SnackPosition.BOTTOM,
  //           backgroundColor: Colors.red,
  //           colorText: Colors.white);
  //     }
  //   } catch (e) {
  //     print("Error adding product to cart: $e");
  //   }finally{
  //     isLoading(false);
  //   }
  // }
  // // Get wishlist products
  // Future<void> getCartItems() async {
  //   try {
  //     var response = await http.get(
  //       Uri.parse('https://zrjfashionstyle.com/cart/'),
  //       headers: {
  //         'Authorization': 'Basic ' + base64Encode(utf8.encode('$consumerKey:$consumerSecret')),
  //       },
  //     );
  //
  //     print("Response Status Code: ${response.statusCode}");
  //     print("Response Body: ${response.body}"); // Debugging output
  //
  //     if (response.statusCode == 200) {
  //       // Attempt to decode JSON only if the content type is application/json
  //       if (response.headers['content-type']?.contains('application/json') ?? false) {
  //         var data = jsonDecode(response.body);
  //         cartItems.value = data;
  //         print("Cart items retrieved successfully");
  //       } else {
  //         print("Expected JSON response but received: ${response.headers['content-type']}");
  //       }
  //     } else {
  //       print("Failed to retrieve cart items: ${response.body}");
  //     }
  //   } catch (e) {
  //     print("Error fetching cart items: $e");
  //   }
  // }

  // add cart to local storage

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
