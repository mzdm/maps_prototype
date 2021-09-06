import 'package:maps_prototype/data/models/healthcare_provider.dart';

abstract class HealthcareProviderDataSource {
  Future<List<HealthcareProvider>> getAllDoctors();

  Future<HealthcareProvider> getDoctorDetails(int id);
}
