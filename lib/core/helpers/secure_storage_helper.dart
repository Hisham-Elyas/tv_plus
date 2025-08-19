import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageHelper {
  static const _storage = FlutterSecureStorage();

  // Write a key-value pair to secure storage
  static Future<void> writeSecureData(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  // Read a value from secure storage by key
  static Future<String?> readSecureData(String key) async {
    return await _storage.read(key: key);
  }

  // Delete a key-value pair from secure storage
  static Future<void> deleteSecureData(String key) async {
    await _storage.delete(key: key);
  }

  // Delete all key-value pairs from secure storage
  static Future<void> deleteAllSecureData() async {
    await _storage.deleteAll();
  }

  // Check if a key exists in secure storage
  static Future<bool> containsKey(String key) async {
    return await _storage.containsKey(key: key);
  }

  // Store payment method securely
  static Future<void> storePaymentMethod({
    required String paymentMethodId,
    required String fullCardNumber,
    required String fullCvv,
  }) async {
    // Store the full card number with a unique key
    await writeSecureData('card_number_$paymentMethodId', fullCardNumber);
    
    // Store the full CVV with a unique key
    await writeSecureData('cvv_$paymentMethodId', fullCvv);
  }

  // Retrieve payment method securely
  static Future<Map<String, String?>> retrievePaymentMethod({
    required String paymentMethodId,
  }) async {
    final fullCardNumber = await readSecureData('card_number_$paymentMethodId');
    final fullCvv = await readSecureData('cvv_$paymentMethodId');
    
    return {
      'fullCardNumber': fullCardNumber,
      'fullCvv': fullCvv,
    };
  }

  // Delete payment method securely
  static Future<void> deletePaymentMethod({
    required String paymentMethodId,
  }) async {
    await deleteSecureData('card_number_$paymentMethodId');
    await deleteSecureData('cvv_$paymentMethodId');
  }
}