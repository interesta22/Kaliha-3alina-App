import 'package:hive/hive.dart';
import 'package:khaliha_3alina/features/Fare%20Manager/data/models/rider_model.dart';



class RiderModelAdapter extends TypeAdapter<RiderModel> {
  @override
  final int typeId = 1; // مهم يكون رقم مختلف عن أي adapter تاني

  @override
  RiderModel read(BinaryReader reader) {
    return RiderModel(
      name: reader.readString(),
      farePerPerson: reader.readDouble(),
      seatsPaidFor: reader.readInt(),
      amountPaid: reader.readDouble(),
    );
  }

  @override
  void write(BinaryWriter writer, RiderModel obj) {
    writer.writeString(obj.name);
    writer.writeDouble(obj.farePerPerson);
    writer.writeInt(obj.seatsPaidFor);
    writer.writeDouble(obj.amountPaid);
  }
}
