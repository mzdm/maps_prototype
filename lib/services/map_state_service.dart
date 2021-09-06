import 'package:flutter/material.dart';
import 'package:maps_prototype/data/models/healthcare_provider.dart';

// TODO: Filter doctors by specialization
class MapStateService with ChangeNotifier {
  List<HealthcareProvider> healthcareProviders = <HealthcareProvider>[];

  void add(HealthcareProvider healthcareProvider) {
    healthcareProviders.add(healthcareProvider);
    notifyListeners();
  }

  void addAll(List<HealthcareProvider> healthcareProviders) {
    this.healthcareProviders.addAll(healthcareProviders);
    notifyListeners();
  }

  void remove(HealthcareProvider healthcareProvider) {
    healthcareProviders.remove(healthcareProvider);
    notifyListeners();
  }

  void removeAll() {
    healthcareProviders.clear();
    notifyListeners();
  }
}
