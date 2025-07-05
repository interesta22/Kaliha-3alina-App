import 'package:hive/hive.dart';

part '../repo/enum.g.dart';

@HiveType(typeId: 2)
enum VehicleType {
  @HiveField(0)
  microbus,

  @HiveField(1)
  suzuki,

  @HiveField(2)
  other,
}

extension VehicleTypeExtension on VehicleType {
  String get name {
    switch (this) {
      case VehicleType.microbus:
        return 'Microbus';
      case VehicleType.suzuki:
        return 'Suzuki';
      case VehicleType.other:
        return 'other';
    }
  }
}
