class UserModel {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? avatarUrl;
  final Billing? billing;
  final Shipping? shipping;
  final bool? isPayingCustomer;

  UserModel({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.avatarUrl,
    this.billing,
    this.shipping,
    this.isPayingCustomer,
  });

  // Convert a JSON map to a UserModel
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int? ?? 0,
      firstName: json['first_name'] as String? ?? '',
      lastName: json['last_name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      avatarUrl: json['avatar_url'] as String? ?? '',
      billing: json['billing'] != null ? Billing.fromJson(json['billing']) : null,
      shipping: json['shipping'] != null ? Shipping.fromJson(json['shipping']) : null,
      isPayingCustomer: json['is_paying_customer'] as bool? ?? false,
    );
  }
}

class Billing {
  final String? phone;
  final String? address2;
  final String? address1;
  final String? city;
  final String? state;
  final String? country;

  Billing({
    this.phone,
    this.address2,
    this.address1,
    this.city,
    this.state,
    this.country,
  });

  factory Billing.fromJson(Map<String, dynamic> json) {
    return Billing(
      phone: json['phone'] as String? ?? '',
      address2: json['address_2'] as String? ?? '',
      address1: json['address_1'] as String? ?? '',
      city: json['city'] as String? ?? '',
      state: json['state'] as String? ?? '',
      country: json['country'] as String? ?? '',
    );
  }
}

class Shipping {
  final String? address1;
  final String? city;
  final String? state;
  final String? country;

  Shipping({
    this.address1,
    this.city,
    this.state,
    this.country,
  });

  factory Shipping.fromJson(Map<String, dynamic> json) {
    return Shipping(
      address1: json['address_1'] as String? ?? '',
      city: json['city'] as String? ?? '',
      state: json['state'] as String? ?? '',
      country: json['country'] as String? ?? '',
    );
  }
}
