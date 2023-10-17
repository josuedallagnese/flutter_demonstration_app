import 'package:flutter_demonstration_app/infra/customers_repository.dart';
import 'package:flutter_demonstration_app/infra/database_provider.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

Future setupLocator() async {
  // database
  var provider = DatabaseProvider();
  await provider.initialize();
  locator.registerSingleton<DatabaseProvider>(provider);

  // repositories
  locator.registerSingleton<CustomerRepository>(
      CustomerRepository(databaseProvider: provider));
}
