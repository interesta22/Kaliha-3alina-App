enum VehicleType { microbus, suzuki, other }
extension VehicleTypeExtension on VehicleType {
  String get name {
    switch (this) {
      case VehicleType.microbus:
        return 'Microbus';
      case VehicleType.suzuki:
        return 'Suzuki';
      default:
        return 'other';
    }
  }
}