
part of 'write_cubit.dart';

@immutable
sealed class WriteState {}

final class WriteInitial extends WriteState {}
final class WriteLoading extends WriteState {}
final class WriteSuccess extends WriteState {
  final String successMessage;

  WriteSuccess({required this.successMessage});
}
final class WriteFailed extends WriteState {
  final String errorMessage;

  WriteFailed({required this.errorMessage});
}

