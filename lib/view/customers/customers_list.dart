import 'package:flutter/material.dart';
import 'package:flutter_sqlite/components/simple_future_builder.dart';
import 'package:flutter_sqlite/core/app_locator.dart';
import 'package:flutter_sqlite/core/app_navigation.dart';
import 'package:flutter_sqlite/infra/customers_repository.dart';
import 'package:flutter_sqlite/models/customer.dart';
import 'package:flutter_sqlite/view/customers/customer_tile.dart';

class CustomersList extends StatefulWidget {
  const CustomersList({super.key});

  @override
  State<CustomersList> createState() => CustomersListState();
}

class CustomersListState extends State<CustomersList> {
  late Future<List<Customer>> futureCustomers;

  @override
  void initState() {
    super.initState();

    var repository = locator<CustomerRepository>();
    futureCustomers = repository.getAll();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleFutureBuilder<List<Customer>>(
        future: futureCustomers,
        onLoaded: (instance) {
          return Scaffold(
              appBar: AppBar(
                title: const Text('Customers'),
                actions: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () =>
                        AppNavigation.navigateToNewCustomer(context),
                  ),
                ],
              ),
              body: ListView.builder(
                  itemCount: instance.length,
                  itemBuilder: (ctx, index) =>
                      CustomerTile(instance.elementAt(index))));
        });
  }
}
