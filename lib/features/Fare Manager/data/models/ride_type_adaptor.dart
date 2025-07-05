import 'package:hive/hive.dart';
import 'package:khaliha_3alina/features/Fare%20Manager/data/models/enum.dart';
import 'package:khaliha_3alina/features/Fare%20Manager/data/models/ride_model.dart';
import 'package:khaliha_3alina/features/Fare%20Manager/data/models/rider_model.dart';

class RideTypeAdapter extends TypeAdapter<RideModel> {
  @override
  final int typeId = 0;

  @override
  RideModel read(BinaryReader reader) {
    return RideModel(
      indexAtDB: reader.readInt(),
      date: reader.readString(),
      vehicleType: VehicleType.values.firstWhere(
        (e) => e.name == reader.readString(),
      ),
      riders: (reader.readList()).cast<RiderModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, RideModel obj) {
    writer.writeInt(obj.indexAtDB);
    writer.writeString(obj.date);
    writer.writeString(obj.vehicleType.name);
    writer.writeList(obj.riders);
  }

  RideModel decrementIndexAtDB(RideModel obj) {
    return RideModel(
      indexAtDB: obj.indexAtDB - 1,
      date: obj.date,
      vehicleType: obj.vehicleType,
      riders: obj.riders,
    );
  }
}
