import 'package:bloc/bloc.dart';
import 'package:dikanak/features/auth/data/models/user_model.dart';
import 'package:meta/meta.dart';

import '../../../data/repo/myrepo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final Myrepo repository;

  AuthCubit(this.repository) : super(AuthInitial());

  /// Handles user registration
  Future<void> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      final response = await repository.register(
        name: name,
        email: email,
        phone: phone,
        password: password,
      );

      if (response['success'] == true) {
        emit(RegisterSuccess());
      } else {
        emit(AuthFailure(response['message'] ?? 'Registration failed'));
      }
    } catch (e) {
      emit(AuthFailure('An unexpected error occurred: ${e.toString()}'));
    }
  }

  /// Handles user login
  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      final response = await repository.login(
        email: email,
        password: password,
      );

      if (response['success'] == true) {
        emit(LoginSuccess(userModel: UserModel.fromJson(response["data"])));
      } else {
        emit(AuthFailure(response['message'] ?? 'Login failed'));
      }
    } catch (e) {
      emit(AuthFailure('An unexpected error occurred: ${e.toString()}'));
    }
  }
}
