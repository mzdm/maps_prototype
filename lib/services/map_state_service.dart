import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_prototype/data/models/healthcare_provider.dart';
import 'package:maps_prototype/data/models/specialization.dart';

class MapStateService with ChangeNotifier {
  final List<HealthcareProvider> _allHealthcareProviders = <HealthcareProvider>[];

  final List<HealthcareProvider> _visibleHealthcareProviders = <HealthcareProvider>[];

  Specialization currSpecialization = specializations[1];

  LatLngBounds? visibleRegion;

  List<HealthcareProvider> get healthcareProviders => _visibleHealthcareProviders;

  void _applyFilter() {
    _visibleHealthcareProviders
      ..clear()
      ..addAll(
        _allHealthcareProviders
            .where(
              (healthcareProvider) {
                if (currSpecialization.categoryName == 'Všechny') return true;
                return specializations
                    .firstWhere((e) => e.categoryName == currSpecialization.categoryName)
                    .specializations
                    .contains(healthcareProvider.OborPece);
              },
            )
            .where(
              (healthcareProvider) =>
                  visibleRegion == null ||
                  visibleRegion!.contains(
                    LatLng(
                      double.tryParse(healthcareProvider.Lat ?? '0.0') ?? 0.0,
                      double.tryParse(healthcareProvider.Lng ?? '0.0') ?? 0.0,
                    ),
                  ),
            )
            .toList(),
      );
  }

  void setVisibleRegion(LatLngBounds latLngBounds) {
    if (visibleRegion != latLngBounds) {
      visibleRegion = latLngBounds;
      _applyFilter();
      notifyListeners();
    }
  }

  void setSpecialization(Specialization specialization) {
    if (currSpecialization != specialization) {
      currSpecialization = specialization;
      _applyFilter();
      notifyListeners();
    }
  }

  void add(HealthcareProvider healthcareProvider) {
    _allHealthcareProviders.add(healthcareProvider);
    notifyListeners();
  }

  void addAll(List<HealthcareProvider> healthcareProviders) {
    _allHealthcareProviders.addAll(healthcareProviders);
    notifyListeners();
  }

  void remove(HealthcareProvider healthcareProvider) {
    _allHealthcareProviders.remove(healthcareProvider);
    notifyListeners();
  }

  void removeAll() {
    _allHealthcareProviders.clear();
    notifyListeners();
  }
}
