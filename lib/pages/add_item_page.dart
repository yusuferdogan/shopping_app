import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_list_app/cubit/app_cubit.dart';
import 'package:shopping_list_app/cubit/app_cubit_states.dart';
import 'package:shopping_list_app/models/item.dart';

class AddItemPage extends StatelessWidget {
  const AddItemPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController? categoryController;
    TextEditingController? nameController;

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.save_sharp),
          onPressed: () async {
            if (nameController!.text == '') {
              //TODO; ERROR
            }

            Item item = Item(
                name: nameController!.text,
                category: categoryController!.text == ''
                    ? 'Uncategorized'
                    : categoryController!.text,
                isDone: false);

            BlocProvider.of<AppCubits>(context).addItem(item);
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Container(
            color: Colors.grey.withOpacity(0.5),
            height: 60,
          ),
        ),
        body: BlocBuilder<AppCubits, CubitStates>(
          builder: (context, state) {
            if (state is AddItemState) {
              var items = state.items;
              return SafeArea(
                child: Stack(
                  children: [
                    Positioned(
                      top: 10,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          BlocProvider.of<AppCubits>(context).loadData();
                        },
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Autocomplete<String>(
                            optionsBuilder: (textEditingValue) {
                              if (textEditingValue.text == '') {
                                return const Iterable<String>.empty();
                              }
                              var seen = <String>{};
                              items
                                  .where(
                                      (element) => seen.add(element.category))
                                  .toList();
                              return seen
                                  .where((element) => element
                                      .toLowerCase()
                                      .startsWith(
                                          textEditingValue.text.toLowerCase()))
                                  .toList();
                            },
                            fieldViewBuilder: (context, textEditingController,
                                focusNode, onFieldSubmitted) {
                              categoryController = textEditingController;
                              return TextField(
                                  controller: textEditingController,
                                  focusNode: focusNode,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    labelText: 'Category',
                                  ));
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Autocomplete<String>(
                            optionsBuilder: (textEditingValue) {
                              if (textEditingValue.text == '') {
                                return const Iterable<String>.empty();
                              }
                              var seen = <String>{};
                              items
                                  .where((element) => seen.add(element.name))
                                  .toList();
                              return seen
                                  .where((element) => element
                                      .toLowerCase()
                                      .startsWith(
                                          textEditingValue.text.toLowerCase()))
                                  .toList();
                            },
                            fieldViewBuilder: (context, textEditingController,
                                focusNode, onFieldSubmitted) {
                              nameController = textEditingController;
                              return TextField(
                                  controller: textEditingController,
                                  focusNode: focusNode,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    labelText: 'Name',
                                  ));
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            }
            return Container();
          },
        ));
  }
}
