import 'package:bloc/bloc.dart';
import 'package:dikanak/features/cart/presention/screens/carts_screen.dart';
import 'package:dikanak/features/favorite/presention/screens/favorites_screen.dart';
import 'package:dikanak/features/home/presention/screens/categories_screen.dart';
import 'package:dikanak/features/home/presention/screens/home_screen.dart';
import 'package:dikanak/features/person/presention/screens/person_screen.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(LayoutInitial());
  int bottomNavIndex = 0;
  List<Widget> screens = [
    HomeScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    CartScreen(),
    PersonScreen(),
  ];
  changeIndex({required int index}) {
    bottomNavIndex = index;
    emit(ChangeBottomNavIndex());
  }
}
