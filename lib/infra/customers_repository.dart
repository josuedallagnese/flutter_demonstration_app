import 'package:flutter_sqlite/constants/database_constants.dart';
import 'package:flutter_sqlite/infra/database_provider.dart';
import 'package:flutter_sqlite/models/customer.dart';
import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';

GetIt getIt = GetIt.instance;

class CustomerRepository {
  final DatabaseProvider databaseProvider;

  CustomerRepository({required this.databaseProvider});

  Future<List<Customer>> getAll() async {
    var db = databaseProvider.db;

    List<Map<String, dynamic>> results =
        await db.query(DatabaseConstants.customerTable, orderBy: 'name');

    List<Customer> customers = results.map((customerData) {
      return Customer(
        id: customerData['id'],
        name: customerData['name'],
        email: customerData['email'],
        avatar: customerData['avatar'],
      );
    }).toList();

    return customers;
  }

  Future<Customer?> get(int id) async {
    var db = databaseProvider.db;

    List<Map<String, dynamic>> results = await db.query(
        DatabaseConstants.customerTable,
        orderBy: 'name',
        where: 'id = ?',
        whereArgs: [id]);

    var customers = results.map((customerData) {
      return Customer(
        id: customerData['id'],
        name: customerData['name'],
        email: customerData['email'],
        avatar: customerData['avatar'],
      );
    }).toList();

    return customers.elementAtOrNull(0);
  }

  Future<void> add(Customer customer) async {
    var db = databaseProvider.db;

    await db.insert(DatabaseConstants.customerTable, customer.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> addOrUpdate(Customer customer) async {
    var db = databaseProvider.db;

    if (customer.id == 0) return add(customer);

    await db.update(DatabaseConstants.customerTable, customer.toMap(),
        where: 'id = ?', whereArgs: [customer.id]);
  }

  Future<void> delete(Customer customer) async {
    var db = databaseProvider.db;

    await db.delete(DatabaseConstants.customerTable,
        where: 'id = ?', whereArgs: [customer.id]);
  }
}
