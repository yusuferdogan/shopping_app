import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_list_app/models/item.dart';
import 'package:shopping_list_app/services/api_helper.dart';

/// http Client class to process with Firebase rest api
class Client {
  /// Fetches all shopping list items from server.
  /// Returns the list of items.
  Future<List<Item>> getItems() async {
    List<Item> itemList = [];
    try {
      http.Response response = await http.get(Uri.parse("$apiUrl$getAllItems"));

      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.body);
        for (var x in jsonBody.keys) {
          itemList.add(Item.fromJson(jsonBody[x]));
        }
      }
    } catch (e) {}

    return itemList;
  }

  /// Adds new [item] to the shopping list.
  /// Returns true if successed, false otherwise
  Future<bool> addItem(Item item) async {
    bool result = false;
    try {
      http.Response response = await http.post(Uri.parse("$apiUrl$getAllItems"),
          body: json.encode(item.toJson()));

      if (response.statusCode == 200) {
        result = true;
      }
    } catch (e) {}
    return result;
  }

  ///Updates the existing [item] on the server
  /// Returns true if successed, false otherwise
  Future<bool> updateItem(Item item) async {
    bool result = false;
    try {
      http.Response response = await http.patch(
          Uri.parse("$apiUrl$getAllItems"),
          body: json.encode(item.toJson()));
      if (response.statusCode == 200) {
        result = true;
      }
    } catch (e) {
      result = false;
    }
    return result;
  }

  ///Deletes an [item] from the server
  /// Returns true if successed, false otherwise
  Future<bool> deleteItem(Item item) async {
    bool result = false;
    try {
      http.Response response = await http.delete(
          Uri.parse("$apiUrl$getAllItems"),
          body: json.encode(item.toJson()));
      if (response.statusCode == 200) {
        result = true;
      }
    } catch (e) {
      result = false;
    }
    return result;
  }
}
