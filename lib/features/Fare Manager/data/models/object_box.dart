import 'package:khaliha_3alina/objectbox.g.dart';
import 'package:khaliha_3alina/features/Fare%20Manager/data/models/cycle.dart';
import 'package:khaliha_3alina/features/Fare%20Manager/data/models/dof3a.dart';




class ObjectBox {
  late final Store _store;
  late final Box<Cycle> _cycleBox;

  ObjectBox._create(this._store) {
    _cycleBox = Box<Cycle>(_store);
  }

  static Future<ObjectBox> create() async {
    final store = await openStore();  // فتح قاعدة البيانات باستخدام openStore
    return ObjectBox._create(store);
  }

  // الحصول على دورة باستخدام ID
  Cycle? getCycleById(int id) {
    return _cycleBox.get(id);
  }

  // إضافة دُفعة جديدة إلى الدورة
  void addDof3a(Cycle cycle, Dof3a dof3a) {
    cycle.dof3at.add(dof3a);
    _cycleBox.put(cycle);  // حفظ الدورة بعد إضافة الدفعة
  }

  // الحصول على كل الدورات
  List<Cycle> getAllCycles() {
    return _cycleBox.getAll();  // إرجاع جميع الدورات
  }

  // الحصول على دفعات دورة معينة باستخدام stream
  Stream<List<Dof3a>> getDof3at() {
    return _cycleBox.query()
      .watch(triggerImmediately: true)
      .map((query) => query.find())
      .map((cycles) => cycles.expand((cycle) => cycle.dof3at).toList());
  }
}
