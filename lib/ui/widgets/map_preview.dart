import 'dart:async';

import 'package:flutter/material.dart';
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

  // static const CameraPosition _kMovePos = CameraPosition(
  //   bearing: 192.8334901395799,
  //   target: LatLng(50.1058258468836, 14.49318803997208),
  //   zoom: 19.151926040649414,
  // );

  // Future<void> _goToTheLake() async {
  //   final GoogleMapController controller = await mapController.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(_kMovePos));
  // }

  Set<Marker> createMarkers({
    required List<HealthcareProvider> healthcareProviders,
  }) {
    if (healthcareProviders.isEmpty) {
      return {};
    }

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
                // context.read<MapStateService>().remove(healthcareProvider);
              },
              // TODO: custom Marker icon
              // icon: ,
              infoWindow: InfoWindow(
                title: 'ZdravotnickeZarizeniId: ${healthcareProvider.ZdravotnickeZarizeniId}',
                snippet: 'NazevZarizeni: ${healthcareProvider.NazevZarizeni}',
                onTap: () async {
                  await showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              Text(
                                  'ZdravotnickeZarizeniId: ${healthcareProvider.ZdravotnickeZarizeniId}'),
                              Text('NazevZarizeni: ${healthcareProvider.NazevZarizeni}'),
                              Text(
                                  'Adresa: ${healthcareProvider.Obec} ${healthcareProvider.Ulice} ${healthcareProvider.CisloDomovniOrientacni}'),
                              Text('OborPece: ${healthcareProvider.OborPece}'),
                              Text('PoskytovatelEmail: ${healthcareProvider.PoskytovatelEmail}'),
                              Text(
                                  'PoskytovatelTelefon: ${healthcareProvider.PoskytovatelTelefon}'),
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
            zoomControlsEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              mapController.complete(controller);
            },
            markers: createMarkers(
              healthcareProviders: value.healthcareProviders,
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(10.0),
            child: FloatingActionButton(
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: SingleChildScrollView(
                        child: Column(
                          children: specializations
                              .map(
                                (specialization) => RadioListTile<Specialization>(
                                  title: Text(specialization.categoryName),
                                  value: specialization,
                                  groupValue: value.currSpecialization,
                                  onChanged: (Specialization? value) {
                                    if (value != null) mapStateService.setSpecialization(value);
                                  },
                                ),
                              )
                              .toList(),
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
              },
              backgroundColor: Colors.white,
              child: const Icon(Icons.filter_alt, color: Colors.black87),
            ),
          ),
        );
      },
    );
  }
}
