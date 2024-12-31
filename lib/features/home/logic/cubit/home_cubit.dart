import 'package:bloc/bloc.dart';
import 'package:dikanak/features/home/data/model/banner_model.dart';
import 'package:dikanak/features/home/data/repo/HomeRepo.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo homeRepo;

  HomeCubit(this.homeRepo) : super(HomeInitial());
  getBannerData() async {
    List<BannerModel> banners = [];
    emit(HomeLoading());
    try {
      var response = await homeRepo.getBannerData();
      if (response['success'] == true) {
        emit(GetBannersSucess(banners: response['data']));
      } else {
        emit(GetBannersFailure(response['message'] ?? 'Get Banners Failure'));
      }
    } catch (e) {}
  }
}
