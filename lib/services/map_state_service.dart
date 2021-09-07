import 'package:flutter/material.dart';
import 'package:maps_prototype/data/models/healthcare_provider.dart';
import 'package:maps_prototype/data/models/specialization.dart';

class MapStateService with ChangeNotifier {
  final List<HealthcareProvider> _healthcareProviders = <HealthcareProvider>[];

  Specialization currSpecialization = specializations.first;

  List<HealthcareProvider> get healthcareProviders {
    if (currSpecialization.categoryName == 'Všechny') return _healthcareProviders;
    return _healthcareProviders
        .where((healthcareProvider) => specializations
            .firstWhere((e) => e.categoryName == currSpecialization.categoryName)
            .specializations
            .contains(healthcareProvider.OborPece))
        .toList();
  }

  void setSpecialization(Specialization specialization) {
    if (currSpecialization != specialization) {
      currSpecialization = specialization;
      notifyListeners();
    }
  }

  void add(HealthcareProvider healthcareProvider) {
    _healthcareProviders.add(healthcareProvider);
    notifyListeners();
  }

  void addAll(List<HealthcareProvider> healthcareProviders) {
    _healthcareProviders.addAll(healthcareProviders);
    notifyListeners();
  }

  void remove(HealthcareProvider healthcareProvider) {
    _healthcareProviders.remove(healthcareProvider);
    notifyListeners();
  }

  void removeAll() {
    _healthcareProviders.clear();
    notifyListeners();
  }
}
