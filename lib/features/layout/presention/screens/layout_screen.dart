import 'package:dikanak/features/layout/logic/cubits/cubit/layout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LayoutCubit, LayoutState>(
      builder: (context, state) {
        final layoutCubit = context.read<LayoutCubit>();

        return Scaffold(
          bottomNavigationBar: _buildBottomNavigationBar(layoutCubit),
          body: layoutCubit.screens[layoutCubit.bottomNavIndex],
        );
      },
    );
  }

  Widget _buildBottomNavigationBar(LayoutCubit cubit) {
    return BottomNavigationBar(
      currentIndex: cubit.bottomNavIndex,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        cubit.changeIndex(index: index);
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(
            icon: Icon(Icons.category), label: "Categories"),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorites"),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Cart"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
      ],
    );
  }
}
