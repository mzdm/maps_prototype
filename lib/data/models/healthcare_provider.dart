import 'package:freezed_annotation/freezed_annotation.dart';

part 'healthcare_provider.freezed.dart';

part 'healthcare_provider.g.dart';

@freezed
class HealthcareProvider with _$HealthcareProvider {
  const factory HealthcareProvider({
    String? MistoPoskytovaniId,
    required String ZdravotnickeZarizeniId,
    String? Kod,
    String? NazevZarizeni,
    String? DruhZarizeni,
    String? Obec,
    String? Psc,
    String? Ulice,
    String? CisloDomovniOrientacni,
    String? Kraj,
    String? KrajCode,
    String? Okres,
    String? OkresCode,
    String? SpravniObvod,
    String? PoskytovatelTelefon,
    String? PoskytovatelFax,
    String? PoskytovatelEmail,
    String? PoskytovatelWeb,
    String? Ico,
    String? TypOsoby,
    String? PravniFormaKod,
    String? KrajCodeSidlo,
    String? OkresCodeSidlo,
    String? ObecSidlo,
    String? PscSidlo,
    String? UliceSidlo,
    String? CisloDomovniOrientacniSidlo,
    String? OborPece,
    String? FormaPece,
    String? DruhPece,
    String? Lat,
    String? Lng,
  }) = _HealthcareProvider;

  factory HealthcareProvider.fromJson(Map<String, dynamic> json) =>
      _$HealthcareProviderFromJson(json);
}
