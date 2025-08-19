// ignore_for_file: strict_top_level_inference, avoid_print

import 'package:get/get.dart';

import '../../../core/helpers/coustom_overlay.dart';
import '../../../core/helpers/enums.dart';
import '../../../core/widgets/custom_snackbar.dart';
import '../data/models/payment_method_model.dart';
import '../data/models/subscription_model.dart';
import '../repos/payment_repo_imp.dart';

/// A controller for managing payment methods and subscriptions in the app.
///
/// This controller provides functionality for:
/// - Managing payment methods (CRUD operations)
/// - Handling subscriptions
/// - Validating payment information
/// - Setting default payment methods
///
/// The controller uses [PaymentRepoImp] to interact with the data layer and
/// provides reactive state management for payment-related data.
class PaymentController extends GetxController {
  late PaymentRepoImp paymentRepo;
  bool _isInitialized = false;

  var paymentMethods = <PaymentMethodModel>[].obs;
  var currentSubscription = Rx<SubscriptionModel?>(null);

  var paymentMethodsStatus = StatusRequest.loading.obs;
  var subscriptionStatus = StatusRequest.loading.obs;

  @override
  void onInit() {
    _initializeController();
    super.onInit();
  }

  /// Initializes the controller and loads initial data
  ///
  /// This method performs the following steps:
  /// 1. Initializes the payment repository
  /// 2. Loads payment methods and subscription information
  /// 3. Sets the initialization flag to true
  /// 4. Shows error messages if initialization fails
  Future<void> _initializeController() async {
    try {
      paymentRepo = PaymentRepoImp();
      _isInitialized = true;

      // Load payment methods and subscription info
      await Future.wait([
        getPaymentMethods(),
        getCurrentSubscription(),
      ]);
    } catch (e) {
      print("Error initializing PaymentController: $e");
      showCustomSnackBar(
        message: "Failed to initialize payment system: ${e.toString()}",
        title: "",
        isError: true,
      );
    }
  }

  // Check if the controller is properly initialized
  bool get isInitialized => _isInitialized;

  /// List of all payment methods for the current user
  List<PaymentMethodModel> get allPaymentMethods => paymentMethods;

  /// The default payment method for the current user
  PaymentMethodModel? get defaultPaymentMethod =>
      paymentMethods.firstWhereOrNull((method) => method.isDefault);

  /// Whether there are any payment methods
  bool get hasPaymentMethods => paymentMethods.isNotEmpty;

  /// Whether there is an active subscription
  bool get hasActiveSubscription =>
      currentSubscription.value?.isActive ?? false;

  /// Validates a payment method's data
  ///
  /// Returns a map of field names to error messages for invalid fields,
  /// or an empty map if all fields are valid.
  Map<String, String> validatePaymentMethod({
    required String cardNumber,
    required String cardHolderName,
    required String expiryDate,
    required String cvv,
  }) {
    final errors = <String, String>{};

    // Validate card number
    if (cardNumber.isEmpty) {
      errors['cardNumber'] = 'Card number is required';
    } else {
      // Remove spaces and validate card number
      final cleanedCardNumber = cardNumber.replaceAll(' ', '');
      if (cleanedCardNumber.length < 13 || cleanedCardNumber.length > 19) {
        errors['cardNumber'] = 'Please enter a valid card number';
      } else if (!RegExp(r'^[0-9]+$').hasMatch(cleanedCardNumber)) {
        errors['cardNumber'] = 'Card number should contain only digits';
      }
    }

    // Validate cardholder name
    if (cardHolderName.isEmpty) {
      errors['cardHolderName'] = 'Cardholder name is required';
    } else if (cardHolderName.length < 3) {
      errors['cardHolderName'] = 'Name should be at least 3 characters';
    }

    // Validate expiry date
    if (expiryDate.isEmpty) {
      errors['expiryDate'] = 'Expiry date is required';
    } else {
      // Validate MM/YY format
      if (!RegExp(r'^(0[1-9]|1[0-2])\/?([0-9]{2})$').hasMatch(expiryDate)) {
        errors['expiryDate'] = 'Please enter a valid expiry date (MM/YY)';
      } else {
        // Check if the card is expired
        try {
          final parts = expiryDate.split(RegExp(r'[/]'));
          final month = int.parse(parts[0]);
          final year = 2000 + int.parse(parts[1]);

          final now = DateTime.now();
          final expiry = DateTime(year, month + 1, 0); // Last day of the month

          if (expiry.isBefore(now)) {
            errors['expiryDate'] = 'Card has expired';
          }
        } catch (e) {
          errors['expiryDate'] = 'Please enter a valid expiry date (MM/YY)';
        }
      }
    }

    // Validate CVV
    if (cvv.isEmpty) {
      errors['cvv'] = 'CVV is required';
    } else if (cvv.length < 3 || cvv.length > 4) {
      errors['cvv'] = 'CVV should be 3 or 4 digits';
    } else if (!RegExp(r'^[0-9]+$').hasMatch(cvv)) {
      errors['cvv'] = 'CVV should contain only digits';
    }

    return errors;
  }

