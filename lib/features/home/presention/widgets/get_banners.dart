import 'package:dikanak/features/home/data/model/banner_model.dart';
import 'package:dikanak/features/home/logic/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetBanners extends StatefulWidget {
  const GetBanners({super.key});

  @override
  State<GetBanners> createState() => _GetBannersState();
}

class _GetBannersState extends State<GetBanners> {
  @override
  void initState() {
    super.initState();
    // استدعاء getBannerData عند فتح الشاشة
    context.read<HomeCubit>().getBannerData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeInitial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GetBannersSucess) {
          return _buildHorizontalBannersList(state.banners);
        } else if (state is GetBannersFailure) {
          return _buildError(state.message);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _buildHorizontalBannersList(List<BannerModel> banners) {
    return SizedBox(
      height: 150, // التحكم بارتفاع القائمة
      child: ListView.builder(
        scrollDirection: Axis.horizontal, // العرض أفقي
        itemCount: banners.length,
        itemBuilder: (context, index) {
          final banner = banners[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    banner.image,
                    width: 120, // التحكم بعرض الصورة
                    height: 120, // التحكم بارتفاع الصورة
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  banner.category != null
                      ? banner.category!.name
                      : 'No Category',
                  style: const TextStyle(fontSize: 12),
                  textAlign: TextAlign.center,
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
