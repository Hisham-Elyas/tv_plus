import 'dart:convert';

import 'package:crypto/crypto.dart';

import '../../../../core/helpers/secure_storage_helper.dart';

class PaymentMethodModel {
  final String id;
  final String cardNumber; // This will be masked for security
  final String lastFourDigits; // Last 4 digits for display
  final String cardHolderName;
  final String expiryDate;
  final String cvv; // This will be masked for security
  final bool isDefault;
  final String cardType; // Visa, Mastercard, etc.

  PaymentMethodModel({
    required this.id,
    required this.cardNumber,
    required this.lastFourDigits,
    required this.cardHolderName,
    required this.expiryDate,
    required this.cvv,
    required this.isDefault,
    required this.cardType,
  });

  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) {
    return PaymentMethodModel(
      id: json['id'] as String,
      cardNumber: json['cardNumber'] as String,
      lastFourDigits: json['lastFourDigits'] as String,
      cardHolderName: json['cardHolderName'] as String,
      expiryDate: json['expiryDate'] as String,
      cvv: json['cvv'] as String,
      isDefault: json['isDefault'] as bool,
      cardType: json['cardType'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cardNumber': cardNumber,
      'lastFourDigits': lastFourDigits,
      'cardHolderName': cardHolderName,
      'expiryDate': expiryDate,
      'cvv': cvv,
      'isDefault': isDefault,
      'cardType': cardType,
    };
  }

  PaymentMethodModel copyWith({
    String? id,
    String? cardNumber,
    String? lastFourDigits,
    String? cardHolderName,
    String? expiryDate,
    String? cvv,
    bool? isDefault,
    String? cardType,
  }) {
    return PaymentMethodModel(
      id: id ?? this.id,
      cardNumber: cardNumber ?? this.cardNumber,
      lastFourDigits: lastFourDigits ?? this.lastFourDigits,
      cardHolderName: cardHolderName ?? this.cardHolderName,
      expiryDate: expiryDate ?? this.expiryDate,
      cvv: cvv ?? this.cvv,
      isDefault: isDefault ?? this.isDefault,
      cardType: cardType ?? this.cardType,
    );
  }

  // Helper method to determine card type from card number
  static String getCardType(String cardNumber) {
    if (cardNumber.startsWith(RegExp(r'4'))) {
      return 'Visa';
    } else if (cardNumber.startsWith(RegExp(r'5[1-5]'))) {
      return 'Mastercard';
    } else if (cardNumber.startsWith(RegExp(r'3[47]'))) {
      return 'American Express';
    } else if (cardNumber.startsWith(RegExp(r'6(?:011|5)'))) {
      return 'Discover';
    } else {
      return 'Unknown';
    }
  }

  // Helper method to mask card number (show only last 4 digits)
  static String maskCardNumber(String cardNumber) {
    if (cardNumber.length < 4) return cardNumber;
    return '**** **** **** ${cardNumber.substring(cardNumber.length - 4)}';
  }

  // Helper method to mask CVV
  static String maskCvv(String cvv) {
    return '*' * cvv.length;
  }

  // Helper method to create a secure payment method from sensitive data
  static PaymentMethodModel createSecurePaymentMethod({
    required String id,
    required String fullCardNumber,
    required String cardHolderName,
    required String expiryDate,
    required String fullCvv,
    required bool isDefault,
  }) {
    final lastFour = fullCardNumber.substring(fullCardNumber.length - 4);
    final cardType = getCardType(fullCardNumber);

    // Store sensitive data securely
    SecureStorageHelper.storePaymentMethod(
      paymentMethodId: id,
      fullCardNumber: fullCardNumber,
      fullCvv: fullCvv,
    );

    return PaymentMethodModel(
      id: id,
      cardNumber: maskCardNumber(fullCardNumber),
      lastFourDigits: lastFour,
      cardHolderName: cardHolderName,
      expiryDate: expiryDate,
      cvv: maskCvv(fullCvv),
      isDefault: isDefault,
      cardType: cardType,
    );
  }

  // Helper method to retrieve full card number securely
  Future<String?> getFullCardNumber() async {
    final data = await SecureStorageHelper.retrievePaymentMethod(
      paymentMethodId: id,
    );
    return data['fullCardNumber'];
  }

  // Helper method to retrieve full CVV securely
  Future<String?> getFullCvv() async {
    final data = await SecureStorageHelper.retrievePaymentMethod(
      paymentMethodId: id,
    );
    return data['fullCvv'];
  }

  // Helper method to delete secure payment method data
  Future<void> deleteSecureData() async {
    await SecureStorageHelper.deletePaymentMethod(
      paymentMethodId: id,
    );
  }

  // Helper method to generate a secure hash for the payment method
  String generateHash() {
    final data = '$id$cardNumber$cardHolderName$expiryDate';
    final bytes = utf8.encode(data);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}
