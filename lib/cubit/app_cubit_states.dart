import 'package:equatable/equatable.dart';
import 'package:shopping_list_app/models/item.dart';

abstract class CubitStates extends Equatable {}

///First state of the application
class InitialState extends CubitStates {
  @override
  List<Object?> get props => [];
}

///Welcome state of the application
class WelcomeState extends CubitStates {
  @override
  List<Object?> get props => [];
}

///Loading state of the application (Shows a circular progress indicator)
class LoadingState extends CubitStates {
  @override
  List<Object?> get props => [];
}

///Loaded state of the application, trigs after fetching items from server
class LoadedState extends CubitStates {
  final List<Item> items;

  LoadedState({required this.items});

  @override
  List<Object?> get props => [items];
}

///State of adding item to the server
class AddItemState extends CubitStates {
  final List<Item> items;
  AddItemState({required this.items});
  @override
  List<Object?> get props => [items];
}

///Trigs when an error occured 
class ErrorState extends CubitStates {
  @override
  List<Object?> get props => [];
}
