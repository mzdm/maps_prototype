import 'package:http/http.dart' as http;
import 'package:maps_prototype/data/models/healthcare_provider.dart';

import 'healthcare_provider_data_source.dart';

class HealthcareProviderRemoteDataSource implements HealthcareProviderDataSource {
  const HealthcareProviderRemoteDataSource({required this.client});

  final http.Client client;

  @override
  Future<List<HealthcareProvider>> getAllDoctors() {
    // TODO: implement getAllDoctors
    throw UnimplementedError();
  }

  @override
  Future<HealthcareProvider> getDoctorDetails(int id) {
    // TODO: implement getDoctorDetails
    throw UnimplementedError();
  }
}
