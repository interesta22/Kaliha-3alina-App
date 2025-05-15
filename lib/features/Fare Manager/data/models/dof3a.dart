import 'package:objectbox/objectbox.dart';
import 'package:khaliha_3alina/features/Fare%20Manager/data/models/cycle.dart';

@Entity()
class Dof3a {
  @Id()
  int id = 0;

  int passengerNumber;  // إزالة الـ late هنا
  double fare;  // إزالة الـ late هنا
  double fareperSeat;  // إزالة الـ late هنا
  int paidFor;  // إزالة الـ late هنا
  double paid;  // إزالة الـ late هنا
  double remaining;  // إزالة الـ late هنا

  final cycle = ToOne<Cycle>(); // العلاقة مع Cycle

  Dof3a({
    required this.passengerNumber,
    required this.fare,
    required this.fareperSeat,
    required this.paidFor,
    required this.paid,
    required this.remaining,
  });
}
