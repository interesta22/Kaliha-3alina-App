import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khaliha_3alina/core/constants/hive_const.dart' show HiveConstants;
import 'package:khaliha_3alina/features/Fare%20Manager/data/models/ride_model.dart';
import 'package:khaliha_3alina/features/Fare%20Manager/data/models/enum.dart' show VehicleType;


part 'read_state.dart';

class ReadCubit extends Cubit<ReadState> {
  static ReadCubit get(context) => BlocProvider.of(context);
  ReadCubit() : super(ReadInitial());

  final Box _hiveBox = Hive.box(HiveConstants.ridesBox);

  VehicleFilter vehicleFilter = VehicleFilter.all;
  SortingType sortingType = SortingType.descending;

  void setVehicleFilter(VehicleFilter filter) {
    vehicleFilter = filter;
  }
  void setSortingType(SortingType type) {
    sortingType = type;
  }
  void getRides() {
    emit(ReadLoading());
    try {
      final List<RideModel> ridesList = _hiveBox.get(HiveConstants.ridesList).cast<RideModel>().toList();
      _removeUnwantedRides(ridesList);
      _sortRides(ridesList);
      emit(ReadSuccess(ridesList: ridesList));

      // You can now use filteredRides for further processing if needed
    } catch (e) {
      emit(ReadFailed(errorMessage: e.toString()));
    }
  }
  void _sortRides(List<RideModel> ridesList) {
    if (sortingType == SortingType.ascending) {
      ridesList.sort((a, b) => a.date.compareTo(b.date));
    } else {
      ridesList.sort((a, b) => b.date.compareTo(a.date));
    }
  }
  void _removeUnwantedRides(List<RideModel> ridesList) {
    switch (vehicleFilter) {
      case VehicleFilter.all:
        return;
      case VehicleFilter.microbusOnly:
        ridesList.removeWhere((ride) => ride.vehicleType != VehicleType.microbus);
      case VehicleFilter.suzukiOnly:
        ridesList.removeWhere((ride) => ride.vehicleType != VehicleType.suzuki);
      case VehicleFilter.otherOnly:
        ridesList.removeWhere((ride) => ride.vehicleType == VehicleType.microbus || ride.vehicleType == VehicleType.suzuki);
    }
  }
}
enum VehicleFilter { microbusOnly, suzukiOnly, otherOnly, all }
enum SortingType { ascending, descending }