import 'package:hive/hive.dart';

part '../repo/rider_model.g.dart';

@HiveType(typeId: 1)
class RiderModel {
  @HiveField(0)
  String name;

  @HiveField(1)
  double farePerPerson;

  @HiveField(2)
  int seatsPaidFor;

  @HiveField(3)
  double amountPaid;

  RiderModel({
    required this.name,
    required this.farePerPerson,
    required this.seatsPaidFor,
    required this.amountPaid,
  });

  double get totalFare => seatsPaidFor * farePerPerson;

  double get difference => amountPaid - totalFare;

  String get formattedTotalFare => totalFare.toStringAsFixed(2);
  String get formattedDifference => difference.toStringAsFixed(2);
  String get formattedAmountPaid => amountPaid.toStringAsFixed(2);
}
