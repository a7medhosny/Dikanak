import 'package:dikanak/features/home/logic/cubit/home_cubit.dart';
import 'package:dikanak/features/home/presention/widgets/get_banners.dart';
import 'package:dikanak/features/home/presention/widgets/get_categories.dart';
import 'package:dikanak/features/home/presention/widgets/get_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  TextEditingController searchControlller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            'Dikanak',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildSearchBar(context),
            GetBanners(),
            SizedBox(
              height: 20,
            ),
            GetCategories(),
            SizedBox(
              height: 20,
            ),
            GetProducts(),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  _buildSearchBar(context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        controller: searchControlller,
        onChanged: (input) {
          BlocProvider.of<HomeCubit>(context).getFilterProducts(input);
        },
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.search),
            suffixIcon: IconButton(
                onPressed: () {
                  searchControlller.text = "";
                  BlocProvider.of<HomeCubit>(context).getFilterProducts("");
                },
                icon: Icon(Icons.close)),
            hintText: 'Search...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(color: Colors.grey, width: 1),
            ),
            fillColor: Colors.grey.withValues(alpha: 0.3),
            filled: true),
      ),
    );
  }
}
