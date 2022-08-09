import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:shopping_list_app/cubit/app_cubit.dart';
import 'package:shopping_list_app/cubit/app_cubit_states.dart';
import 'package:shopping_list_app/models/item.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  late final List<Item>? itemList;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () async {
            await BlocProvider.of<AppCubits>(context).goAddItem();
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Container(
            color: Colors.grey.withOpacity(0.7),
            height: 60,
          ),
        ),
        body: BlocBuilder<AppCubits, CubitStates>(
          builder: ((context, state) {
            if (state is LoadedState) {
              itemList = state.items;
              return _body(itemList!);
            } else {
              return Container();
            }
          }),
        ));
  }

  Widget _body(List<Item> items) {
    return SafeArea(
      child: GroupedListView<Item, String>(
        elements: items,
        groupBy: (element) => element.category,
        useStickyGroupSeparators: true,
        groupSeparatorBuilder: (String value) {
          return Padding(
            padding: const EdgeInsets.all(8),
            child: Text(value),
          );
        },
        itemBuilder: (context, element) {
          return Card(
            elevation: 8.0,
            margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            child: SizedBox(
              child: Slidable(
                endActionPane:
                    ActionPane(motion: const ScrollMotion(), children: [
                  SlidableAction(
                    flex: 2,
                    icon: Icons.delete,
                    label: 'Delete',
                    foregroundColor: Colors.red,
                    onPressed: (context) async {
                      BlocProvider.of<AppCubits>(context).deleteItem(element);
                    },
                  ),
                  !element.isDone
                      ? SlidableAction(
                          flex: 2,
                          icon: Icons.done,
                          label: 'Mark as done',
                          foregroundColor: Colors.blueAccent,
                          onPressed: (context) async {
                            element.isDone = true;
                            BlocProvider.of<AppCubits>(context)
                                .updateItem(element);
                          },
                        )
                      : SlidableAction(
                          flex: 2,
                          icon: Icons.undo,
                          label: 'Undo',
                          foregroundColor: Colors.blueAccent,
                          onPressed: (context) async {
                            element.isDone = false;
                            BlocProvider.of<AppCubits>(context)
                                .updateItem(element);
                          },
                        ),
                ]),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                  leading: CircleAvatar(
                    child: Text(element.name.characters.first.toUpperCase()),
                  ),
                  trailing: element.isDone
                      ? const Icon(
                          Icons.done,
                          color: Colors.blueAccent,
                        )
                      : const SizedBox(
                          width: 0,
                          height: 0,
                        ),
                  title: Text(
                    element.name,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
