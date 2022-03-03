import '../listy/listy.dart';

abstract class ListyStore {
  Future<List<Listy>> all();
  Future<Listy?> find(int id);
  Future<Listy> create(String name);
  Future<void> delete(Listy listy);
}
