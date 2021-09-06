import 'package:flutter/material.dart';
import 'package:maps_prototype/services/map_state_service.dart';
import 'package:provider/provider.dart';

class SheetMapOverlay extends StatelessWidget {
  const SheetMapOverlay({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MapStateService>(
      builder: (context, value, child) {
        return DraggableScrollableSheet(
          initialChildSize: 0.3,
          maxChildSize: 0.75,
          minChildSize: 0.05,
          builder: (context, scrollController) {
            return Container(
              color: Color.fromRGBO(190, 88, 23, 1),
              child: ListView.builder(
                controller: scrollController,
                itemCount: 30,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (index == 0) ...[
                          Column(
                            children: [
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    top: 10.0,
                                    bottom: 10.0,
                                  ),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width / 3,
                                    height: 4.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  'nalezených doktorů: ${value.healthcareProviders.length}',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ],
                        Card(
                          child: Container(
                            child: Center(child: Text('Doktor ${index + 1}')),
                            width: MediaQuery.of(context).size.width,
                            height: 98.0,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
