import 'package:dartz/dartz.dart';

import '../../../core/helpers/enums.dart';
import '../data/models/payment_method_model.dart';
import '../data/models/subscription_model.dart';
import 'payment_repo.dart';

class PaymentRepoImp implements PaymentRepo {
  @override
  Future<Either<StatusRequest, List<PaymentMethodModel>>>
      getPaymentMethods() async {
    try {
      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 500));

      // Return mock data for now
      final paymentMethods = [
        PaymentMethodModel(
          id: '1',
          cardNumber: '**** **** **** 1234',
          cardHolderName: 'John Doe',
          expiryDate: '12/25',
          cvv: '***',
          isDefault: true,
        ),
        PaymentMethodModel(
          id: '2',
          cardNumber: '**** **** **** 5678',
          cardHolderName: 'John Doe',
          expiryDate: '06/24',
          cvv: '***',
          isDefault: false,
        ),
      ];

      return Right(paymentMethods);
    } catch (e) {
      return Left(StatusRequest.serverFailure);
    }
  }

  @override
  Future<Either<StatusRequest, PaymentMethodModel>> addPaymentMethod(
      {required PaymentMethodModel paymentMethod}) async {
    try {
      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 500));

      // Return the same payment method as success
      return Right(paymentMethod);
    } catch (e) {
      return Left(StatusRequest.serverFailure);
    }
  }

  @override
  Future<Either<StatusRequest, bool>> updatePaymentMethod(
      {required PaymentMethodModel paymentMethod}) async {
    try {
      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 500));

      // Return true as success
      return Right(true);
    } catch (e) {
      return Left(StatusRequest.serverFailure);
    }
  }

  @override
  Future<Either<StatusRequest, bool>> deletePaymentMethod(
      {required String paymentMethodId}) async {
    try {
      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 500));

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
        id: '1',
        planName: 'Premium Plan',
        planDescription: 'Full access to all features',
        price: 9.99,
        currency: 'USD',
        billingPeriod: 'monthly',
        startDate: DateTime.now().subtract(const Duration(days: 30)),
        endDate: DateTime.now().add(const Duration(days: 30)),
        isActive: true,
        paymentMethodId: '1',
      );

      return Right(subscription);
    } catch (e) {
      return Left(StatusRequest.serverFailure);
    }
  }

  @override
  Future<Either<StatusRequest, SubscriptionModel>> subscribeToPlan(
      {required String planId, required String paymentMethodId}) async {
    try {
      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 500));

      // Return mock subscription data
      final subscription = SubscriptionModel(
        id: '2',
        planName: 'Premium Plan',
        planDescription: 'Full access to all features',
        price: 9.99,
        currency: 'USD',
        billingPeriod: 'monthly',
        startDate: DateTime.now(),
        endDate: DateTime.now().add(const Duration(days: 30)),
        isActive: true,
        paymentMethodId: paymentMethodId,
      );

      return Right(subscription);
    } catch (e) {
      return Left(StatusRequest.serverFailure);
    }
  }
}
