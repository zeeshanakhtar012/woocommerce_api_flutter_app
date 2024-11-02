class CardInfo {
  int id;
  int userId;
  String accountName;
  String bank;
  String accountNumber;
  String expiryDate;
  String createdAt;
  String updatedAt;

  CardInfo({
    required this.id,
    required this.userId,
    required this.accountName,
    required this.bank,
    required this.accountNumber,
    required this.expiryDate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CardInfo.fromJson(Map<String, dynamic> json) {
    return CardInfo(
      id: json['id'],
      userId: json['user_id'],
      accountName: json['account_name'],
      bank: json['bank'],
      accountNumber: json['account_number'],
      expiryDate: json['expiry_date'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'account_name': accountName,
      'bank': bank,
      'account_number': accountNumber,
      'expiry_date': expiryDate,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
