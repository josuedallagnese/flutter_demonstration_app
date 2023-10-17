import 'dart:async';

import 'package:flutter_demonstration_app/constants/constants.dart';
import 'package:flutter_demonstration_app/models/customer.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  late Database _database;

  Database get db => _database;

  Future<void> initialize() async {
    var path = join(await getDatabasesPath(), DatabaseConstants.dbName);

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: onCreate,
    );
  }

  FutureOr<void> onCreate(db, version) async {
    await db.execute('''
                CREATE TABLE ${DatabaseConstants.customerTable} (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                name TEXT,
                email TEXT,
                avatar TEXT
              )
            ''');

    var dummyCustomers = {
      Customer(
          id: 1,
          name: 'Maria',
          email: 'maria@email.com',
          avatar:
              'https://cdn.pixabay.com/photo/2016/09/01/08/24/smiley-1635449_1280.png'),
      Customer(
          id: 2,
          name: 'João',
          email: 'joao@email.com',
          avatar:
              'https://cdn.pixabay.com/photo/2014/04/03/10/32/businessman-310819_1280.png'),
      Customer(
          id: 3,
          name: 'Pedro',
          email: 'pedro@email.com',
          avatar:
              'https://cdn.pixabay.com/photo/2016/03/10/05/07/wolf-1247882_1280.png')
    };

    for (Customer customer in dummyCustomers) {
      await db.insert('Customer', customer.toMap());
    }
  }
}
