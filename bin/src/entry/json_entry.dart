import 'entry.dart';

class JsonEntry implements Entry {
  final Map<String, dynamic> json;

  JsonEntry(this.json);

  @override
  Future<int> getAmount() async {
    return json['amount'];
  }

  @override
  Future<bool> getChecked() async {
    return json['checked'];
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
  Future<void> setAmount(int amount) async {
    json['amount'] = amount;
  }

  @override
  Future<void> setChecked(bool checked) async {
    json['checked'] = checked;
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
