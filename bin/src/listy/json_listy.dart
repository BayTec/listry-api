import '../entry/entry.dart';
import '../entry/json_entry.dart';
import 'listy.dart';

class JsonListy implements Listy {
  final Map<String, dynamic> json;

  JsonListy(this.json);

  @override
  Future<Entry> createEntry(String name, int amount, bool checked) async {
    List<dynamic> entries = json['entries'];

    var id = 0;

    while (entries.any((element) => element['id'] == id)) {
      id++;
    }

    final entry = {
      'id': id,
      'name': name,
      'amount': amount,
      'checked': checked,
    };

    entries.add(entry);

    json['entries'] = entries;

    return JsonEntry(entry);
  }

  @override
  Future<void> deleteEntry(Entry entry) async {
    List<dynamic> entries = json['entries'];

    var index = entries.indexWhere((element) => element['id'] == entry.id());

    if (index >= 0) {
      entries.removeAt(index);
    }

    json['entries'] = entries;
  }

  @override
  Future<List<Entry>> getEntries() async {
    List<Entry> entries = [];

    if (json['entries'] != null) {
      for (Map<String, dynamic> element in json['entries']) {
        entries.add(JsonEntry(element));
      }
    }

    return entries;
  }

  @override
  Future<String> getName() async {
    return json['name'];
  }

  @override
  int id() {
    return json['id'];
  }

  @override
  Future<void> setName(String name) async {
    json['name'] = name;
  }

  @override
  Future<Map<String, dynamic>> toMap() async {
    return json;
  }
}
