import 'dof3a.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Cycle {
  @Id()
  int id = 0;

  late String date;
  late String transportType;

  @Backlink('cycle') // تربط Dof3a بـ Cycle
  final dof3at = ToMany<Dof3a>();

  Cycle({
    this.id = 0,
    required this.date,
    required this.transportType,
  });
}
