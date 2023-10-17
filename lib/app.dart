import 'package:flutter/material.dart';
import 'package:flutter_sqlite/core/app_navigation.dart';
import 'package:flutter_sqlite/view/customers/customer_form.dart';
import 'package:flutter_sqlite/view/customers/customers_list.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        AppNavigation.home: (_) => const CustomersList(),
        AppNavigation.customerForm: (_) => const CustomerForm()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
