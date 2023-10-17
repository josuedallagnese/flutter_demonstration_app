import 'package:flutter/material.dart';
import 'package:flutter_demonstration_app/models/customer.dart';

class AppNavigation {
  static const home = '/';
  static const customers = '/customers';
  static const customerForm = '/customer';

  static Future navigateToHome(BuildContext context) {
    return Navigator.of(context).pushNamed(home);
  }

  static Future navigateToCustomers(BuildContext context) {
    return Navigator.of(context).pushNamed(customers);
  }

  static Future navigateToNewCustomer(BuildContext context) {
    return Navigator.of(context).pushNamed(customerForm);
  }

  static Future navigateToEditCustomer(
      BuildContext context, Customer customer) {
    return Navigator.of(context).pushNamed(
      customerForm,
      arguments: customer,
    );
  }
}
