import 'package:hive/hive.dart';
import 'package:khaliha_3alina/features/Fare%20Manager/data/models/enum.dart';
import 'package:khaliha_3alina/features/Fare%20Manager/data/models/rider_model.dart';

part '../repo/ride_model.g.dart';

@HiveType(typeId: 0)
class RideModel {
  @HiveField(0)
  int indexAtDB;

  @HiveField(1)
  String date;

  @HiveField(2)
  VehicleType vehicleType;

  @HiveField(3)
  List<RiderModel> riders;

  RideModel({
    required this.indexAtDB,
    required this.date,
    required this.vehicleType,
    required this.riders,
  });
}
