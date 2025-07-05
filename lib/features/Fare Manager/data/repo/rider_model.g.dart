// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../models/rider_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RiderModelAdapter extends TypeAdapter<RiderModel> {
  @override
  final int typeId = 1;

  @override
  RiderModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RiderModel(
      name: fields[0] as String,
      farePerPerson: fields[1] as double,
      seatsPaidFor: fields[2] as int,
      amountPaid: fields[3] as double,
    );
  }

  @override
  void write(BinaryWriter writer, RiderModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.farePerPerson)
      ..writeByte(2)
      ..write(obj.seatsPaidFor)
      ..writeByte(3)
      ..write(obj.amountPaid);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RiderModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
