import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_prototype/constants.dart';
import 'package:maps_prototype/data/models/healthcare_provider.dart';
import 'package:maps_prototype/data/repositories/healthcare_provider_repository.dart';
import 'package:maps_prototype/services/map_state_service.dart';
import 'package:provider/provider.dart';

class MapPreview extends StatefulWidget {
  const MapPreview({
    Key? key,
  }) : super(key: key);

  @override
  _MapPreviewState createState() => _MapPreviewState();
}

class _MapPreviewState extends State<MapPreview> {
  final mapController = Completer<GoogleMapController>();

  static const initialCameraPos = CameraPosition(
    target: MapSetup.initialCoords,
    zoom: MapSetup.defaultZoom,
  );

  @override
  void initState() {
    super.initState();
    fetchDoctors();
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

  static const CameraPosition _kMovePos = CameraPosition(
    bearing: 192.8334901395799,
    target: LatLng(50.1058258468836, 14.49318803997208),
    zoom: 19.151926040649414,
  );

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kMovePos));
  }

  Future<void> fetchDoctors() async {
    final list = await context.read<HealthcareProviderRepository>().getAllDoctors();
    if (!mounted) return;
    context.read<MapStateService>().addAll(list);
  }

  Set<Marker> createMarkers({
    required List<HealthcareProvider> healthcareProviders,
  }) {
    if (healthcareProviders.isEmpty) {
      return {
        Marker(
          markerId: MarkerId("marker_1"),
          position: LatLng(50.08849134266741, 14.42132529268974),
          infoWindow: InfoWindow(title: 'marker_1'),
        ),
        Marker(
          markerId: MarkerId("marker_2"),
          position: LatLng(50.08265364270145, 14.436174000590167),
          infoWindow: InfoWindow(title: 'marker_1'),
        ),
      };
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
                snippet: 'NazevZarizeni: ${healthcareProvider.NazevZarizeni}',
                title: 'ZdravotnickeZarizeniId: ${healthcareProvider.ZdravotnickeZarizeniId}',
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
    return Scaffold(
      body: Consumer<MapStateService>(
        builder: (context, value, child) {
          return GoogleMap(
            initialCameraPosition: initialCameraPos,
            myLocationEnabled: true,
            zoomControlsEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              mapController.complete(controller);
            },
            markers: createMarkers(
              healthcareProviders: value.healthcareProviders,
            ),
          );
        },
      ),
      // floatingActionButton: Align(
      //   alignment: Alignment.bottomLeft,
      //   child: FloatingActionButton.extended(
      //     onPressed: _goToTheLake,
      //     label: Text('To the lake!'),
      //     icon: Icon(Icons.directions_boat),
      //   ),
      // ),
    );
  }
}
