part of 'person_cubit.dart';

@immutable
sealed class PersonState {}

final class PersonInitial extends PersonState {}

final class GetPersonInfoLoading extends PersonState {}

final class GetPersonInfoFailure extends PersonState {
  final String message;

  GetPersonInfoFailure({required this.message});
}

final class GetPersonInfoSucess extends PersonState {
  final UserModel person;
  GetPersonInfoSucess({required this.person});
}
