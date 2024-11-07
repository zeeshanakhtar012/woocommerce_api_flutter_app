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

  void showEmail() {
    print('Entered email: ${email.value.text}');
  }

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
        showEmailConfirmationMessage();
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
  // Show email confirmation message
  void showEmailConfirmationMessage() {
    FirebaseUtils.showSuccess('For password confirmation, an email has been sent to ${email.value.text}. Please create a password and log in to your app.');
  }
  // Sign in user
  Future<void> signInUser() async {
    isLoading(true); // Start loading
    try {
      final url = Uri.parse("https://zrjfashionstyle.com/wp-json/jwt-auth/v1/token");
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': userName.value.text, 'password': password.value.text}),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['token'];
        final userId = data['user_id'];
        _saveToken(token);
        _saveUserId(userId);
        Get.offAll(HomeScreen());
        await fetchAndSaveUserProfile(userId);
      } else {
        FirebaseUtils.showError('Failed to sign in');
        log('Failed to sign in: ${response.body}');
      }
    } catch (e) {
      FirebaseUtils.showError('An error occurred');
      log('Error: $e');
    } finally {
      isLoading(false); // End loading
    }
  }
  // fetch user details cart and wishlist
  Future<void> fetchAndSaveUserProfile(int userId) async {
    final url = Uri.parse("https://zrjfashionstyle.com/wp-json/wc/v3/customers/$userId");
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Basic ${base64Encode(utf8.encode('consumer_key:consumer_secret'))}',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      await _saveUserProfile(
          data['first_name'],
          data['last_name'],
          data['phone'],
          data['address_1'],
          data['email'],
          data['meta_data'].firstWhere((meta) => meta['key'] == 'profile_image', orElse: () => {'value': ''})['value']
      );
      FirebaseUtils.showSuccess('User successfully Logged in!');
    } else {
      print('Failed to fetch user profile: ${response.body}');
      FirebaseUtils.showError('Failed to login. Please try again.');
    }
  }
  // user profile
  Future<void> _saveUserProfile(String firstName, String lastName, String email, String profileImage, String phoneNumber, String address  ) async {
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

  Future<int?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('user_id');
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
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
  // void clearAllFields() {
  //   email.value.clear();
  //   firstName.value.clear();
  //   lastName.value.clear();
  //   phoneNumber.value.clear();
  //   address.value.clear();
  //   country.value.clear();
  //   address.value.clear();
  // }
}
