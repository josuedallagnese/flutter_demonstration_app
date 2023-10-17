import 'package:flutter/material.dart';
import 'package:flutter_sqlite/components/simple_future_builder.dart';
import 'package:flutter_sqlite/core/app_locator.dart';
import 'package:flutter_sqlite/core/app_navigation.dart';
import 'package:flutter_sqlite/infra/customers_repository.dart';
import 'package:flutter_sqlite/models/customer.dart';

class CustomerTile extends StatelessWidget {
  final Customer customer;

  const CustomerTile(this.customer, {super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleFutureBuilder<Customer>(
        initialData: customer,
        onLoaded: (instance) {
          final avatar = instance.avatar.isEmpty
              ? const CircleAvatar(child: Icon(Icons.person))
              : CircleAvatar(backgroundImage: NetworkImage(instance.avatar));

          return ListTile(
            leading: avatar,
            title: Text(instance.name),
            subtitle: Text(instance.email),
            trailing: SizedBox(
                width: 100,
                child: Row(
                  children: <Widget>[
                    IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => AppNavigation.navigateToEditCustomer(
                            context, instance)),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text('Customer exclusion'),
                            content: Text(
                                'Are you sure about ${customer.name} exclusion?'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text('No'),
                              ),
                              TextButton(
                                onPressed: () async {
                                  var repository =
                                      locator<CustomerRepository>();
                                  await repository.delete(customer);
                                  // ignore: use_build_context_synchronously
                                  AppNavigation.navigateToHome(context);
                                },
                                child: const Text('Yes'),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                )),
          );
        });
  }
}
