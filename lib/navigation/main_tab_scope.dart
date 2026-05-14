import 'package:flutter/material.dart';

/// Permet aux pages du layout professeur de changer d’onglet (ex. depuis le tableau de bord).
class MainTabScope extends InheritedWidget {
  final void Function(int index) goToTab;

  const MainTabScope({
    super.key,
    required this.goToTab,
    required super.child,
  });

  static MainTabScope? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MainTabScope>();
  }

  @override
  bool updateShouldNotify(MainTabScope oldWidget) => false;
}
