import 'package:dikanak/features/home/data/model/product_model.dart';
import 'package:dikanak/features/home/logic/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetProducts extends StatelessWidget {
  const GetProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is GetProductsFailure || state is UpdateFavoritesFailure) {
          final message = (state as dynamic).message ?? 'An error occurred';
          return _buildError(message);
        } else if (state is GetProductsLoading ||
            context.read<HomeCubit>().products.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is FilterProductsSucess) {
          return _buildProductsGrid(state.filterProducts);
        } else {
          return _buildProductsGrid(context.read<HomeCubit>().products);
        }
      },
    );
  }

  Widget _buildProductsGrid(List<ProductModel> products) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Products',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                'View All',
                style: TextStyle(fontSize: 16, color: Colors.blue),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
              height: 500,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.8,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  final isFavorite = context
                          .read<HomeCubit>()
                          .favoritesStatus[product.id.toString()] ??
                      false;

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
                                    icon: Icon(
                                      isFavorite
                                          ? Icons.favorite
                                          : Icons.favorite_outline,
                                      color: isFavorite ? Colors.red : null,
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
              )),
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
