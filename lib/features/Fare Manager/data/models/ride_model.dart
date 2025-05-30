import 'package:khaliha_3alina/features/Fare%20Manager/data/models/enum.dart';
import 'package:khaliha_3alina/features/Fare%20Manager/data/models/rider_model.dart';

class RideModel {
  final int indexAtDB;
  final String date;
  final VehicleType vehicleType;
  final List<RiderModel> riders;

  RideModel({
    required this.indexAtDB,
    required this.riders,
    required this.date,
    required this.vehicleType,
  });
}
