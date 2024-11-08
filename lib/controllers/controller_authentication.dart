import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/firebase_utils.dart';
import '../utils/wordpress_endpoints.dart';
import '../views/home/home_screen.dart';
import '../views/screens/authentication_screens/screen_login.dart';

class ControllerAuthentication extends GetxController {
  var email = TextEditingController().obs;
  var isLoading = false.obs;
  var firstName = TextEditingController().obs;
  var lastName = TextEditingController().obs;
  var userName = TextEditingController().obs;
  var country = TextEditingController().obs;
  var password = TextEditingController().obs;
  var phoneNumber = TextEditingController().obs;
  var address = TextEditingController().obs;
  final Map<String, String> billing = {};
  final Map<String, String> shipping = {};
  var userId = ''.obs;

  final String consumerKey = ConsumerId.consumerKey;
  final String consumerSecret = ConsumerId.consumerSecret;

  // Signup user
  Future<void> signupUser() async {
    isLoading(true); // Start loading
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
          'billing': {
            'phone': phoneNumber.value.text,
            'address_1': address.value.text,
          },
          'shipping': {
            'address_1': address.value.text,
            'country': country.value.text,
          },
          'meta_data': [
            {'key': 'profile_image', 'value': 'https://example.com/image.jpg'},
          ],
        }),
      );
      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        final userId = data['id'];
        FirebaseUtils.showSuccess('User created successfully');
        log('User created: $userId');
        _saveUserId(userId);
        Get.offAll(ScreenLogin());
      } else {
        FirebaseUtils.showError('Failed to create user');
        log('Failed to create user: ${response.body}');
      }
    } catch (e) {
      FirebaseUtils.showError('An error occurred');
      log('Error: $e');
    } finally {
      isLoading(false); // End loading
    }
  }
  // Sign in user
  Future<void> signInUser() async {
    isLoading(true); // Start loading
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

      // Log response details
      log('Response status: ${response.statusCode}');
      log('Response headers: ${response.headers}');
      log('Response body: ${response.body}');

      if (response.statusCode == 200) {
        try {
          // Strip off the non-JSON prefix from the response body
          final jsonString = response.body.replaceFirst(RegExp(r'^.*?{'), '{');

          // Parse JSON response
          final data = jsonDecode(jsonString);

          // Access token from response
          final token = data['token'];
          final userEmail = data['user_email'];
          final userNicename = data['user_nicename'];
          final userDisplayName = data['user_display_name'];

          // Check if token is valid
          if (token != null) {
            _saveToken(token); // Save the token
            _saveUserDetails(userEmail, userNicename, userDisplayName); // Save user details

            // Navigate to HomeScreen
            Get.offAll(() => HomeScreen()); // Using the lambda function to navigate
          } else {
            log('Error: Missing token in the response');
            FirebaseUtils.showError('Login failed: Token not found.');
          }
        } catch (jsonError) {
          // Log JSON parsing errors
          log('JSON decoding error: $jsonError');
          FirebaseUtils.showError('Unexpected response format.');
        }
      } else {
        // Handle non-200 status codes
        FirebaseUtils.showError('Failed to sign in');
        log('Failed to sign in: ${response.body}');
      }
    } catch (e) {
      // Log any other errors during request
      FirebaseUtils.showError('An error occurred');
      log('Error: $e');
    } finally {
      isLoading(false); // End loading
    }
  }

// Save user details to shared preferences
  Future<void> _saveUserDetails(String userEmail, String userNicename, String userDisplayName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_email', userEmail);
    await prefs.setString('user_nicename', userNicename);
    await prefs.setString('user_display_name', userDisplayName);
  }


  // Fetch user details using email (or other identifier)
  Future<void> fetchUserDetails(String email) async {
    final url = Uri.parse("https://zrjfashionstyle.com/wp-json/wc/v3/customers?email=$email");
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Basic ${base64Encode(utf8.encode('$consumerKey:$consumerSecret'))}',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)[0]; // Assuming the first result is the correct one
      await _saveUserProfile(
          data['first_name'],
          data['last_name'],
          data['email'],
          data['phone'],
          data['billing']['address_1'],
          data['meta_data'].firstWhere((meta) => meta['key'] == 'profile_image', orElse: () => {'value': ''})['value']
      );
      FirebaseUtils.showSuccess('User successfully Logged in!');
    } else {
      FirebaseUtils.showError('Failed to fetch user profile.');
    }
  }

  // Save user profile
  Future<void> _saveUserProfile(String firstName, String lastName, String email, String phoneNumber, String address, String profileImage) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('first_name', firstName);
    await prefs.setString('last_name', lastName);
    await prefs.setString('email', email);
    await prefs.setString('phone', phoneNumber);
    await prefs.setString('address_1', address);
    await prefs.setString('profile_image', profileImage); // Save profile image if available
  }

  void _saveUserId(int userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('user_id', userId);
  }

  void _saveToken(String token) async {
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
}
