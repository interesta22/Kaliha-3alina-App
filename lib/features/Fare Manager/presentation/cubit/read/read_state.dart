part of 'read_cubit.dart';

@immutable
sealed class ReadState {}

final class ReadInitial extends ReadState {}
final class ReadLoading extends ReadState {}
final class ReadSuccess extends ReadState {
  final List<RideModel> ridesList;

  ReadSuccess({required this.ridesList});
}
final class ReadFailed extends ReadState {
  final String errorMessage;

  ReadFailed({required this.errorMessage});
}
