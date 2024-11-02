class Order {
  String? status;
  String? message;
  Data? data;

  Order({this.status, this.message, this.data});

  Order.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? fName;
  String? lName;
  String? orderEmail;
  String? phone;

  double? totalPrice;
  String? status;
  String? updatedAt;
  String? createdAt;
  int? id;

  String? paymentMethod;

  Data({
    this.fName,
    this.lName,
    this.orderEmail,
    this.phone,
    this.totalPrice,
    this.status,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.paymentMethod,
  });

  Data.fromJson(Map<String, dynamic> json) {
    fName = json['f_name'];
    lName = json['l_name'];
    orderEmail = json['order_email'];
    phone = json['phone'];

    totalPrice = json['total_price'] != null
        ? (json['total_price'] as num).toDouble()
        : null;

    status = json['status'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];

    paymentMethod = json['payment_method'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['f_name'] = this.fName;
    data['l_name'] = this.lName;
    data['order_email'] = this.orderEmail;
    data['phone'] = this.phone;
    data['total_price'] = this.totalPrice;
    data['status'] = this.status;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    data['payment_method'] = this.paymentMethod;
    return data;
  }
}
