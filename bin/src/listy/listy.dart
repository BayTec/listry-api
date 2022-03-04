import '../entry/entry.dart';

abstract class Listy {
  int id();
  Future<String> getName();
  Future<void> setName(String name);
  Future<List<Entry>> getEntries();
  Future<Entry> createEntry(String name, int amount, bool checked);
  Future<void> deleteEntry(Entry entry);
  Future<Map<String, dynamic>> toMap();
}
