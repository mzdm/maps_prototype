import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'package:maps_prototype/constants.dart';
import 'package:maps_prototype/data/data_sources/healthcare_provider_data_source.dart';
import 'package:maps_prototype/data/models/healthcare_provider.dart';

class HealthcareProviderLocalDataSource implements HealthcareProviderDataSource {
  const HealthcareProviderLocalDataSource();

  @override
  Future<List<HealthcareProvider>> getAllDoctors() async {
    // TODO: Use DB instead CSV
    final input = await rootBundle.loadString(MapSetup.datasetPath);
    List<List<dynamic>> listOfValues = const CsvToListConverter().convert(input);
    return listOfValues
        .skip(1)
        // .take(1000)
        .map(
          (e) => HealthcareProvider(
            MistoPoskytovaniId: e[0].toString(),
            ZdravotnickeZarizeniId: e[1].toString(),
            NazevZarizeni: e[3].toString(),
            Obec: e[5].toString(),
            Psc: e[6].toString(),
            Ulice: e[7].toString(),
            CisloDomovniOrientacni: e[8].toString(),
            Kraj: e[9].toString(),
            PoskytovatelTelefon: e[14].toString(),
            PoskytovatelEmail: e[16].toString(),
            OborPece: e[27].toString(),
            Lat: e[31] == null ? null : double.tryParse(e[31].toString()),
            Lng: e[32] == null ? null : double.tryParse(e[32].toString()),
          ),
        )
        .toList();
  }

  @override
  Future<HealthcareProvider> getDoctorDetails(int id) async {
    // TODO: implement getDoctorDetails
    throw UnimplementedError();
  }
}
