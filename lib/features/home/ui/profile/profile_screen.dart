import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/helpers/constants.dart';
import '../../../../core/helpers/enums.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/localization/constants.dart';
import '../../controllers/payment_controller.dart';
import '../../controllers/profile_controller.dart';
import '../../data/models/payment_method_model.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_drawer_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Profile.tr,
      ),
      drawer: CustomDrawerWidget(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile header section
            GetBuilder<ProfileController>(
              builder: (profileController) => Container(
                width: double.infinity,
                padding: EdgeInsets.all(20.dm),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(20.dm),
                  ),
                ),
                child: profileController.statusReq == StatusRequest.loading
                    ? const Center(child: CircularProgressIndicator())
                    : Skeletonizer(
                        enabled: profileController.statusReq ==
                            StatusRequest.loading,
                        enableSwitchAnimation: true,
                        child: profileController.statusReq ==
                                StatusRequest.serverFailure
                            // if server error
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      Please_try_agein_later.tr,
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                      ),
                                    ),
                                    verticalSpace(20),
                                    ElevatedButton(
                                        onPressed: () {
                                          profileController.getUserInfo();
                                        },
                                        child: Text(TryAgain.tr))
                                  ],
                                ),
                              )
                            : Column(
                                children: [
                                  CircleAvatar(
                                    backgroundColor:
                                        Theme.of(context).colorScheme.primary,
                                    backgroundImage: const AssetImage(
                                      ImageAssets.logo,
                                    ),
                                    radius: 60.r,
                                  ),
                                  verticalSpace(20),
                                  Text(
                                    profileController.userInf?.userName ??
                                        'User Name',
                                    style: TextStyle(
                                      fontSize: 22.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                    ),
                                  ),
                                  verticalSpace(5),
                                  Text(
                                    profileController.userInf?.email ??
                                        'user@example.com',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface
                                          .withOpacity(0.7),
                                    ),
                                  ),
                                ],
                              ),
                      ),
              ),
            ),
            verticalSpace(20),
            // Profile details section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.dm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Account Details',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  verticalSpace(15),
                  GetBuilder<ProfileController>(
                    builder: (profileController) => Column(
                      children: [
                        Card(
                          elevation: 2.dm,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.dm),
                          ),
                          child: ListTile(
                            leading: Container(
                              padding: EdgeInsets.all(8.dm),
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8.dm),
                              ),
                              child: Icon(
                                Icons.person,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            title: Text(
                              profileController.userInf?.userName ??
                                  'User Name',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            subtitle: Text(
                              'Full Name',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withOpacity(0.7),
                              ),
                            ),
                            trailing: Icon(
                              Icons.edit,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            onTap: () {
                              profileController
                                  .showActionBottomSheet('userInfo');
                            },
                          ),
                        ),
                        verticalSpace(10),
                        Card(
                          elevation: 2.dm,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.dm),
                          ),
                          child: ListTile(
                            leading: Container(
                              padding: EdgeInsets.all(8.dm),
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8.dm),
                              ),
                              child: Icon(
                                Icons.email,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            title: Text(
                              profileController.userInf?.email ??
                                  'user@example.com',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            subtitle: Text(
                              'Email Address',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withOpacity(0.7),
                              ),
                            ),
                            trailing: Icon(
                              Icons.edit,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            onTap: () {
                              profileController.showActionBottomSheet('email');
                            },
                          ),
                        ),
                        verticalSpace(10),
                        Card(
                          elevation: 2.dm,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.dm),
                          ),
                          child: ListTile(
                            leading: Container(
                              padding: EdgeInsets.all(8.dm),
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8.dm),
                              ),
                              child: Icon(
                                Icons.phone,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            title: Text(
                              profileController.userInf?.phone ??
                                  'Add phone number',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            subtitle: Text(
                              'Phone Number',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withOpacity(0.7),
                              ),
                            ),
                            trailing: Icon(
                              Icons.edit,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            onTap: () {
                              profileController
                                  .showActionBottomSheet('userInfo');
                            },
                          ),
                        ),
                        verticalSpace(10),
                        Card(
                          elevation: 2.dm,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.dm),
                          ),
                          child: ListTile(
                            leading: Container(
                              padding: EdgeInsets.all(8.dm),
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8.dm),
                              ),
                              child: Icon(
                                Icons.password_outlined,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            title: Text(
                              ChangePassword.tr,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            subtitle: Text(
                              'Update your password',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withOpacity(0.7),
                              ),
                            ),
                            trailing: Icon(
                              Icons.edit,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            onTap: () {
                              profileController
                                  .showActionBottomSheet('password');
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  verticalSpace(30),
                  // Payment and subscription section
                  Text(
                    'Payment & Subscription',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  verticalSpace(15),
                  GetBuilder<PaymentController>(
                    builder: (paymentController) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Payment methods section
                          Text(
                            'Payment Methods',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          verticalSpace(10),
                          // Payment methods list
                          if (paymentController.paymentMethods.isNotEmpty)
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount:
                                  paymentController.paymentMethods.length,
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
                                          ? Theme.of(context)
                                              .colorScheme
                                              .primary
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
                                              _showPaymentMethodOptions(
                                                  context,
                                                  paymentController,
                                                  paymentMethod);
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
                          else if (paymentController
                                  .paymentMethodsStatus.value ==
                              StatusRequest.loading)
                            const Center(child: CircularProgressIndicator())
                          else
                            Center(
                              child: Column(
                                children: [
                                  Text(
                                    'No payment methods found',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                    ),
                                  ),
                                  verticalSpace(10),
                                  OutlinedButton(
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
                          verticalSpace(20),
                          // Subscription section
                          Text(
                            'Subscription',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          verticalSpace(10),
                          // Subscription details
                          if (paymentController.currentSubscription.value !=
                              null)
                            Card(
                              elevation: 2.dm,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.dm),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(16.0.dm),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          paymentController.currentSubscription
                                              .value!.planName,
                                          style: TextStyle(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface,
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(4.dm),
                                          decoration: BoxDecoration(
                                            color: paymentController
                                                    .currentSubscription
                                                    .value!
                                                    .isActive
                                                ? Colors.green
                                                : Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(4.dm),
                                          ),
                                          child: Text(
                                            paymentController
                                                    .currentSubscription
                                                    .value!
                                                    .isActive
                                                ? 'Active'
                                                : 'Expired',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12.sp,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    verticalSpace(10),
                                    Text(
                                      paymentController.currentSubscription
                                          .value!.planDescription,
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface
                                            .withOpacity(0.7),
                                      ),
                                    ),
                                    verticalSpace(10),
                                    Text(
                                      '${paymentController.currentSubscription.value!.price} ${paymentController.currentSubscription.value!.currency}/${paymentController.currentSubscription.value!.billingPeriod}',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                    ),
                                    verticalSpace(10),
                                    if (paymentController
                                        .currentSubscription.value!.isActive)
                                      Text(
                                        'Renews on ${paymentController.currentSubscription.value!.endDate.toString().split(' ')[0]}',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface
                                              .withOpacity(0.7),
                                        ),
                                      ),
                                    if (!paymentController.currentSubscription
                                            .value!.isActive &&
                                        !paymentController.currentSubscription
                                            .value!.isExpired)
                                      Text(
                                        '${paymentController.currentSubscription.value!.daysRemaining} days remaining',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface
                                              .withOpacity(0.7),
                                        ),
                                      ),
                                    if (paymentController
                                        .currentSubscription.value!.isExpired)
                                      Text(
                                        'Expired',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: Colors.red,
                                        ),
                                      ),
                                    verticalSpace(10),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        OutlinedButton(
                                          onPressed: () {
                                            // Cancel subscription
                                            _showCancelSubscriptionDialog(
                                                context, paymentController);
                                          },
                                          child: Text('Cancel'),
                                        ),
                                        horizontalSpace(10),
                                        ElevatedButton(
                                          onPressed: () {
                                            // Change plan
                                            _showChangePlanDialog(
                                                context, paymentController);
                                          },
                                          child: Text('Change Plan'),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          else if (paymentController.subscriptionStatus.value ==
                              StatusRequest.loading)
                            const Center(child: CircularProgressIndicator())
                          else
                            Center(
                              child: Column(
                                children: [
                                  Text(
                                    'No active subscription',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                    ),
                                  ),
                                  verticalSpace(10),
                                  ElevatedButton(
                                    onPressed: () {
                                      // Subscribe to a plan
                                      _showSubscribeDialog(
                                          context, paymentController);
                                    },
                                    child: Text('Subscribe Now'),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
            verticalSpace(30),
          ],
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
                    return null;
                  },
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
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                verticalSpace(20),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      // Create a new payment method
                      final paymentMethod = PaymentMethodModel(
                        id: DateTime.now().toString(),
                        cardNumber: cardNumberController.text,
                        cardHolderName: cardHolderNameController.text,
                        expiryDate: expiryDateController.text,
                        cvv: cvvController.text,
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
                    return null;
                  },
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
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                verticalSpace(20),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      // Update the payment method
                      final updatedPaymentMethod = paymentMethod.copyWith(
                        cardNumber: cardNumberController.text,
                        cardHolderName: cardHolderNameController.text,
                        expiryDate: expiryDateController.text,
                        cvv: cvvController.text,
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

  void _showCancelSubscriptionDialog(
      BuildContext context, PaymentController paymentController) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Cancel Subscription'),
          content: Text('Are you sure you want to cancel your subscription?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                // Cancel subscription logic here
                Navigator.pop(context);
                // Show confirmation message
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Subscription cancelled')),
                );
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  void _showChangePlanDialog(
      BuildContext context, PaymentController paymentController) {
    // For now, just show a simple dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Change Plan'),
          content: Text('Please contact support to change your plan.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showSubscribeDialog(
      BuildContext context, PaymentController paymentController) {
    // For now, just show a simple dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Subscribe'),
          content: Text('Please contact support to subscribe to a plan.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
