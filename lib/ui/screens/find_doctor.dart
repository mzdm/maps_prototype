import 'package:flutter/material.dart';
import 'package:maps_prototype/data/data_sources/healthcare_provider_local_data_source.dart';
import 'package:maps_prototype/data/models/healthcare_provider.dart';
import 'package:maps_prototype/services/map_state_service.dart';
import 'package:maps_prototype/ui/widgets/map_overlay/bottom_sheet.dart';
import 'package:maps_prototype/ui/widgets/map_overlay/text_field.dart';
import 'package:maps_prototype/ui/widgets/map_preview.dart';
import 'package:provider/provider.dart';

class FindDoctorScreen extends StatefulWidget {
  const FindDoctorScreen({Key? key}) : super(key: key);

  @override
  _FindDoctorScreenState createState() => _FindDoctorScreenState();
}

class _FindDoctorScreenState extends State<FindDoctorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MapPreview(),
          // TextFieldMapOverlay(),
          // Expanded(child: SheetMapOverlay()),
        ],
      ),
    );
  }
}
