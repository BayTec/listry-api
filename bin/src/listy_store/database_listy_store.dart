import '../database/database.dart';
import '../listy/database_listy.dart';
import '../listy/listy.dart';
import 'listy_store.dart';

class DatabaseListyStore implements ListyStore {
  final Database database;

  DatabaseListyStore(this.database);

  @override
  Future<List<Listy>> all() async {
    final List<Listy> listies = [];

    final ids = await database.query('SELECT id FROM listy;');

    for (final element in ids) {
      listies.add(DatabaseListy(element['id'], database));
    }

    return listies;
  }

  @override
  Future<Listy> create(String name) async {
    final ids = await database.query('SELECT id FROM listy;');

    var id = 0;
    while (ids.any((element) => element['id'] == id)) {
      id++;
    }

    await database.execute(
        'INSERT INTO listy (id, name) VALUES ($id, @name);', {'name': name});

    return DatabaseListy(id, database);
  }

  @override
  Future<void> delete(Listy listy) async {
    await database.execute('DELETE FROM listy WHERE id = ${listy.id()};');
  }

  @override
  Future<Listy?> find(int id) async {
    final ids = await database.query('SELECT id FROM listy WHERE id = $id;');

    if (ids.isEmpty) {
      return null;
    }

    return DatabaseListy(ids.first['id'], database);
  }
}
