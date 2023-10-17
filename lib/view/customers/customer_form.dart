import 'package:flutter/material.dart';
import 'package:flutter_sqlite/components/simple_future_builder.dart';
import 'package:flutter_sqlite/core/app_locator.dart';
import 'package:flutter_sqlite/core/app_navigation.dart';
import 'package:flutter_sqlite/infra/customers_repository.dart';
import 'package:flutter_sqlite/models/customer.dart';
import 'package:form_validator/form_validator.dart';

class CustomerForm extends StatefulWidget {
  const CustomerForm({super.key});

  @override
  State<CustomerForm> createState() => _CustomerFormState();
}

class _CustomerFormState extends State<CustomerForm> {
  final _form = GlobalKey<FormState>();
  final _formData = <String, String>{};
  Customer? _customer;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    var settings = ModalRoute.of(context)?.settings;

    _customer = settings?.arguments == null
        ? Customer(id: 0, name: '', email: '', avatar: '')
        : settings?.arguments as Customer;

    _formData['id'] = _customer!.id.toString();
    _formData['name'] = _customer!.name;
    _formData['email'] = _customer!.email;
    _formData['avatar'] = _customer!.avatar;
  }

  @override
  Widget build(BuildContext context) {
    var repository = locator<CustomerRepository>();

    Future<Customer?>? future;

    if (_customer!.id > 0) {
      future = repository.get(_customer!.id);
    }

    return SimpleFutureBuilder<Customer>(
        future: future,
        initialData: _customer,
        onLoaded: (instance) =>
            Scaffold(appBar: buildAppBar(repository), body: buildBody()));
  }

  AppBar buildAppBar(CustomerRepository repository) {
    return AppBar(
      title: const Text('New Customer'),
      actions: <Widget>[
        IconButton(
          onPressed: () {
            final isValid = _form.currentState!.validate();

            if (isValid) {
              _form.currentState!.save();

              var customer = Customer(
                  id: int.parse(_formData['id']!),
                  name: _formData['name']!,
                  email: _formData['email']!,
                  avatar: _formData['avatar']!);

              repository.addOrUpdate(customer).then((value) {
                AppNavigation.navigateToHome(context);
              });
            }
          },
          icon: const Icon(Icons.save),
        )
      ],
    );
  }

  Widget buildBody() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Form(
        key: _form,
        child: Column(
          children: [
            TextFormField(
              initialValue: _formData['name'],
              decoration: const InputDecoration(labelText: 'Nome'),
              validator: ValidationBuilder().required().build(),
              onSaved: (value) => _formData['name'] = value!,
            ),
            TextFormField(
              initialValue: _formData['email'],
              decoration: const InputDecoration(labelText: 'Email'),
              validator: ValidationBuilder().email().build(),
              onSaved: (value) => _formData['email'] = value!,
            ),
            TextFormField(
              initialValue: _formData['avatar'],
              decoration: const InputDecoration(labelText: 'Avatar url'),
              onSaved: (value) => _formData['avatar'] = value!,
            )
          ],
        ),
      ),
    );
  }
}
