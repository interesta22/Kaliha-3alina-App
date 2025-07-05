// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../models/enum.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VehicleTypeAdapter extends TypeAdapter<VehicleType> {
  @override
  final int typeId = 2;

  @override
  VehicleType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return VehicleType.microbus;
      case 1:
        return VehicleType.suzuki;
      case 2:
        return VehicleType.other;
      default:
        return VehicleType.microbus;
    }
  }

  @override
  void write(BinaryWriter writer, VehicleType obj) {
    switch (obj) {
      case VehicleType.microbus:
        writer.writeByte(0);
        break;
      case VehicleType.suzuki:
        writer.writeByte(1);
        break;
      case VehicleType.other:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VehicleTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