  /// Converts a StatusRequest failure to a user-friendly error message
  String _getErrorMessage(StatusRequest failure) {
    switch (failure) {
      case StatusRequest.serverFailure:
        return "Server error occurred";
      case StatusRequest.emptyCache:
        return "No data available";
      case StatusRequest.noData:
        return "No data found";
      default:
        return "An error occurred";
    }
  }

  /// Validates a payment method and shows error messages if validation fails
  ///
  /// Returns true if the payment method is valid, false otherwise
  bool validateAndShowErrors({
    required String cardNumber,
    required String cardHolderName,
    required String expiryDate,
    required String cvv,
  }) {
    final errors = validatePaymentMethod(
      cardNumber: cardNumber,
      cardHolderName: cardHolderName,
      expiryDate: expiryDate,
      cvv: cvv,
    );

    if (errors.isNotEmpty) {
      // Show the first error message
      final firstError = errors.values.first;
      showCustomSnackBar(
        message: firstError,
        title: "",
        isError: true,
      );
      return false;
    }

    return true;
  }

  /// Retrieves all payment methods for the current user
  ///
  /// This method performs the following steps:
  /// 1. Sets the status to loading
  /// 2. Fetches payment methods from the repository
  /// 3. Updates the local list of payment methods
  /// 4. Sets the appropriate status based on the result
  /// 5. Shows error messages if the operation fails
  Future<void> getPaymentMethods() async {
    // Check if controller is initialized
    if (!_isInitialized) {
      await _initializeController();
      if (!_isInitialized) {
        paymentMethodsStatus.value = StatusRequest.serverFailure;
        update();
        return;
      }
    }

    try {
      paymentMethodsStatus.value = StatusRequest.loading;
      update();

      final result = await paymentRepo.getPaymentMethods();
      result.fold(
        (failure) {
          paymentMethodsStatus.value = failure;
          update();
          showCustomSnackBar(
            message:
                "Failed to load payment methods: ${_getErrorMessage(failure)}",
            title: "",
            isError: true,
          );
        },
        (paymentMethodsList) {
          paymentMethods.assignAll(paymentMethodsList);
          paymentMethodsStatus.value = StatusRequest.success;
          update();
        },
      );
    } catch (e) {
      paymentMethodsStatus.value = StatusRequest.serverFailure;
      update();
      print("Error in getPaymentMethods: $e");
      showCustomSnackBar(
        message: "Failed to load payment methods: ${e.toString()}",
        title: "",
        isError: true,
      );
    }
  }

