import 'package:flutter/foundation.dart';

// Mix-in [DiagnosticableTreeMixin] to have access to
// [debugFillProperties] for the devtool ignore: prefer_mixin

class MainState with ChangeNotifier, DiagnosticableTreeMixin {
  int _count = 0;

  int get currentCount => _count;
  // Add the rest of your state properties here.

  void incrementCounter() {
    _count++;
    notifyListeners();
  }

  // Makes `Counter` readable inside the devtools by listing all
  // of its properties.
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('count', currentCount));
  }
}
