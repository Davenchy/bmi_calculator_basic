import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BMIMemory extends ChangeNotifier {
  static late final SharedPreferences _prefs;

  double? _bmi;
  DateTime? _date;

  bool get hasData => _bmi != null && _date != null;

  double get bmi => _bmi!;

  DateTime get date => _date!;

  static Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> save(double bmi) async {
    _bmi = bmi;
    _date = DateTime.now();

    notifyListeners();

    await _prefs.setDouble('bmi', bmi);
    await _prefs.setInt('last', DateTime.now().millisecondsSinceEpoch);
  }

  bool load() {
    _bmi = _prefs.getDouble('bmi');
    final int? last = _prefs.getInt('last');

    notifyListeners();

    if (_bmi == null || last == null) {
      return false;
    }

    _date = DateTime.fromMillisecondsSinceEpoch(last);

    return true;
  }

  Future<bool> clear() {
    _bmi = null;
    _date = null;

    notifyListeners();

    return _prefs.clear();
  }

  void notify() => notifyListeners();
}
