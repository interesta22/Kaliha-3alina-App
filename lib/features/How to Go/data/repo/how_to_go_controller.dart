import 'dart:convert';
import 'dart:developer';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:khaliha_3alina/features/How%20to%20Go/data/models/route_model.dart';
// how_to_go_controller.dart

class HowToGoRepository {
  final FlutterTts _tts = FlutterTts();
  final List<RouteModel> _allRoutes = [];

  final List<String> governorates = [];
  final List<String> locations = [];

  Map<String, List<RouteModel>> routesMap = {};

  String? selectedGovernorate;
  String? from;
  String? to;
  dynamic result;


  late void Function(VoidCallback fn) _setState;

  void init(BuildContext context, void Function(VoidCallback fn) setState) {

    _setState = setState;
    _loadRoutes();
  }

  Future<void> _loadRoutes() async {
    try {
      final data = await rootBundle.loadString(
        'lib/core/assets/jsons/mwasalat_egypt_mock.json',
      );
      final jsonResult = json.decode(data);
      if (jsonResult is List) {
        final parsedRoutes =
            jsonResult
                .whereType<Map<String, dynamic>>()
                .map((e) => RouteModel.fromJson(e))
                .toList();

        _allRoutes.addAll(parsedRoutes);
        final uniqueGovs =
            _allRoutes
                .map((e) => e.governorate ?? '')
                .where((e) => e.isNotEmpty)
                .toSet()
                .toList()
              ..sort();

        _setState(() {
          governorates
            ..clear()
            ..addAll(uniqueGovs);
        });
      } else {
        log("Error: JSON is not a List.");
      }
    } catch (e) {
      log("Error loading routes: $e");
      _speak("حدث خطأ أثناء تحميل البيانات. الرجاء المحاولة لاحقًا.");
    }
  }

  void _filterLocations(String governorate) {
    final locs =
        _allRoutes
            .where((e) => e.governorate == governorate)
            .expand((e) => [e.from, e.to])
            .toSet()
            .toList()
          ..sort();

    _setState(() {
      locations
        ..clear()
        ..addAll(locs);
    });
  }

  void onGovernorateChanged(String? val) {
    _setState(() {
      selectedGovernorate = val;
      from = null;
      to = null;
      result = null;
    });
    if (val != null) _filterLocations(val);
  }

  void onFromChanged(String? val) {
    _setState(() => from = val);
  }

  void onToChanged(String? val) {
    _setState(() => to = val);
  }

  void buildRoutesMap() {
    routesMap.clear();
    for (var route in _allRoutes) {
      routesMap.putIfAbsent(route.from, () => []).add(route);
    }
  }

  List<RouteModel>? findPath(String start, String goal) {
    Queue<List<RouteModel>> queue = Queue();
    Set<String> visited = {};

    if (!routesMap.containsKey(start)) return null;

    for (var route in routesMap[start]!) {
      queue.add([route]);
    }

    while (queue.isNotEmpty) {
      var path = queue.removeFirst();
      var lastStop = path.last.to;

      if (lastStop == goal) {
        return path;
      }

      if (visited.contains(lastStop)) continue;
      visited.add(lastStop);

      if (routesMap.containsKey(lastStop)) {
        for (var nextRoute in routesMap[lastStop]!) {
          if (!visited.contains(nextRoute.to)) {
            queue.add([...path, nextRoute]);
          }
        }
      }
    }

    return null;
  }

  void search() {
    if (from == null || to == null || selectedGovernorate == null) {
      _speak("من فضلك اختار كل البيانات.");
      return;
    }

    buildRoutesMap();

    final directRoute = _allRoutes.firstWhere(
      (r) =>
          r.governorate == selectedGovernorate && r.from == from && r.to == to,
      orElse: () => RouteModel.empty(),
    );

    if (directRoute.isNotEmpty) {
      _setState(() => result = directRoute);
      _speak("اركب ${directRoute.notes}، والسعر ${directRoute.price} جنيه.");
      return;
    }

    final path = findPath(from!, to!);

    // ✅ بعد (خزّنا الطريق المختصر في result)
    if (path != null && path.isNotEmpty) {
      String message = "مفيش طريق مباشر، بس تقدر تروح كده: ";
      for (var route in path) {
        message +=
            "اركب من ${route.from} لـ ${route.to} (${route.notes})، بسعر ${route.price} جنيه. ";
      }
      _setState(() => result = path); // ✅ هنا بنخزن List<RouteModel>
      _speak(message);
    }
  }

  void reset() {
    _setState(() {
      selectedGovernorate = null;
      from = null;
      to = null;
      result = null;
      locations.clear();
    });
    _speak("تم إعادة تعيين البحث.");
  }

  Future<void> _speak(String text) async {
    await _tts.speak(text);
  }
}
