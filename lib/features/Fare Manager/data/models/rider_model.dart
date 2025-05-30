class RiderModel {

  String name; 
  double farePerPerson; 
  int seatsPaidFor;
  double amountPaid;  



  RiderModel({
    required this.name,
    required this.farePerPerson,
    required this.seatsPaidFor,
    required this.amountPaid,
  });
  double get totalFare => seatsPaidFor * farePerPerson;
  double get difference => amountPaid - totalFare;
  String get formattedTotalFare => totalFare.toStringAsFixed(2);
  String get formattedDifference => difference.toStringAsFixed(2);
  String get formattedAmountPaid => amountPaid.toStringAsFixed(2);
}
