class RouteModel {
  final String from;
  final String to;
  final String price;
  final String method;
  final String? governorate;
  final String? notes;

  RouteModel({
    required this.from,
    required this.to,
    required this.price,
    required this.method,
    this.governorate,
    this.notes,
  });

  factory RouteModel.fromJson(Map<String, dynamic> json) {
    return RouteModel(
      from: json['from'].toString(),
      to: json['to'].toString(),
      price: json['price'].toString(),
      method: json['method'].toString(),
      governorate: json['governorate']?.toString(),
      notes: json['notes']?.toString(),
    );
  }

  factory RouteModel.empty() => RouteModel(
    from: '',
    to: '',
    price: '',
    method: '',
    governorate: '',
    notes: '',
  );

  bool get isNotEmpty => from.isNotEmpty && to.isNotEmpty;
}