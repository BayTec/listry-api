import 'package:postgres/postgres.dart';

import 'database.dart';

class PostgresDatabase implements Database {
  final String host;
  final int port;
  final String databaseName;
  final String username, password;

  PostgresDatabase(
      this.host, this.port, this.databaseName, this.username, this.password);

  PostgreSQLConnection connection() {
    return PostgreSQLConnection(
      host,
      port,
      databaseName,
      username: username,
      password: password,
    );
  }

  @override
  Future<void> execute(String sql, [Map<String, dynamic>? parameter]) async {
    final connection = this.connection();

    await connection.open();
    await connection.execute(sql, substitutionValues: parameter);
    await connection.close();
  }

  @override
  Future<List<Map<String, dynamic>>> query(String sql,
      [Map<String, dynamic>? parameter]) async {
    final List<Map<String, dynamic>> list = [];

    final connection = this.connection();

    await connection.open();
    final result = await connection.query(sql, substitutionValues: parameter);
    await connection.close();

    for (final row in result) {
      list.add(row.toColumnMap());
    }

    return list;
  }
}
