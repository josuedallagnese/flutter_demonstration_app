import 'package:flutter/material.dart';
import 'package:flutter_demonstration_app/core/app_navigation.dart';
import 'package:flutter_demonstration_app/view/customers/customer_form.dart';
import 'package:flutter_demonstration_app/view/customers/customers_list.dart';
import 'package:flutter_demonstration_app/view/home.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        AppNavigation.home: (_) => const Home(),
        AppNavigation.customers: (_) => const CustomersList(),
        AppNavigation.customerForm: (_) => const CustomerForm()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
