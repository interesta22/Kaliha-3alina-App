import 'package:flutter/material.dart';
import 'package:khaliha_3alina/shared/spacing.dart';
import 'package:khaliha_3alina/core/theme/colors.dart';
import 'package:khaliha_3alina/features/Fare%20Manager/data/models/enum.dart';

class Seats extends StatefulWidget {
  final Function(String) onSeatToggle; // الباراميتر الجديد
  final VehicleType vehicleType;
  const Seats({
    super.key,
    required this.onSeatToggle,
    required this.vehicleType,
  });

  @override
  State<Seats> createState() => _MicrobusSeatsState();
}

class _MicrobusSeatsState extends State<Seats> {
  String? selectedSeat;

  @override
  Widget build(BuildContext context) {
    switch (widget.vehicleType) {
      case VehicleType.microbus:
        return microbusSeats();
      case VehicleType.suzuki:
        return suzukiSeats();
      case VehicleType.other:
        return const Center(child: Text('نوع غير مدعوم'));
    }
  }

  Column microbusSeats() {
    return Column(
      children: [
        // الصف الأمامي (السواق + كرسيين بدون أرقام)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // كرسي السواق برمز 'س'
              seatWidget(label: '', color: AppColors.secondary),
              horizentalSpacing(5),
              seatWidget(label: '', color: AppColors.secondary),
              horizentalSpacing(15),
              seatWidget(label: '', color: Colors.grey),
            ],
          ),
        ),
        verticaalSpacing(5),

        // 3 صفوف وسط (كرسي يمين + فراغ + كرسيين شمال)
        ...List.generate(3, (rowIndex) {
          int seat1 = rowIndex * 3 + 1;
          int seat2 = seat1 + 1;
          int seat3 = seat1 + 2;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
            child: Row(
              children: [
                // كرسي يمين
                seatWidget(label: '$seat3', color: getSeatColor('$seat3')),
                horizentalSpacing(15),
                // كرسيين شمال
                seatWidget(label: '$seat2', color: getSeatColor('$seat2')),
                horizentalSpacing(5),
                seatWidget(label: '$seat1', color: getSeatColor('$seat1')),
              ],
            ),
          );
        }),

        // الصف الخلفي (3 كراسي جنب بعض بمسافات متساوية)
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              seatWidget(label: '12', color: getSeatColor('12')), // شمال
              horizentalSpacing(10),
              seatWidget(label: '11', color: getSeatColor('11')), // وسط
              horizentalSpacing(10),
              seatWidget(label: '10', color: getSeatColor('10')), // يمين
            ],
          ),
        ),
      ],
    );
  }

  Column suzukiSeats() {
    return Column(
      children: [
        // الصف الأمامي (السواق + كرسيين بدون أرقام)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // كرسي السواق برمز 'س'
              seatWidget(label: '', color: AppColors.secondary),
              horizentalSpacing(20),
              seatWidget(label: '', color: Colors.grey),
            ],
          ),
        ),
        verticaalSpacing(5),

        // 3 صفوف وسط (كرسي يمين + فراغ + كرسيين شمال)
        ...List.generate(2, (rowIndex) {
          int seat1 = rowIndex * 3 + 1;
          int seat2 = seat1 + 1;
          int seat3 = seat1 + 2;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
            child: Row(
              children: [
                // كرسي يمين
                seatWidget(label: '$seat3', color: getSeatColor('$seat3')),
                horizentalSpacing(10),
                // كرسيين شمال
                seatWidget(label: '$seat2', color: getSeatColor('$seat2')),
                horizentalSpacing(10),
                seatWidget(label: '$seat1', color: getSeatColor('$seat1')),
              ],
            ),
          );
        }),
      ],
    );
  }

  Color getSeatColor(String label) {
    return selectedSeat == label ? AppColors.light : AppColors.lightGrey;
  }

  Widget seatWidget({required String label, required Color color}) {
    if (color == Colors.transparent) {
      return const SizedBox(width: 30, height: 40);
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedSeat = label;
        });
        widget.onSeatToggle(label); // استخدام الباراميتر
      },
      child: SizedBox(
        width: 30,
        height: 40,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // مسند الرأس
            Positioned(
              top: 0,
              child: Container(
                width: 24,
                height: 9,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.85),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(7),
                  ),
                  border: Border.all(color: Colors.black, width: 0.7),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 1.5,
                      offset: const Offset(0, 0.7),
                    ),
                  ],
                ),
              ),
            ),
            // ظهر الكرسي
            Positioned(
              top: 7,
              child: Container(
                width: 30,
                height: 21,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.92),
                  borderRadius: BorderRadius.circular(7),
                  border: Border.all(color: Colors.black, width: 0.7),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 2.25,
                      offset: const Offset(0, 1.5),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 11.25,
                      shadows: [
                        Shadow(
                          color: Colors.black26,
                          blurRadius: 1.5,
                          offset: Offset(0, 0.7),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // القعدة
            Positioned(
              bottom: 7,
              child: Container(
                width: 28.5,
                height: 12,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(5.25),
                  border: Border.all(color: Colors.black, width: 0.7),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 1.5,
                      offset: const Offset(0, 0.7),
                    ),
                  ],
                ),
              ),
            ),
            // الرجلين
            Positioned(
              bottom: 0,
              left: 6,
              child: Container(
                width: 4.5,
                height: 7.5,
                decoration: BoxDecoration(
                  color: Colors.grey[700]!,
                  borderRadius: BorderRadius.circular(1.5),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 6,
              child: Container(
                width: 4.5,
                height: 7.5,
                decoration: BoxDecoration(
                  color: Colors.grey[700]!,
                  borderRadius: BorderRadius.circular(1.5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
