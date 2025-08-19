import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/helpers/enums.dart';
import '../../../../core/helpers/spacing.dart';
import '../../controllers/payment_controller.dart';
import '../../data/models/payment_method_model.dart';
import '../../widgets/custom_app_bar.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Payment Methods',
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              Get.find<PaymentController>().getPaymentMethods();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0.dm),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Payment methods section
              Text(
                'Your Payment Methods',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              verticalSpace(20),
              // Payment methods list
              GetBuilder<PaymentController>(
                builder: (paymentController) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (paymentController.paymentMethods.isNotEmpty)
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: paymentController.paymentMethods.length,
                          itemBuilder: (context, index) {
                            final paymentMethod =
                                paymentController.paymentMethods[index];
                            return Card(
                              margin: EdgeInsets.only(bottom: 10.dm),
                              elevation: 2.dm,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.dm),
                              ),
                              child: ListTile(
                                leading: Icon(
                                  paymentMethod.isDefault
                                      ? Icons.credit_card
                                      : Icons.credit_card_outlined,
                                  color: paymentMethod.isDefault
                                      ? Theme.of(context).colorScheme.primary
                                      : Theme.of(context)
                                          .colorScheme
                                          .onSurface
                                          .withOpacity(0.7),
                                ),
                                title: Text(
                                  paymentMethod.cardNumber,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                subtitle: Text(
                                    '${paymentMethod.cardHolderName} - ${paymentMethod.expiryDate}',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface
                                          .withOpacity(0.7),
                                    )),
                                trailing: paymentMethod.isDefault
                                    ? Container(
                                        padding: EdgeInsets.all(4.dm),
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          borderRadius:
                                              BorderRadius.circular(4.dm),
                                        ),
                                        child: Text(
                                          'Default',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                      )
                                    : IconButton(
                                        icon: const Icon(Icons.more_vert),
                                        onPressed: () {
                                          // Show options for this payment method
                                          _showPaymentMethodOptions(context,
                                              paymentController, paymentMethod);
                                        },
                                      ),
                                onTap: () {
                                  // Set as default payment method
                                  paymentController.setDefaultPaymentMethod(
                                      paymentMethod.id);
                                },
                              ),
                            );
                          },
                        )
                      else if (paymentController.paymentMethodsStatus.value ==
                          StatusRequest.loading)
                        const Center(child: CircularProgressIndicator())
                      else
                        Center(
                          child: Column(
                            children: [
                              Icon(
                                Icons.credit_card_off_outlined,
                                size: 48.sp,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withOpacity(0.5),
                              ),
                              verticalSpace(10),
                              Text(
                                'No payment methods found',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                ),
                              ),
                              verticalSpace(10),
                              Text(
                                'Add a payment method to get started',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurface
                                      .withOpacity(0.7),
                                ),
                              ),
                              verticalSpace(20),
                              ElevatedButton(
                                onPressed: () {
                                  // Add new payment method
                                  _showAddPaymentMethodDialog(
                                      context, paymentController);
                                },
                                child: Text('Add Payment Method'),
                              ),
                            ],
                          ),
                        ),
                    ],
                  );
                },
              ),
              verticalSpace(30),
              // Add payment method button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    _showAddPaymentMethodDialog(
                        context, Get.find<PaymentController>());
                  },
                  child: Text('Add New Payment Method'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPaymentMethodOptions(BuildContext context,
      PaymentController paymentController, PaymentMethodModel paymentMethod) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0.dm),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.edit,
                    color: Theme.of(context).colorScheme.primary),
                title: Text('Edit'),
                onTap: () {
                  Navigator.pop(context);
                  _showEditPaymentMethodDialog(
                      context, paymentController, paymentMethod);
                },
              ),
              ListTile(
                leading: Icon(Icons.delete, color: Colors.red),
                title: Text('Delete'),
                onTap: () {
                  Navigator.pop(context);
                  paymentController.deletePaymentMethod(
                      paymentMethodId: paymentMethod.id);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showAddPaymentMethodDialog(
      BuildContext context, PaymentController paymentController) {
    final formKey = GlobalKey<FormState>();
    final cardNumberController = TextEditingController();
    final cardHolderNameController = TextEditingController();
    final expiryDateController = TextEditingController();
    final cvvController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0.dm),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Add Payment Method',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                verticalSpace(20),
                TextFormField(
                  controller: cardNumberController,
                  decoration: InputDecoration(
                    labelText: 'Card Number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.dm),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter card number';
                    }
                    // Remove spaces and validate card number
                    final cleanedValue = value.replaceAll(' ', '');
                    if (cleanedValue.length < 13 || cleanedValue.length > 19) {
                      return 'Please enter a valid card number';
                    }
                    if (!RegExp(r'^[0-9]+$').hasMatch(cleanedValue)) {
                      return 'Card number should contain only digits';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                ),
                verticalSpace(10),
                TextFormField(
                  controller: cardHolderNameController,
                  decoration: InputDecoration(
                    labelText: 'Cardholder Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.dm),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter cardholder name';
                    }
                    if (value.length < 3) {
                      return 'Name should be at least 3 characters';
                    }
                    return null;
                  },
                ),
                verticalSpace(10),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: expiryDateController,
                        decoration: InputDecoration(
                          labelText: 'Expiry Date (MM/YY)',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.dm),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter expiry date';
                          }
                          // Validate MM/YY format
                          if (!RegExp(r'^(0[1-9]|1[0-2])\/?([0-9]{2})$')
                              .hasMatch(value)) {
                            return 'Please enter a valid expiry date (MM/YY)';
                          }
                          return null;
                        },
                      ),
                    ),
                    horizontalSpace(10),
                    Expanded(
                      child: TextFormField(
                        controller: cvvController,
                        decoration: InputDecoration(
                          labelText: 'CVV',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.dm),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter CVV';
                          }
                          if (value.length < 3 || value.length > 4) {
                            return 'CVV should be 3 or 4 digits';
                          }
                          if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                            return 'CVV should contain only digits';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        obscureText: true,
                      ),
                    ),
                  ],
                ),
                verticalSpace(20),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      // Create a new payment method
                      final paymentMethod =
                          PaymentMethodModel.createSecurePaymentMethod(
                        id: DateTime.now().toString(),
                        fullCardNumber: cardNumberController.text,
                        cardHolderName: cardHolderNameController.text,
                        expiryDate: expiryDateController.text,
                        fullCvv: cvvController.text,
                        isDefault: paymentController.paymentMethods.isEmpty,
                      );
                      paymentController.addPaymentMethod(
                          paymentMethod: paymentMethod);
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Add Payment Method'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showEditPaymentMethodDialog(BuildContext context,
      PaymentController paymentController, PaymentMethodModel paymentMethod) {
    final formKey = GlobalKey<FormState>();
    final cardNumberController =
        TextEditingController(text: paymentMethod.cardNumber);
    final cardHolderNameController =
        TextEditingController(text: paymentMethod.cardHolderName);
    final expiryDateController =
        TextEditingController(text: paymentMethod.expiryDate);
    final cvvController = TextEditingController(text: paymentMethod.cvv);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0.dm),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Edit Payment Method',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                verticalSpace(20),
                TextFormField(
                  controller: cardNumberController,
                  decoration: InputDecoration(
                    labelText: 'Card Number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.dm),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter card number';
                    }
                    // Remove spaces and validate card number
                    final cleanedValue = value.replaceAll(' ', '');
                    if (cleanedValue.length < 13 || cleanedValue.length > 19) {
                      return 'Please enter a valid card number';
                    }
                    if (!RegExp(r'^[0-9]+$').hasMatch(cleanedValue)) {
                      return 'Card number should contain only digits';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                ),
                verticalSpace(10),
                TextFormField(
                  controller: cardHolderNameController,
                  decoration: InputDecoration(
                    labelText: 'Cardholder Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.dm),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter cardholder name';
                    }
                    if (value.length < 3) {
                      return 'Name should be at least 3 characters';
                    }
                    return null;
                  },
                ),
                verticalSpace(10),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: expiryDateController,
                        decoration: InputDecoration(
                          labelText: 'Expiry Date (MM/YY)',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.dm),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter expiry date';
                          }
                          // Validate MM/YY format
                          if (!RegExp(r'^(0[1-9]|1[0-2])\/?([0-9]{2})$')
                              .hasMatch(value)) {
                            return 'Please enter a valid expiry date (MM/YY)';
                          }
                          return null;
                        },
                      ),
                    ),
                    horizontalSpace(10),
                    Expanded(
                      child: TextFormField(
                        controller: cvvController,
                        decoration: InputDecoration(
                          labelText: 'CVV',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.dm),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter CVV';
                          }
                          if (value.length < 3 || value.length > 4) {
                            return 'CVV should be 3 or 4 digits';
                          }
                          if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                            return 'CVV should contain only digits';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        obscureText: true,
                      ),
                    ),
                  ],
                ),
                verticalSpace(20),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      // Update the payment method
                      final updatedPaymentMethod =
                          PaymentMethodModel.createSecurePaymentMethod(
                        id: paymentMethod.id,
                        fullCardNumber: cardNumberController.text,
                        cardHolderName: cardHolderNameController.text,
                        expiryDate: expiryDateController.text,
                        fullCvv: cvvController.text,
                        isDefault: paymentMethod.isDefault,
                      );
                      paymentController.updatePaymentMethod(
                          paymentMethod: updatedPaymentMethod);
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Update Payment Method'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
