import 'package:dartz/dartz.dart';

import '../../../core/helpers/enums.dart';
import '../../../core/helpers/secure_storage_helper.dart';
import '../data/models/payment_method_model.dart';
import '../data/models/subscription_model.dart';
import 'payment_repo.dart';

class PaymentRepoImp implements PaymentRepo {
  // Mock data for payment methods
  static final List<Map<String, dynamic>> _mockPaymentMethods = [
    {
      'id': '1',
      'fullCardNumber': '4111111111111111',
      'cardHolderName': 'John Doe',
      'expiryDate': '12/25',
      'fullCvv': '123',
      'isDefault': true,
    },
    {
      'id': '2',
      'fullCardNumber': '5555555555554444',
      'cardHolderName': 'Jane Smith',
      'expiryDate': '06/24',
      'fullCvv': '456',
      'isDefault': false,
    },
    {
      'id': '3',
      'fullCardNumber': '378282246310005',
      'cardHolderName': 'Robert Johnson',
      'expiryDate': '09/26',
      'fullCvv': '7890',
      'isDefault': false,
    },
  ];

  // Mock data for subscriptions
  static final Map<String, dynamic> _mockSubscription = {
    'id': '1',
    'planName': 'Premium Plan',
    'planDescription': 'Full access to all features',
    'price': 9.99,
    'currency': 'USD',
    'billingPeriod': 'monthly',
    'startDate': DateTime.now().subtract(const Duration(days: 30)),
    'endDate': DateTime.now().add(const Duration(days: 30)),
    'isActive': true,
    'paymentMethodId': '1',
  };

  @override
  Future<Either<StatusRequest, List<PaymentMethodModel>>>
      getPaymentMethods() async {
    try {
      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 500));

      // Return mock data for now
      final paymentMethods = _mockPaymentMethods
          .map((data) => PaymentMethodModel.createSecurePaymentMethod(
                id: data['id'],
                fullCardNumber: data['fullCardNumber'],
                cardHolderName: data['cardHolderName'],
                expiryDate: data['expiryDate'],
                fullCvv: data['fullCvv'],
                isDefault: data['isDefault'],
              ))
          .toList();

      return Right(paymentMethods);
    } catch (e) {
      return Left(StatusRequest.serverFailure);
    }
  }

  @override
  Future<Either<StatusRequest, PaymentMethodModel>> addPaymentMethod({
    required PaymentMethodModel paymentMethod,
  }) async {
    try {
      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 500));

      // Add to mock data
      _mockPaymentMethods.add({
        'id': paymentMethod.id,
        'fullCardNumber': await paymentMethod.getFullCardNumber() ?? '',
        'cardHolderName': paymentMethod.cardHolderName,
        'expiryDate': paymentMethod.expiryDate,
        'fullCvv': await paymentMethod.getFullCvv() ?? '',
        'isDefault': paymentMethod.isDefault,
      });

      // Return the same payment method as success
      return Right(paymentMethod);
    } catch (e) {
      return Left(StatusRequest.serverFailure);
    }
  }

  @override
  Future<Either<StatusRequest, bool>> updatePaymentMethod({
    required PaymentMethodModel paymentMethod,
  }) async {
    try {
      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 500));

      // Update in mock data
      final index =
          _mockPaymentMethods.indexWhere((pm) => pm['id'] == paymentMethod.id);
      if (index != -1) {
        _mockPaymentMethods[index] = {
          'id': paymentMethod.id,
          'fullCardNumber': await paymentMethod.getFullCardNumber() ?? '',
          'cardHolderName': paymentMethod.cardHolderName,
          'expiryDate': paymentMethod.expiryDate,
          'fullCvv': await paymentMethod.getFullCvv() ?? '',
          'isDefault': paymentMethod.isDefault,
        };
        return Right(true);
      }

      // Return false if not found
      return Right(false);
    } catch (e) {
      return Left(StatusRequest.serverFailure);
    }
  }

  @override
  Future<Either<StatusRequest, bool>> deletePaymentMethod({
    required String paymentMethodId,
  }) async {
    try {
      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 500));

      // Remove from mock data
      _mockPaymentMethods.removeWhere((pm) => pm['id'] == paymentMethodId);

      // Delete secure data directly using the helper
      await SecureStorageHelper.deletePaymentMethod(
        paymentMethodId: paymentMethodId,
      );

      // Return true as success
      return Right(true);
    } catch (e) {
      return Left(StatusRequest.serverFailure);
    }
  }

  @override
  Future<Either<StatusRequest, SubscriptionModel>>
      getCurrentSubscription() async {
    try {
      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 500));

      // Return mock subscription data
      final subscription = SubscriptionModel(
        id: _mockSubscription['id'],
        planName: _mockSubscription['planName'],
        planDescription: _mockSubscription['planDescription'],
        price: _mockSubscription['price'],
        currency: _mockSubscription['currency'],
        billingPeriod: _mockSubscription['billingPeriod'],
        startDate: _mockSubscription['startDate'],
        endDate: _mockSubscription['endDate'],
        isActive: _mockSubscription['isActive'],
        paymentMethodId: _mockSubscription['paymentMethodId'],
      );

      return Right(subscription);
    } catch (e) {
      return Left(StatusRequest.serverFailure);
    }
  }

  @override
  Future<Either<StatusRequest, SubscriptionModel>> subscribeToPlan({
    required String planId,
    required String paymentMethodId,
  }) async {
    try {
      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 500));

      // Update mock subscription data
      _mockSubscription['id'] = '2';
      _mockSubscription['startDate'] = DateTime.now();
      _mockSubscription['endDate'] =
          DateTime.now().add(const Duration(days: 30));
      _mockSubscription['isActive'] = true;
      _mockSubscription['paymentMethodId'] = paymentMethodId;

      // Return mock subscription data
      final subscription = SubscriptionModel(
        id: _mockSubscription['id'],
        planName: _mockSubscription['planName'],
        planDescription: _mockSubscription['planDescription'],
        price: _mockSubscription['price'],
        currency: _mockSubscription['currency'],
        billingPeriod: _mockSubscription['billingPeriod'],
        startDate: _mockSubscription['startDate'],
        endDate: _mockSubscription['endDate'],
        isActive: _mockSubscription['isActive'],
        paymentMethodId: _mockSubscription['paymentMethodId'],
      );

      return Right(subscription);
    } catch (e) {
      return Left(StatusRequest.serverFailure);
    }
  }
}
