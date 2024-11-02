import 'dart:developer';

class User {
  int id;
  String fName;
  String? lName;
  String email;
  String? emailVerifiedAt;
  String? address;
  String? city;
  String? country;
  String? phoneNumber;
  String? dob;
  int verified;
  int? otp;
  DateTime createdAt;
  DateTime updatedAt;
  String username;
  String? image;
  String? furtherInformation;
  String? governorate;
  String? locality;
  String? region;
  List<dynamic> orders;
  dynamic cart;
  String? role; // New field for user role

  User({
    required this.id,
    required this.fName,
    this.lName,
    this.dob,
    required this.email,
    this.emailVerifiedAt,
    this.address,
    this.city,
    this.phoneNumber,
    required this.verified,
    this.otp,
    required this.createdAt,
    required this.updatedAt,
    required this.username,
    this.image,
    this.furtherInformation,
    this.governorate,
    this.locality,
    this.region,
    this.country,
    required this.orders,
    this.cart,
    this.role, // Include this in the constructor
  });

  factory User.fromJson(Map<String, dynamic> json) {
    // log('User JSON received: $json');
    final userData = json['user'] ?? {};
    return User(
      id: userData['id'] ?? 0,
      fName: userData['f_name'] ?? '',
      lName: userData['l_name'],
      email: userData['email'] ?? 'No Email',
      emailVerifiedAt: userData['email_verified_at'],
      address: userData['address'],
      city: userData['city'],
      country: userData['country'],
      phoneNumber: userData['phone_number'],
      dob: userData['birth_day'],
      verified: userData['verified'] ?? 0,
      otp: userData['otp'],
      createdAt: userData['created_at'] != null ? DateTime.parse(userData['created_at']) : DateTime.now(),
      updatedAt: userData['updated_at'] != null ? DateTime.parse(userData['updated_at']) : DateTime.now(),
      username: userData['username'] ?? '',
      image: userData['image'],
      furtherInformation: userData['further_information'],
      governorate: userData['governorate'],
      locality: userData['locality'],
      region: userData['region'],
      orders: userData['orders'] != null ? List<dynamic>.from(userData['orders']) : [],
      cart: userData['cart'],
      role: json['role'], // Add this line
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'f_name': fName,
      'l_name': lName,
      'email': email,
      'email_verified_at': emailVerifiedAt,
      'address': address,
      'city': city,
      'country': country,
      'phone_number': phoneNumber,
      'birth_day': dob,
      'verified': verified,
      'otp': otp,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'username': username,
      'image': image,
      'further_information': furtherInformation,
      'governorate': governorate,
      'locality': locality,
      'region': region,
      'orders': orders,
      'cart': cart,
      'role': role, // Add this line
    };
  }
}
