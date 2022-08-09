///Represents items in the list
class Item {
  String name;
  String category;
  bool isDone;

  Item({required this.name, required this.category, required this.isDone});

  ///Creates an [Item] instace from json
  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
        name: json['name'], category: json['category'], isDone: json['isDone']);
  }

  ///Converts [Item] object to json format.
  Map<String, dynamic> toJson() {
    return {"name": name, "category": category, "isDone": isDone};
  }
}
