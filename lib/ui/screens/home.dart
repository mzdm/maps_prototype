import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:maps_prototype/data/data_sources/healthcare_provider_local_data_source.dart';
import 'package:maps_prototype/data/data_sources/healthcare_provider_remote_data_source.dart';
import 'package:maps_prototype/data/repositories/healthcare_provider_repository.dart';
import 'package:maps_prototype/services/map_state_service.dart';
import 'package:maps_prototype/ui/screens/find_doctor.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiProvider(
        providers: [
          Provider(
            create: (_) => HealthcareProviderRepository(
              localDataSource: const HealthcareProviderLocalDataSource(),
              remoteDataSource: HealthcareProviderRemoteDataSource(client: http.Client()),
            ),
            lazy: false,
          ),
          ChangeNotifierProvider<MapStateService>(create: (_) => MapStateService(), lazy: false),
        ],
        child: Scaffold(
          body: SafeArea(
            child: const FindDoctorScreen(),
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: MediaQuery.of(context).size.height * 0.1,
        child: BottomNavigationBar(
          currentIndex: 1,
          backgroundColor: Colors.white,
          selectedItemColor: Color.fromRGBO(190, 88, 23, 1),
          unselectedItemColor: Color.fromRGBO(190, 88, 23, 0.4),
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Najít lékaře',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.lightbulb_outline),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}
