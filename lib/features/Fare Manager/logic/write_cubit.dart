import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khaliha_3alina/core/constants/hive_const.dart';
import 'package:khaliha_3alina/features/Fare%20Manager/data/models/ride_model.dart';

part 'write_state.dart';

class WriteCubit extends Cubit<WriteState> {
  static WriteCubit get(context) => BlocProvider.of(context);
  WriteCubit() : super(WriteInitial());
  final Box _hiveBox = Hive.box(HiveConstants.ridesBox);

  void addRide(RideModel ride) {
    emit(WriteLoading());
    try {
      final List<RideModel> ridesList = _getRidesFromDatabase;

      // 👇 أضف indexAtDB بناءً على الطول الحالي للليست
      ride.indexAtDB = ridesList.length;

      ridesList.add(ride);
      _hiveBox.put(HiveConstants.ridesList, ridesList);
      emit(WriteSuccess(successMessage: 'تم حفظ مشوارك بنجاح'));
    } catch (e) {
      emit(WriteFailed(errorMessage: e.toString()));
    }
  }

  void deleteRide(int index) {
    emit(WriteLoading());
    try {
      final List<RideModel> ridesList = _getRidesFromDatabase;
      ridesList.removeAt(index);
      _hiveBox.put(HiveConstants.ridesList, ridesList);
      emit(WriteSuccess(successMessage: 'تم حذف المشوار بنجاح'));
    } catch (e) {
      emit(WriteFailed(errorMessage: e.toString()));
    }
  }

  void updateRide(int index, RideModel updatedRide) {
    emit(WriteLoading());
    try {
      final List<RideModel> ridesList = _getRidesFromDatabase;
      ridesList[index] = updatedRide;
      _hiveBox.put(HiveConstants.ridesList, ridesList);
      emit(WriteSuccess(successMessage: 'تم تحديث المشوار بنجاح'));
    } catch (e) {
      emit(WriteFailed(errorMessage: e.toString()));
    }
  }

  void deleteMultipleRides(List<RideModel> ridesToDelete) {
    emit(WriteLoading());
    try {
      final List<RideModel> ridesList = _getRidesFromDatabase;

      // احذف الرحلات بناءً على indexAtDB لكل مشوار
      ridesList.removeWhere(
        (ride) => ridesToDelete.any(
          (toDelete) => toDelete.indexAtDB == ride.indexAtDB,
        ),
      );

      _hiveBox.put(HiveConstants.ridesList, ridesList);
      emit(
        WriteSuccess(
          successMessage: 'تم حذف ${ridesToDelete.length} مشوار بنجاح',
        ),
      );
    } catch (e) {
      emit(WriteFailed(errorMessage: e.toString()));
    }
  }

  void deleteAllRides() {
    emit(WriteLoading());
    try {
      _hiveBox.delete(HiveConstants.ridesList);
      emit(WriteSuccess(successMessage: 'تم مسح المشاوير بنجاح'));
    } catch (e) {
      emit(WriteFailed(errorMessage: e.toString()));
    }
  }

  List<RideModel> get _getRidesFromDatabase {
    final list = _hiveBox.get(HiveConstants.ridesList);
    if (list == null) return [];
    return List<RideModel>.from(list);
  }
}
