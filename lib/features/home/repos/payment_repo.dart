import 'package:dartz/dartz.dart';

import '../../../core/helpers/enums.dart';
import '../data/models/payment_method_model.dart';
import '../data/models/subscription_model.dart';

abstract class PaymentRepo {
  Future<Either<StatusRequest, List<PaymentMethodModel>>> getPaymentMethods();
  Future<Either<StatusRequest, PaymentMethodModel>> addPaymentMethod(
      {required PaymentMethodModel paymentMethod});
  Future<Either<StatusRequest, bool>> updatePaymentMethod(
      {required PaymentMethodModel paymentMethod});
  Future<Either<StatusRequest, bool>> deletePaymentMethod(
      {required String paymentMethodId});
  Future<Either<StatusRequest, SubscriptionModel>> getCurrentSubscription();
  Future<Either<StatusRequest, SubscriptionModel>> subscribeToPlan(
      {required String planId, required String paymentMethodId});
}
