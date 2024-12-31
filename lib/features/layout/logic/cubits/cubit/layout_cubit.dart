import 'package:bloc/bloc.dart';
import 'package:dikanak/features/home/presention/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(LayoutInitial());
  int bottomNavIndex = 0;
  List<Widget> screens = [
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
  ];
  changeIndex({required int index}) {
    bottomNavIndex = index;
    emit(ChangeBottomNavIndex());
  }
}
