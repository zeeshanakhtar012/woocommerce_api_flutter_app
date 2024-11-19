import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/user.dart';
import '../model/user_model.dart';
import '../utils/firebase_utils.dart';
import '../utils/wordpress_endpoints.dart';
import '../views/home/home_screen.dart';
import '../views/screens/authentication_screens/screen_login.dart';
import '../views/screens/authentication_screens/screen_signup.dart';

class ControllerAuthentication extends GetxController {
  var email = TextEditingController().obs;
  var isLoading = false.obs;
  var firstName = TextEditingController().obs;
  var lastName = TextEditingController().obs;
  var userName = TextEditingController().obs;
  var country = TextEditingController().obs;
  var city = TextEditingController().obs;
  var state = TextEditingController().obs;
  var password = TextEditingController().obs;
  var phoneNumber = TextEditingController().obs;
  var address = TextEditingController().obs;
  final Map<String, String> billing = {};
  final Map<String, String> shipping = {};
  var userDisplayName = ''.obs;
  var user = Rx<User?>(null);

  final String consumerKey = ConsumerId.consumerKey;
  final String consumerSecret = ConsumerId.consumerSecret;

  // Signup user
  Future<void> signupUser() async {
    isLoading(true);
    try {
      final url = Uri.parse("https://zrjfashionstyle.com/wp-json/wc/v3/customers");
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Basic ${base64Encode(utf8.encode('$consumerKey:$consumerSecret'))}',
        },
        body: jsonEncode({
          'email': email.value.text,
          'first_name': firstName.value.text,
          'last_name': lastName.value.text,
          'user_login': userName.value.text,
          'password': password.value.text,
          'billing': {
            'phone': phoneNumber.value.text,
            'address_1': address.value.text,
          },
          'shipping': {
            'address_1': address.value.text,
            'country': country.value.text,
            'city': city.value.text,
            'state': state.value.text,
          },
          'meta_data': [
            {'key': 'profile_image', 'value': 'https://example.com/image.jpg'},
          ],
        }),
      );
      log("user details ${response.body}");
      if (response.statusCode == 201) {
        String responseBody = response.body;

        if (responseBody.startsWith('JWT route is registered')) {
          responseBody = responseBody.substring(responseBody.indexOf('{'));
        }
        final data = jsonDecode(responseBody);
        int userId = data['id'];
        final String? token = await getToken();

        // Check if token is null
        if (token != null) {
          FirebaseUtils.showSuccess('User created successfully');
          log('User created: $userId');
          saveUserId(userId);
          saveToken(token); // Only save token if it's not null
          _saveUserDetails(
            email.value.text,
            userName.value.text,
            userDisplayName.value,
            token,
            // userId,
          );
          Get.offAll(HomeScreen());
        } else {
          FirebaseUtils.showError('Token is null. User creation failed.');
          log('Error: Token is null');
        }
      } else {
        FirebaseUtils.showError('Failed to create user');
        log('Failed to create user: ${response.body}');
      }
    } catch (e) {
      FirebaseUtils.showError('An error occurred $e');
      log('Error: $e');
    } finally {
      isLoading(false); // End loading
    }
  }
  // save user id from the sign up
  Future<void> saveUserId(int userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt("userId", userId);
  }
  // update user details
  Future<void> updateUserDetails(String userId) async {
    isLoading(true);
    try {
      final url = Uri.parse("https://zrjfashionstyle.com/wp-json/wc/v3/customers/$userId");
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Basic ${base64Encode(utf8.encode('$consumerKey:$consumerSecret'))}',
        },
        body: jsonEncode({
          'email': email.value.text,
          'first_name': firstName.value.text,
          'last_name': lastName.value.text,
          'user_login': userName.value.text,
          'password': password.value.text,
          'billing': {
            'phone': phoneNumber.value.text,
            'address_1': address.value.text,
          },
          'shipping': {
            'address_1': address.value.text,
            'country': country.value.text,
            'city': city.value.text,
            'state': state.value.text,
          },
          'meta_data': [
            {'key': 'profile_image', 'value': 'https://example.com/image.jpg'},
          ],
        }),
      );

      if (response.statusCode == 200) {
        // Remove the 'JWT route is registered' prefix if present
        String responseBody = response.body;
        if (responseBody.startsWith('JWT route is registered')) {
          responseBody = responseBody.substring(responseBody.indexOf('{'));
        }

        // Parse the modified JSON response
        final data = jsonDecode(responseBody);
        FirebaseUtils.showSuccess('User details updated successfully');
        log('User updated: ${data['id']}');
      } else {
        FirebaseUtils.showError('Failed to update user');
        log('Failed to update user: ${response.body}');
      }
    } catch (e) {
      FirebaseUtils.showError('An error occurred while updating user');
      log('Error: $e');
    } finally {
      isLoading(false); // End loading
    }
  }
  /// sign in user
  Future<void> signInUser() async {
    isLoading.value = true; // Start loading
    try {
      final url = Uri.parse("https://zrjfashionstyle.com/wp-json/jwt-auth/v1/token");
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': userName.value.text,
          'password': password.value.text,
        }),
      );

      log('Response status: ${response.statusCode}');
      log('Response body: ${response.body}');

      if (response.statusCode == 200) {
        String responseBody = response.body;
        if (responseBody.contains("JWT route is registered")) {
          responseBody = responseBody.replaceFirst("JWT route is registered", "");
        }
        final data = jsonDecode(responseBody);
        final token = data['token'];
        final userName = data['user_nicename'];
        final userEmail = data['user_email'];
        final userDisplayName = data['user_display_name'];
        // log('Received Token: $token');
        // log('Received Email: $userEmail');
        // log('Received username: $userDisplayName');
        // log('User Nicename: $userName');
        // fetchUserIdByToken();
        saveToken(token);
        // fetchUserIdByToken();
        // Verify token format and navigate to home screen
        if (token != null && token.split('.').length == 3) {
          _saveUserDetails(
            userEmail,
            userName,
            userDisplayName,
            token
          );
          FirebaseUtils.showSuccess('Successful: User logged in successfully');
          Get.offAll(() => HomeScreen());
        }
      }
    } catch (e) {
      FirebaseUtils.showError('An error occurred');
      log('Error: $e');
    } finally {
      isLoading.value = false; // End loading
    }
  }
  // save user details
  Future<User> fetchUserDetails() async {
    // Retrieve the userId from local storage
    final String? userIdString = await getUserId();

    // Ensure the userIdString is not null and convert it to an int
    if (userIdString == null) {
      throw Exception('User ID not found');
    }

    // Convert the userIdString to an integer
    final int userId = int.parse(userIdString); // Convert the String to int

    final String url = 'https://zrjfashionstyle.com/wp-json/wc/v3/customers/$userId';

    // Send the HTTP GET request
    final response = await http.get(Uri.parse(url));

    log('response ${response.body}');
    if (response.statusCode == 200) {
      // Clean the response if it has unwanted text at the start
      String cleanResponse = response.body.replaceFirst('JWT route is registered{', '{');
      final Map<String, dynamic> jsonResponse = jsonDecode(cleanResponse);
      return User.fromJson(jsonResponse); // Convert the cleaned JSON response to a UserModel
    } else {
      throw Exception('Failed to load user details');
    }
  }
  // user by id
  Future<void> fetchUserDetailsById() async {
    String? userId = await getUserId();
    // String? token = await getToken();
    log("User id == $userId");
    // log("token ==  $token");
    // if (token == null || token.isEmpty) {
    //   log("No token found.");
    //   return null;
    // }

    if (userId == null || userId.isEmpty) {
      log('Error: User ID is null or empty');
      FirebaseUtils.showError('User ID is missing');
      return;
    }

    // if (token == null || token.isEmpty) {
    //   log('Error: Token is null or empty');
    //   FirebaseUtils.showError('Authentication token is missing');
    //   return;
    // }

    final url = Uri.parse("https://zrjfashionstyle.com/wp-json/wc/v3/customers/$userId");

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          // 'Authorization': 'Bearer $token',
        },
      );

      log("user details ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        UserModel user = UserModel.fromJson(data);
        // await _saveUserProfile(user);
        FirebaseUtils.showSuccess('User details fetched successfully!');
        log('User details: $user');
      } else if (response.statusCode == 403) {
        FirebaseUtils.showError('Authentication failed: Invalid token');
        log('Error: Invalid token');
      } else {
        FirebaseUtils.showError('Failed to fetch user details');
        log('Error: ${response.body}');
      }
    } catch (e) {
      FirebaseUtils.showError('An error occurred while fetching user details');
      log('Error: $e');
    }
  }
  // fetch user details by token
  Future<String?> getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token");
    print("Retrieved Token: $token");
    return token;
  }
  // get id by extracting user JWT token to
  // Future<UserModel?> fetchUserIdByToken() async {
  //   try {
  //     // Get the JWT token
  //     String? token = await getToken();
  //     if (token == null || token.isEmpty) {
  //       log("No token found.");
  //       return null;
  //     }
  //
  //     log("User JWT Token: $token");
  //
  //     // Decode the JWT token
  //     Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
  //     log("Decoded JWT Token: $decodedToken");
  //
  //     // Extract user ID from nested structure
  //     final userData = decodedToken['data']?['user'];
  //     if (userData == null || !userData.containsKey('id')) {
  //       log("User ID not found in token.");
  //       return null;
  //     }
  //     final userId = userData['id'];
  //     log("Extracted User ID from Token: $userId");
  //
  //     // Save user ID to local storage
  //     final prefs = await SharedPreferences.getInstance();
  //     await prefs.setString('userId', userId.toString());
  //     log("User ID saved to local storage: $userId");
  //
  //     // Fetch user details from the API
  //     final response = await http.get(
  //       Uri.parse('https://zrjfashionstyle.com/wp-json/wp/v2/users/me'),
  //       headers: {
  //         'Authorization': 'Bearer $token',
  //       },
  //     );
  //
  //     log("User API Response: ${response.body}");
  //
  //     if (response.statusCode == 200) {
  //       // Remove the "JWT route is registered" prefix if present
  //       String responseBody = response.body;
  //       if (responseBody.startsWith("JWT route is registered")) {
  //         responseBody = responseBody.replaceFirst("JWT route is registered", "").trim();
  //       }
  //
  //       // Parse the cleaned JSON
  //       final data = jsonDecode(responseBody);
  //       return UserModel.fromJson(data);
  //     } else {
  //       log('Failed to retrieve user details. Status code: ${response.statusCode}');
  //       return null;
  //     }
  //   } catch (e) {
  //     log("Error in fetchUserIdByToken: $e");
  //     return null;
  //   }
  // }
  // get user id extracted from the JWT token
  Future<String?> getUserId() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('userId');
      if (userId != null) {
        log("Retrieved User ID from local storage: $userId");
        return userId;
      } else {
        log("No User ID found in local storage.");
        return null;
      }
    } catch (e) {
      log("Error retrieving User ID: $e");
      return null;
    }
  }
  // Save user details to SharedPreferences
  Future<void> _saveUserDetails(String userEmail, String userNiceName, String userDisplayName, String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_email', userEmail);
    await prefs.setString('token', token);
    await prefs.setString('user_nicename', userNiceName);
    await prefs.setString('user_display_name', userDisplayName);
  }
  // Save user profile to SharedPreferences
  Future<void> _saveUserProfile(UserModel user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('firstName', user.firstName!);
    prefs.setString('lastName', user.lastName!);
    prefs.setString('email', user.email!);
    prefs.setString('avatarUrl', user.avatarUrl!);
    prefs.setString('phone', user.billing!.phone!);
    prefs.setString('address', user.billing!.address1!);
    prefs.setString('city', user.billing!.city!);
    prefs.setString('state', user.billing!.state!);
    prefs.setString('country', user.billing!.country!);

    prefs.setString('shippingAddress', user.shipping!.address1!);
    prefs.setString('shippingCity', user.shipping!.city!);
    prefs.setString('shippingState', user.shipping!.state!);
    prefs.setString('shippingCountry', user.shipping!.country!);
  }
  // Save token in SharedPreferences
  void saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }
  Future<Map<String, String?>> getUserProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return {
      'first_name': prefs.getString('first_name'),
      'last_name': prefs.getString('last_name'),
      'email': prefs.getString('email'),
      'profile_image': prefs.getString('profile_image'),
    };
  }
  // is user authenticated
  Future<bool> isAuthenticated() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    return token != null && token.isNotEmpty;
  }
  // Logout user
  Future<void> logoutUser() async {
    isLoading(true); // Start loading
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear(); // Clear all stored data

      FirebaseUtils.showSuccess('User logged out successfully');
      Get.offAll(() => ScreenLogin());
    } catch (e) {
      FirebaseUtils.showError('An error occurred during logout');
      log('Logout error: $e');
    } finally {
      isLoading(false); // End loading
    }
  }
}
