import 'package:maps_prototype/data/data_sources/healthcare_provider_local_data_source.dart';
import 'package:maps_prototype/data/data_sources/healthcare_provider_remote_data_source.dart';
import 'package:maps_prototype/data/models/healthcare_provider.dart';

class HealthcareProviderRepository {
  const HealthcareProviderRepository({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  final HealthcareProviderLocalDataSource localDataSource;
  final HealthcareProviderRemoteDataSource remoteDataSource;

  Future<List<HealthcareProvider>> getAllDoctors() {
    // TODO: switch between remote/local data
    return localDataSource.getAllDoctors();
  }

  Future<HealthcareProvider> getDoctorDetails(int id) {
    // TODO: switch between remote/local data
    return localDataSource.getDoctorDetails(id);
  }
}
