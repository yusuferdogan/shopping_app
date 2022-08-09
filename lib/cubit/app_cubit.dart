import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_list_app/cubit/app_cubit_states.dart';
import 'package:shopping_list_app/models/item.dart';
import 'package:shopping_list_app/services/client.dart';

class AppCubits extends Cubit<CubitStates> {
  final Client client;
  late final List<Item> items;

  AppCubits({required this.client}) : super(InitialState()) {
    emit(WelcomeState());
  }

  ///Gets data from server and trig the loaded state
  getData() async {
    emit(LoadingState());
    items = await client.getItems();
    emit(LoadedState(items: items));
  }

  ///Just trig the loaded state with an existing item list
  loadData() {
    emit(LoadedState(items: items));
  }

  ///Adds new item to the shopping list.
  ///If succes trigs the Loaded state, ErrorState otherwise
  addItem(Item item) async {
    emit(LoadingState());
    bool result = await client.addItem(item);
    if (result) {
      items.add(item);
      emit(LoadedState(items: items));
    } else {
      emit(ErrorState());
    }
  }

  ///Uses to navigate to add item page.
  goAddItem() {
    emit(AddItemState(items: items));
  }

  ///Updates an item from the server
  updateItem(Item item) async {
    emit(LoadingState());
    bool result = await client.updateItem(item);
    if (result) {
      int index = items.indexOf(item);
      items[index].isDone = item.isDone;
      emit(LoadedState(items: items));
    } else {
      emit(ErrorState());
    }
  }

  ///Deletes an item from the server
  deleteItem(Item item) async {
    emit(LoadingState());
    bool result = await client.deleteItem(item);
    if (result) {
      items.remove(item);
      emit(LoadedState(items: items));
    } else {
      emit(ErrorState());
    }
  }
}
