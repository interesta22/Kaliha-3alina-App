import 'rider_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:khaliha_3alina/features/Fare%20Manager/data/models/ride_model.dart';


class RideTypeAdaptor extends TypeAdapter<RideModel> {

  @override
  final int typeId = 0;

  @override
  RideModel read(BinaryReader reader) {
    return RideModel(
      indexAtDB: reader.readInt(),
      riders: reader.readList() as List<RiderModel>,
      date: reader.readString(),
      vehicleType: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, RideModel obj) {
    writer.writeInt(obj.indexAtDB);
    writer.writeList(obj.riders);
    writer.writeString(obj.date);
    writer.writeString(obj.vehicleType.toString());
  }

  RideModel decrementIndexAtDB(RideModel obj) {
    return RideModel(
      indexAtDB: obj.indexAtDB - 1,
      riders: obj.riders,
      date: obj.date,
      vehicleType: obj.vehicleType,
    );
  }
}