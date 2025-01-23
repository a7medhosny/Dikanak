import 'package:bloc/bloc.dart';
import 'package:dikanak/features/auth/data/models/user_model.dart';
import 'package:dikanak/features/person/data/repo/person_repo.dart';
import 'package:meta/meta.dart';

part 'person_state.dart';

class PersonCubit extends Cubit<PersonState> {
  PersonCubit(this.personRepo) : super(PersonInitial());
  PersonRepo personRepo;
  getPersonInfo() async {
    emit(GetPersonInfoLoading());
    try {
      var response = await personRepo.getPersonInfo();
      if (response['success'] == true) {
        UserModel person = response['data'];
        emit(GetPersonInfoSucess(person: person));
      } else {
        emit(GetPersonInfoFailure(
            message: response['message'] ?? 'Failed to get Carts'));
      }
    } catch (e) {
      emit(GetPersonInfoFailure(message: e.toString()));
    }
  }
}
