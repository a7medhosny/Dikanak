import 'package:dikanak/features/home/data/model/favorite_product_model.dart';
import 'package:dikanak/features/home/data/model/product_model.dart';
import 'package:dikanak/features/home/logic/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: const Text(
            'Favorites',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          debugPrint("${context.read<HomeCubit>().favorites.length}");
          if (state is GetFavoritesFailure) {
            return _buildError(state.message);
          } else if (state is GetFavoritesLoading ||
              context.read<HomeCubit>().favorites.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetFavoritesSucess) {
            return _buildFavoritesGrid(state.favorites);
          } else {
            return _buildFavoritesGrid(context.read<HomeCubit>().favorites);
          }
        },
      ),
    );
  }

  Widget _buildFavoritesGrid(List<FavoriteProductModel> favorites) {
    if (favorites.isEmpty) {
      return const Center(
        child: Text(
          'No favorites yet!',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.8,
        ),
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final product = favorites[index];
          return Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  ),
                  child: Image.network(
                    product.image,
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.contain,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            '\$${product.price}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.green,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {
                              BlocProvider.of<HomeCubit>(context)
                                  .updateFavorites(
                                      productId: product.id.toString());
                            },
                            icon: const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
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
