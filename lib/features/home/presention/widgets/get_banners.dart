import 'package:dikanak/features/home/data/model/banner_model.dart';
import 'package:dikanak/features/home/logic/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class GetBanners extends StatelessWidget {
  const GetBanners({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is GetBannersFailure) {
          return _buildError(state.message);
        } else if (state is HomeLoading || context.read<HomeCubit>().banners.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return _buildHorizontalBannersList(context.read<HomeCubit>().banners);
        }
      },
    );
  }

  Widget _buildHorizontalBannersList(List<BannerModel> banners) {
    final pageController = PageController();
    return Column(
      children: [
        SizedBox(
          height: 150,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: PageView.builder(
              controller: pageController,
              itemCount: banners.length,
              itemBuilder: (context, index) {
                return Image.network(
                  banners[index].image,
                  fit: BoxFit.fill,
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 15),
        SmoothPageIndicator(controller: pageController, count: banners.length),
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
