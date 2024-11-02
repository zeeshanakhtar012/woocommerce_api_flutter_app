import 'package:zrj/model/product.dart';

class OrderResponse {
  final String? status;
  final List<Order> orders;

  OrderResponse({this.status, required this.orders});

  factory OrderResponse.fromJson(Map<String, dynamic> json) {
    return OrderResponse(
      status: json['status'] as String?,
      orders: (json['orders'] as List<dynamic>?)
              ?.map((e) =>
                  e == null ? null : Order.fromJson(e as Map<String, dynamic>))
              .whereType<Order>() // Filter out any null values
              .toList() ??
          [],
    );
  }
}



class SingleOrderResponse {
  final String? status;
  final Order? order; // Change from List<Order> to a single Order object

  SingleOrderResponse({this.status, this.order});

  factory SingleOrderResponse.fromJson(Map<String, dynamic> json) {
    return SingleOrderResponse(
      status: json['status'] as String?,
      order: json['order'] != null ? Order.fromJson(json['order']) : null, 
    );
  }
}



class Order {
  final int? id;
  final int? userId;
  final String? totalPrice;
  final String? discount;
  final String? status;
  final String? createdAt;
  final String? updatedAt;
  final int? quantity;
  final String? paymentMethod;
  final int? onCash;
  final int? designerId;
  final int? isGuest;
  final String? guestName;
  final String? guestLName;
  final String? guestEmail;
  final String? guestPhone;
  final String? guestAddress;
  final String? phone;
  final String? fName;
  final String? lName;
  final String? orderEmail;
  final List<Product>? products;
  final dynamic payment;
  final Shipment? shipment;

  Order({
    this.id,
    this.userId,
    this.totalPrice,
    this.discount,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.quantity,
    this.paymentMethod,
    this.onCash,
    this.designerId,
    this.isGuest,
    this.guestName,
    this.guestLName,
    this.guestEmail,
    this.guestPhone,
    this.guestAddress,
    this.phone,
    this.fName,
    this.lName,
    this.orderEmail,
    this.products,
    this.payment,
    this.shipment,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] as int?,
      userId: json['user_id'] as int?,
      totalPrice: json['total_price'] as String?,
      discount: json['discount'] as String?,
      status: json['status'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      quantity: json['quantity'] as int?,
      paymentMethod: json['payment_method'] as String?,
      onCash: json['on_cash'] as int?,
      designerId: json['designer_id'] as int?,
      isGuest: json['is_guest'] as int?,
      guestName: json['guest_name'] as String?,
      guestLName: json['guest_l_name'] as String?,
      guestEmail: json['guest_email'] as String?,
      guestPhone: json['guest_phone'] as String?,
      guestAddress: json['guest_address'] as String?,
      phone: json['phone'] as String?,
      fName: json['f_name'] as String?,
      lName: json['l_name'] as String?,
      orderEmail: json['order_email'] as String?,
      // products: json['products'] as List<dynamic>?,
      products:
          json['products'] != null  ? List<Product>.from(json['products'].map((x) => Product.fromJson(x))):[],

      // json['products'] != null ? Product.fromJson(json['products']) : [],
      payment: json['payment'],
      shipment:
          json['shipment'] != null ? Shipment.fromJson(json['shipment']) : null,
    );
  }
}

class Shipment {
  final int? id;
  final int? orderId;
  final String? trackingNumber;
  final String? carrier;
  final String? createdAt;
  final String? updatedAt;
  final String? name;
  final String? streetAddress;
  final String? streetAddressLine2;
  final String? city;
  final String? stateOrProvince;
  final String? paidStatus;
  final String? deliveryStatus;
  final String? fName;
  final String? lName;
  final String? apartmentFloor;

  Shipment({
    this.id,
    this.orderId,
    this.trackingNumber,
    this.carrier,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.streetAddress,
    this.streetAddressLine2,
    this.city,
    this.stateOrProvince,
    this.paidStatus,
    this.deliveryStatus,
    this.fName,
    this.lName,
    this.apartmentFloor,
  });

  factory Shipment.fromJson(Map<String, dynamic> json) {
    return Shipment(
      id: json['id'] as int?,
      orderId: json['order_id'] as int?,
      trackingNumber: json['tracking_number'] as String?,
      carrier: json['carrier'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      name: json['name'] as String?,
      streetAddress: json['street_address'] as String?,
      streetAddressLine2: json['street_address_line_2'] as String?,
      city: json['city'] as String?,
      stateOrProvince: json['state_or_province'] as String?,
      paidStatus: json['paid_status'] as String?,
      deliveryStatus: json['delivery_status'] as String?,
      fName: json['f_name'] as String?,
      lName: json['l_name'] as String?,
      apartmentFloor: json['apartment_floor'] as String?,
    );
  }
}
