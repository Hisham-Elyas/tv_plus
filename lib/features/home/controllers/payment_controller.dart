// ignore_for_file: strict_top_level_inference, avoid_print

import 'package:get/get.dart';

import '../../../core/helpers/coustom_overlay.dart';
import '../../../core/helpers/enums.dart';
import '../../../core/widgets/custom_snackbar.dart';
import '../data/models/payment_method_model.dart';
import '../data/models/subscription_model.dart';
import '../repos/payment_repo_imp.dart';

class PaymentController extends GetxController {
  late PaymentRepoImp paymentRepo;

  var paymentMethods = <PaymentMethodModel>[].obs;
  var currentSubscription = Rx<SubscriptionModel?>(null);

  var paymentMethodsStatus = StatusRequest.loading.obs;
  var subscriptionStatus = StatusRequest.loading.obs;

  @override
  void onInit() {
    paymentRepo = PaymentRepoImp();
    getPaymentMethods();
    getCurrentSubscription();
    super.onInit();
  }

  // Get all payment methods
  Future<void> getPaymentMethods() async {
    try {
      paymentMethodsStatus.value = StatusRequest.loading;
      update();

      final result = await paymentRepo.getPaymentMethods();
      result.fold(
        (l) {
          paymentMethodsStatus.value = l;
          update();
        },
        (r) {
          paymentMethods.assignAll(r);
          paymentMethodsStatus.value = StatusRequest.success;
          update();
        },
      );
    } catch (e) {
      paymentMethodsStatus.value = StatusRequest.serverFailure;
      update();
      print("Error in getPaymentMethods: $e");
    }
  }

  // Add a new payment method
  Future<void> addPaymentMethod(
      {required PaymentMethodModel paymentMethod}) async {
    showOverlay(
      asyncFunction: () async {
        try {
          final result =
              await paymentRepo.addPaymentMethod(paymentMethod: paymentMethod);
          result.fold(
            (l) {
              showCustomSnackBar(
                message: "Failed to add payment method",
                title: "",
                isError: true,
              );
            },
            (r) {
              paymentMethods.add(r);
              showCustomSnackBar(
                message: "Payment method added successfully",
                title: "",
                isError: false,
              );
              update();
            },
          );
        } catch (e) {
          showCustomSnackBar(
            message: e.toString(),
            title: "",
            isError: true,
          );
        }
      },
    );
  }

  // Update a payment method
  Future<void> updatePaymentMethod(
      {required PaymentMethodModel paymentMethod}) async {
    showOverlay(
      asyncFunction: () async {
        try {
          final result = await paymentRepo.updatePaymentMethod(
              paymentMethod: paymentMethod);
          result.fold(
            (l) {
              showCustomSnackBar(
                message: "Failed to update payment method",
                title: "",
                isError: true,
              );
            },
            (r) {
              if (r) {
                // Update the payment method in the list
                final index = paymentMethods
                    .indexWhere((element) => element.id == paymentMethod.id);
                if (index != -1) {
                  paymentMethods[index] = paymentMethod;
                }
                showCustomSnackBar(
                  message: "Payment method updated successfully",
                  title: "",
                  isError: false,
                );
                update();
              } else {
                showCustomSnackBar(
                  message: "Failed to update payment method",
                  title: "",
                  isError: true,
                );
              }
            },
          );
        } catch (e) {
          showCustomSnackBar(
            message: e.toString(),
            title: "",
            isError: true,
          );
        }
      },
    );
  }

  // Delete a payment method
  Future<void> deletePaymentMethod({required String paymentMethodId}) async {
    showOverlay(
      asyncFunction: () async {
        try {
          final result = await paymentRepo.deletePaymentMethod(
              paymentMethodId: paymentMethodId);
          result.fold(
            (l) {
              showCustomSnackBar(
                message: "Failed to delete payment method",
                title: "",
                isError: true,
              );
            },
            (r) {
              if (r) {
                // Remove the payment method from the list
                paymentMethods
                    .removeWhere((element) => element.id == paymentMethodId);
                showCustomSnackBar(
                  message: "Payment method deleted successfully",
                  title: "",
                  isError: false,
                );
                update();
              } else {
                showCustomSnackBar(
                  message: "Failed to delete payment method",
                  title: "",
                  isError: true,
                );
              }
            },
          );
        } catch (e) {
          showCustomSnackBar(
            message: e.toString(),
            title: "",
            isError: true,
          );
        }
      },
    );
  }

  // Get current subscription
  Future<void> getCurrentSubscription() async {
    try {
      subscriptionStatus.value = StatusRequest.loading;
      update();

      final result = await paymentRepo.getCurrentSubscription();
      result.fold(
        (l) {
          subscriptionStatus.value = l;
          update();
        },
        (r) {
          currentSubscription.value = r;
          subscriptionStatus.value = StatusRequest.success;
          update();
        },
      );
    } catch (e) {
      subscriptionStatus.value = StatusRequest.serverFailure;
      update();
      print("Error in getCurrentSubscription: $e");
    }
  }

  // Subscribe to a plan
  Future<void> subscribeToPlan(
      {required String planId, required String paymentMethodId}) async {
    showOverlay(
      asyncFunction: () async {
        try {
          final result = await paymentRepo.subscribeToPlan(
              planId: planId, paymentMethodId: paymentMethodId);
          result.fold(
            (l) {
              showCustomSnackBar(
                message: "Failed to subscribe to plan",
                title: "",
                isError: true,
              );
            },
            (r) {
              currentSubscription.value = r;
              showCustomSnackBar(
                message: "Successfully subscribed to ${r.planName}",
                title: "",
                isError: false,
              );
              update();
            },
          );
        } catch (e) {
          showCustomSnackBar(
            message: e.toString(),
            title: "",
            isError: true,
          );
        }
      },
    );
  }

  // Set a payment method as default
  void setDefaultPaymentMethod(String paymentMethodId) {
    // Set all payment methods as non-default first
    for (var i = 0; i < paymentMethods.length; i++) {
      paymentMethods[i] = paymentMethods[i].copyWith(isDefault: false);
    }

    // Set the selected payment method as default
    final index =
        paymentMethods.indexWhere((element) => element.id == paymentMethodId);
    if (index != -1) {
      paymentMethods[index] = paymentMethods[index].copyWith(isDefault: true);
    }

    update();
  }
}
