import 'package:dikanak/features/home/logic/cubit/home_cubit.dart';
import 'package:dikanak/features/home/presention/widgets/get_banners.dart';
import 'package:dikanak/features/home/presention/widgets/get_categories.dart';
import 'package:dikanak/features/home/presention/widgets/get_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeCubit>(context)
      ..getBannerData()
      ..getCategories()..getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            'Dikanik',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const [
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
}
