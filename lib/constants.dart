import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSetup {
  static const customMarker = 'assets/icons/map_custom_marker.svg';
  static const datasetPath =
      'assets/data/narodni-registr-poskytovatelu-zdravotnich-sluzeb-01-09-21.csv';
  static const datasetPathTest = 'assets/data/test.csv';

  /// Prague, main train station
  static const initialCoords = LatLng(50.08308000648528, 14.435443582943789);

  static const double defaultZoom = 13.0;
}
