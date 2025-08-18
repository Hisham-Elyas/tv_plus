class SubscriptionModel {
  final String id;
  final String planName;
  final String planDescription;
  final double price;
  final String currency;
  final String billingPeriod;
  final DateTime startDate;
  final DateTime endDate;
  final bool isActive;
  final String paymentMethodId;

  SubscriptionModel({
    required this.id,
    required this.planName,
    required this.planDescription,
    required this.price,
    required this.currency,
    required this.billingPeriod,
    required this.startDate,
    required this.endDate,
    required this.isActive,
    required this.paymentMethodId,
  });

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionModel(
      id: json['id'] as String,
      planName: json['planName'] as String,
      planDescription: json['planDescription'] as String,
      price: (json['price'] as num).toDouble(),
      currency: json['currency'] as String,
      billingPeriod: json['billingPeriod'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      isActive: json['isActive'] as bool,
      paymentMethodId: json['paymentMethodId'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'planName': planName,
      'planDescription': planDescription,
      'price': price,
      'currency': currency,
      'billingPeriod': billingPeriod,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'isActive': isActive,
      'paymentMethodId': paymentMethodId,
    };
  }

  SubscriptionModel copyWith({
    String? id,
    String? planName,
    String? planDescription,
    double? price,
    String? currency,
    String? billingPeriod,
    DateTime? startDate,
    DateTime? endDate,
    bool? isActive,
    String? paymentMethodId,
  }) {
    return SubscriptionModel(
      id: id ?? this.id,
      planName: planName ?? this.planName,
      planDescription: planDescription ?? this.planDescription,
      price: price ?? this.price,
      currency: currency ?? this.currency,
      billingPeriod: billingPeriod ?? this.billingPeriod,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isActive: isActive ?? this.isActive,
      paymentMethodId: paymentMethodId ?? this.paymentMethodId,
    );
  }

  // Helper method to check if subscription is expired
  bool get isExpired {
    return DateTime.now().isAfter(endDate);
  }

  // Helper method to get days remaining in subscription
  int get daysRemaining {
    final difference = endDate.difference(DateTime.now());
    return difference.inDays > 0 ? difference.inDays : 0;
  }
}
