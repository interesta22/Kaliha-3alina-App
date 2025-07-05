// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../models/ride_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RideModelAdapter extends TypeAdapter<RideModel> {
  @override
  final int typeId = 0;

  @override
  RideModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RideModel(
      indexAtDB: fields[0] as int,
      date: fields[1] as String,
      vehicleType: fields[2] as VehicleType,
      riders: (fields[3] as List).cast<RiderModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, RideModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.indexAtDB)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.vehicleType)
      ..writeByte(3)
      ..write(obj.riders);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RideModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
