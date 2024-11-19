class User {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String role;
  final String username;
  final String avatarUrl;
  // final Billing billing;
  // final Shipping shipping;

  User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.role,
    required this.username,
    required this.avatarUrl,
    // required this.billing,
    // required this.shipping,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      role: json['role'],
      username: json['username'],
      avatarUrl: json['avatar_url'],
      // billing: Billing.fromJson(json['billing']),
      // shipping: Shipping.fromJson(json['shipping']),
    );
  }
}

// class Billing {
//   final String address1;
//   final String address2;
//   final String city;
//   final String postcode;
//   final String country;
//   final String state;
//   final String phone;
//
//   Billing({
//     required this.address1,
//     required this.address2,
//     required this.city,
//     required this.postcode,
//     required this.country,
//     required this.state,
//     required this.phone,
//   });
//
//   factory Billing.fromJson(Map<String, dynamic> json) {
//     return Billing(
//       address1: json['address_1'],
//       address2: json['address_2'],
//       city: json['city'],
//       postcode: json['postcode'],
//       country: json['country'],
//       state: json['state'],
//       phone: json['phone'],
//     );
//   }
// }
//
// class Shipping {
//   final String address1;
//   final String address2;
//   final String city;
//   final String postcode;
//   final String country;
//   final String state;
//   final String phone;
//
//   Shipping({
//     required this.address1,
//     required this.address2,
//     required this.city,
//     required this.postcode,
//     required this.country,
//     required this.state,
//     required this.phone,
//   });
//
//   factory Shipping.fromJson(Map<String, dynamic> json) {
//     return Shipping(
//       address1: json['address_1'],
//       address2: json['address_2'],
//       city: json['city'],
//       postcode: json['postcode'],
//       country: json['country'],
//       state: json['state'],
//       phone: json['phone'],
//     );
//   }
// }
