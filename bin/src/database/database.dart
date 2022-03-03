abstract class Database {
  Future<List<Map<String, dynamic>>> query(String sql,
      [Map<String, dynamic>? parameter]);
  Future<void> execute(String sql, [Map<String, dynamic>? parameter]);
}
