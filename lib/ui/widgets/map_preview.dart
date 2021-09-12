import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_prototype/constants.dart';
import 'package:maps_prototype/data/models/healthcare_provider.dart';
import 'package:maps_prototype/data/models/specialization.dart';
import 'package:maps_prototype/services/map_state_service.dart';
import 'package:provider/provider.dart';

class MapPreview extends StatefulWidget {
  const MapPreview({Key? key}) : super(key: key);

  @override
  _MapPreviewState createState() => _MapPreviewState();
}

class _MapPreviewState extends State<MapPreview> {
  final mapController = Completer<GoogleMapController>();

  late final MapStateService mapStateService;

  static const initialCameraPos = CameraPosition(
    target: MapSetup.initialCoords,
    zoom: MapSetup.defaultZoom,
  );

  @override
  void initState() {
    super.initState();
    // _determinePosition();
    mapStateService = context.read<MapStateService>();
  }

  // void onMapCreated(GoogleMapController controller)
  // {
  //   mapController = controller;
  //   currlocation.onLocationChanged.listen((latLng) {
  //     mapController.animateCamera(
  //       CameraUpdate.newCameraPosition(
  //         CameraPosition(target: LatLng(latLng.latitude, latLng.longitude), zoom: 17),
  //       ),
  //     );
  //   });
  // }

  Future<void> animateToPos(CameraPosition cameraPosition) async {
    final GoogleMapController controller = await mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  Set<Marker> createMarkers({required List<HealthcareProvider> healthcareProviders}) {
    print(healthcareProviders.length);
    final markers = <Marker>{};
    for (final healthcareProvider in healthcareProviders) {
      if (healthcareProvider.Lat != null && healthcareProvider.Lng != null) {
        final lat = double.tryParse(healthcareProvider.Lat!);
        final lng = double.tryParse(healthcareProvider.Lng!);

        if (lat != null && lng != null) {
          markers.add(
            Marker(
              markerId: MarkerId(healthcareProvider.ZdravotnickeZarizeniId),
              position: LatLng(lat, lng),
              onTap: () {
                // TODO: doc detail
              },
              // TODO: custom Marker icon
              // icon: ,
              infoWindow: InfoWindow(
                title: 'ZdravotnickeZarizeniId: ${healthcareProvider.ZdravotnickeZarizeniId}',
                snippet: 'NazevZarizeni: ${healthcareProvider.NazevZarizeni}',
                onTap: () async {
                  await showDocDetailDialog(healthcareProvider);
                },
              ),
            ),
          );
        }
      }
    }
    return markers;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MapStateService>(
      builder: (context, value, child) {
        return Scaffold(
          body: GoogleMap(
            initialCameraPosition: initialCameraPos,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            onMapCreated: (GoogleMapController controller) async {
              mapController.complete(controller);
              final latLngBounds = await controller.getVisibleRegion();
              mapStateService.setVisibleRegion(latLngBounds);
            },
            onCameraIdle: () async {
              final GoogleMapController controller = await mapController.future;
              final latLngBounds = await controller.getVisibleRegion();
              mapStateService.setVisibleRegion(latLngBounds);
            },
            markers: createMarkers(healthcareProviders: value.healthcareProviders),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Padding(
            padding:
                EdgeInsets.fromLTRB(10.0, 10.0, 10.0, MediaQuery.of(context).size.height * 0.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FloatingActionButton(
                  onPressed: () async {
                    await showFilterDialogMenu(context);
                  },
                  backgroundColor: Colors.white,
                  child: const Icon(Icons.filter_alt, color: Colors.black87),
                ),
                FloatingActionButton(
                  onPressed: () async {
                    final currentPos = await _determinePosition();
                    final latLng = LatLng(currentPos.latitude, currentPos.longitude);
                    await animateToPos(CameraPosition(target: latLng, zoom: 17.0));
                  },
                  backgroundColor: Colors.white,
                  child: const Icon(Icons.my_location, color: Colors.black87),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<dynamic> showDocDetailDialog(HealthcareProvider healthcareProvider) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('ZdravotnickeZarizeniId:\n${healthcareProvider.ZdravotnickeZarizeniId}\n'),
                Text('NazevZarizeni:\n${healthcareProvider.NazevZarizeni}\n'),
                Text(
                    'Adresa:\n${healthcareProvider.Obec} ${healthcareProvider.Ulice} ${healthcareProvider.CisloDomovniOrientacni}\n'),
                Text('OborPece:\n${healthcareProvider.OborPece}\n'),
                Text('PoskytovatelEmail:\n${healthcareProvider.PoskytovatelEmail}\n'),
                Text('PoskytovatelTelefon:\n${healthcareProvider.PoskytovatelTelefon}\n'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Zavřít'),
            ),
          ],
        );
      },
    );
  }

  Future<dynamic> showFilterDialogMenu(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: StatefulBuilder(builder: (context, setState) {
            return SingleChildScrollView(
              child: Column(
                children: specializations
                    .map(
                      (specialization) => RadioListTile<Specialization>(
                        title: Text(specialization.categoryName),
                        value: specialization,
                        groupValue: mapStateService.currSpecialization,
                        onChanged: (Specialization? value) {
                          if (value != null) {
                            setState(() => mapStateService.setSpecialization(value));
                          }
                        },
                      ),
                    )
                    .toList(),
              ),
            );
          }),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Zavřít'),
            ),
          ],
        );
      },
    );
  }
}

Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  return Geolocator.getCurrentPosition();
}
