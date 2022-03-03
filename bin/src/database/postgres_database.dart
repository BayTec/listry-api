import 'package:postgres/postgres.dart';

import 'database.dart';

class PostgresDatabase implements Database {
  final PostgreSQLConnection connection;

  PostgresDatabase(this.connection);

  @override
  Future<void> execute(String sql, [Map<String, dynamic>? parameter]) async {
    await connection.open();
    await connection.execute(sql, substitutionValues: parameter);
    await connection.close();
  }

  @override
  Future<List<Map<String, dynamic>>> query(String sql,
      [Map<String, dynamic>? parameter]) async {
    await connection.open();

    final result =
        await connection.mappedResultsQuery(sql, substitutionValues: parameter);

    await connection.close();

    return result; // TODO: find out how to correctliy get the data
  }
}
