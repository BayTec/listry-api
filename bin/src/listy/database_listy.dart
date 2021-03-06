import '../database/database.dart';
import '../entry/database_entry.dart';
import '../entry/entry.dart';
import 'listy.dart';

class DatabaseListy implements Listy {
  final int _id;
  final Database database;

  DatabaseListy(this._id, this.database);

  @override
  Future<Entry> createEntry(String name, int amount, bool checked) async {
    final ids = await database.query('SELECT id FROM listy.entry;');

    var id = 0;
    while (ids.any((element) => element['id'] == id)) {
      id++;
    }

    await database.execute(
        'INSERT INTO listy.entry (id, name, amount, checked, listy_id) VALUES ($id, @name, $amount, $checked, ${this.id()});',
        {'name': name});

    return DatabaseEntry(id, database);
  }

  @override
  Future<List<Entry>> getEntries() async {
    final List<Entry> entries = [];

    final ids = await database
        .query('SELECT id FROM listy.entry WHERE listy_id = ${id()};');

    for (final element in ids) {
      entries.add(DatabaseEntry(element['id'], database));
    }

    return entries;
  }

  @override
  Future<String> getName() async {
    final names = await database
        .query('SELECT name FROM listy.listy WHERE id = ${id()};');

    return names.first['name'];
  }

  @override
  int id() {
    return _id;
  }

  @override
  Future<void> deleteEntry(Entry entry) async {
    await database.execute('DELETE FROM listy.entry WHERE id = ${entry.id()};');
  }

  @override
  Future<void> setName(String name) async {
    await database.execute(
        'UPDATE listy.listy SET name = @name WHERE id = ${id()};',
        {'name': name});
  }

  @override
  Future<Map<String, dynamic>> toMap() async {
    final entries = await getEntries();

    final List<Map<String, dynamic>> mappedEntries = [];

    for (final element in entries) {
      mappedEntries.add(await element.toMap());
    }

    return {
      'id': id(),
      'name': await getName(),
      'entries': mappedEntries,
    };
  }
}
