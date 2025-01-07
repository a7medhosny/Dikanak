import 'package:dikanak/features/home/data/model/category_model.dart';
import 'package:dikanak/features/home/logic/cubit/home_cubit.dart';
import 'package:dikanak/features/layout/logic/cubits/cubit/layout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetCategories extends StatelessWidget {
  const GetCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is GetCategoriesFailure) {
          return _buildError(state.message);
        } else if (state is GetCategoriesLoading ||
            context.read<HomeCubit>().categories.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return _buildCategoriesList(
              context.read<HomeCubit>().categories, context);
        }
      },
    );
  }

  Widget _buildCategoriesList(List<CategoryModel> categories, context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Categories',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              InkWell(
                onTap: () {
                  BlocProvider.of<LayoutCubit>(context).changeIndex(index: 1);
                },
                child: Text(
                  'View All',
                  style: TextStyle(fontSize: 16, color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: Image.network(
                        category.image,
                        height: 80,
                        width: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      category.name,
                      style: const TextStyle(fontSize: 14),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildError(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          message,
          style: const TextStyle(color: Colors.red, fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
