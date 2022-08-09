import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_list_app/models/item.dart';
import 'package:shopping_list_app/services/client.dart';

void main() {
  final item = Item(name: "testItem", category: "testCategory", isDone: false);
  final client = Client();
  group("Client test", () {
    test("Add item test", () async {
      bool result = await client.addItem(item);
      expect(result, true);
    });

    test("Get all items", () async {
      var items = await client.getItems();
      expect(items.length, 1);
    });

    test("Delete one item", () async {
      bool result = await client.deleteItem(item);
      expect(result, true);
    });
  });
}