  /// Adds a new payment method after validating its data
  ///
  /// This method performs the following steps:
  /// 1. Validates the payment method data
  /// 2. If valid, adds the payment method to the repository
  /// 3. Updates the local list of payment methods
  /// 4. Shows appropriate success or error messages
  Future<void> addPaymentMethod({
    required PaymentMethodModel paymentMethod,
  }) async {
    // Check if controller is initialized
    if (!_isInitialized) {
      await _initializeController();
      if (!_isInitialized) {
        showCustomSnackBar(
          message: "Payment system not initialized",
          title: "",
          isError: true,
        );
        return;
      }
    }

    // Validate payment method data
    if (!validateAndShowErrors(
      cardNumber: paymentMethod.cardNumber,
      cardHolderName: paymentMethod.cardHolderName,
      expiryDate: paymentMethod.expiryDate,
      cvv: paymentMethod.cvv,
    )) {
      return;
    }

    showOverlay(
      asyncFunction: () async {
        try {
          final result = await paymentRepo.addPaymentMethod(
            paymentMethod: paymentMethod,
          );
          result.fold(
            (failure) {
              showCustomSnackBar(
                message:
                    "Failed to add payment method: ${_getErrorMessage(failure)}",
                title: "",
                isError: true,
              );
            },
            (newPaymentMethod) {
              paymentMethods.add(newPaymentMethod);
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
            message: "Failed to add payment method: ${e.toString()}",
            title: "",
            isError: true,
          );
        }
      },
    );
  }

  /// Updates an existing payment method after validating its data
  ///
  /// This method performs the following steps:
  /// 1. Validates the payment method data
  /// 2. If valid, updates the payment method in the repository
  /// 3. Updates the local list of payment methods
  /// 4. Shows appropriate success or error messages
  Future<void> updatePaymentMethod({
    required PaymentMethodModel paymentMethod,
  }) async {
    // Check if controller is initialized
    if (!_isInitialized) {
      await _initializeController();
      if (!_isInitialized) {
        showCustomSnackBar(
          message: "Payment system not initialized",
          title: "",
          isError: true,
        );
        return;
      }
    }

    // Validate payment method data
    if (!validateAndShowErrors(
      cardNumber: paymentMethod.cardNumber,
      cardHolderName: paymentMethod.cardHolderName,
      expiryDate: paymentMethod.expiryDate,
      cvv: paymentMethod.cvv,
    )) {
      return;
    }

    showOverlay(
      asyncFunction: () async {
        try {
          final result = await paymentRepo.updatePaymentMethod(
            paymentMethod: paymentMethod,
          );
          result.fold(
            (failure) {
              showCustomSnackBar(
                message:
                    "Failed to update payment method: ${_getErrorMessage(failure)}",
                title: "",
                isError: true,
              );
            },
            (success) {
              if (success) {
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
            message: "Failed to update payment method: ${e.toString()}",
            title: "",
            isError: true,
          );
        }
      },
    );
  }

  /// Deletes a payment method by its ID
  ///
  /// This method performs the following steps:
  /// 1. Deletes the payment method from the repository
  /// 2. Removes the payment method from the local list
  /// 3. Shows appropriate success or error messages
  Future<void> deletePaymentMethod({
    required String paymentMethodId,
  }) async {
    // Check if controller is initialized
    if (!_isInitialized) {
      await _initializeController();
      if (!_isInitialized) {
        showCustomSnackBar(
          message: "Payment system not initialized",
          title: "",
          isError: true,
        );
        return;
      }
    }

    showOverlay(
      asyncFunction: () async {
        try {
          final result = await paymentRepo.deletePaymentMethod(
            paymentMethodId: paymentMethodId,
          );
          result.fold(
            (failure) {
              showCustomSnackBar(
                message:
                    "Failed to delete payment method: ${_getErrorMessage(failure)}",
                title: "",
                isError: true,
              );
            },
            (success) {
              if (success) {
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
            message: "Failed to delete payment method: ${e.toString()}",
            title: "",
            isError: true,
          );
        }
      },
    );
  }

  /// Retrieves the current subscription for the user
  ///
  /// This method performs the following steps:
  /// 1. Sets the status to loading
  /// 2. Fetches the current subscription from the repository
  /// 3. Updates the local subscription information
  /// 4. Sets the appropriate status based on the result
  /// 5. Shows error messages if the operation fails
  Future<void> getCurrentSubscription() async {
    // Check if controller is initialized
    if (!_isInitialized) {
      await _initializeController();
      if (!_isInitialized) {
        subscriptionStatus.value = StatusRequest.serverFailure;
        update();
        return;
      }
    }

    try {
      subscriptionStatus.value = StatusRequest.loading;
      update();

      final result = await paymentRepo.getCurrentSubscription();
      result.fold(
        (failure) {
          subscriptionStatus.value = failure;
          update();
          showCustomSnackBar(
            message:
                "Failed to load subscription information: ${_getErrorMessage(failure)}",
            title: "",
            isError: true,
          );
        },
        (subscription) {
          currentSubscription.value = subscription;
          subscriptionStatus.value = StatusRequest.success;
          update();
        },
      );
    } catch (e) {
      subscriptionStatus.value = StatusRequest.serverFailure;
      update();
      print("Error in getCurrentSubscription: $e");
      showCustomSnackBar(
        message: "Failed to load subscription information: ${e.toString()}",
        title: "",
        isError: true,
      );
    }
  }

  /// Subscribes to a plan using a specific payment method
  ///
  /// This method performs the following steps:
  /// 1. Subscribes to the plan through the repository
  /// 2. Updates the current subscription information
  /// 3. Shows appropriate success or error messages
  Future<void> subscribeToPlan({
    required String planId,
    required String paymentMethodId,
  }) async {
    // Check if controller is initialized
    if (!_isInitialized) {
      await _initializeController();
      if (!_isInitialized) {
        showCustomSnackBar(
          message: "Payment system not initialized",
          title: "",
          isError: true,
        );
        return;
      }
    }

    showOverlay(
      asyncFunction: () async {
        try {
          final result = await paymentRepo.subscribeToPlan(
            planId: planId,
            paymentMethodId: paymentMethodId,
          );
          result.fold(
            (failure) {
              showCustomSnackBar(
                message:
                    "Failed to subscribe to plan: ${_getErrorMessage(failure)}",
                title: "",
                isError: true,
              );
            },
            (subscription) {
              currentSubscription.value = subscription;
              showCustomSnackBar(
                message: "Successfully subscribed to ${subscription.planName}",
                title: "",
                isError: false,
              );
              update();
            },
          );
        } catch (e) {
          showCustomSnackBar(
            message: "Failed to subscribe to plan: ${e.toString()}",
            title: "",
            isError: true,
          );
        }
      },
    );
  }

  /// Sets a payment method as the default payment method
  ///
  /// This method performs the following steps:
  /// 1. Sets all payment methods as non-default
  /// 2. Sets the selected payment method as default
  /// 3. Updates the UI and shows a success message
  void setDefaultPaymentMethod(String paymentMethodId) {
    // Check if controller is initialized
    if (!_isInitialized) {
      showCustomSnackBar(
        message: "Payment system not initialized",
        title: "",
        isError: true,
      );
      return;
    }

    // Set all payment methods as non-default first
    for (var i = 0; i < paymentMethods.length; i++) {
      paymentMethods[i] = paymentMethods[i].copyWith(isDefault: false);
    }

    // Set the selected payment method as default
    final index =
        paymentMethods.indexWhere((element) => element.id == paymentMethodId);
    if (index != -1) {
      paymentMethods[index] = paymentMethods[index].copyWith(isDefault: true);
      showCustomSnackBar(
        message: "Default payment method updated",
        title: "",
        isError: false,
      );
    } else {
      showCustomSnackBar(
        message: "Payment method not found",
        title: "",
        isError: true,
      );
    }

    update();
  }
}
