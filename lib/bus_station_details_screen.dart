import 'dart:html';

import 'package:bus_sacco/constants.dart';
import 'package:bus_sacco/dashboard_item_tile.dart';
import 'package:bus_sacco/models/bus_station.dart';
import 'package:bus_sacco/models/sacco_model.dart';
import 'package:bus_sacco/sacco_details_screen.dart';
import 'package:bus_sacco/sidebar.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';

import 'main_app_bar.dart';

class BusStationDetailsScreen extends StatefulWidget {
  final BusStationModel busStation;

  BusStationDetailsScreen({required this.busStation});

  @override
  State<BusStationDetailsScreen> createState() =>
      _BusStationDetailsScreenState();
}

class _BusStationDetailsScreenState extends State<BusStationDetailsScreen> {
  List<SaccoModel> _saccos = [];

  void getAllDetails() async {
    _saccos = await fetchSaccos(widget.busStation.stationId);
  }

  @override
  void initState() {
    // TODO: implement initState
    getAllDetails();
    super.initState();
  }

  void _generateReport() async {
    List<List<dynamic>> csvData = [];
    List<SaccoModel> saccos = [];

    csvData.add(['Bus Station Name', 'Location']); // Add header row
    Future<List<SaccoModel>> fetchSaccos(List<String> saccoIds) async {
      for (var saccoId in saccoIds) {
        await saccoCollection
            .where('saccoId', isEqualTo: saccoId)
            .get()
            .then((value) {
          for (var element in value.docs) {
            saccos.add(SaccoModel.fromMap(element.data()));
          }
        });
      }
      return saccos;
    }

    fetchSaccos(widget.busStation.saccoIds);
    csvData.add([
      widget.busStation.name,
      widget.busStation.location,
    ]); // Add bus station details row

    if (saccos.isNotEmpty) {
      csvData.add([]); // Add empty row for separation

      for (var sacco in saccos) {
        csvData.add([
          'Sacco Name:',
          sacco.name,
        ]);
        csvData.add([
          'Location:',
          sacco.location,
        ]);
        csvData.add([
          'Phone Number:',
          sacco.phoneNumber,
        ]);
        csvData.add([
          'Email Address:',
          sacco.emailAdress,
        ]);
        csvData.add([]); // Add empty row for separation
      }
    }

    String csvString = const ListToCsvConverter().convert(csvData);

    final encodedUri = Uri.dataFromString(csvString).toString();
    AnchorElement(
      href: encodedUri,
    )
      ..setAttribute('download', 'bus_station_report.csv')
      ..click();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(widget.busStation.name),
      floatingActionButton: FloatingActionButton(
        onPressed: _generateReport,
        child: const Icon(Icons.download),
      ),
      body: Row(
        children: [
          const MySidebar(),
          Expanded(
            flex: 4,
            child: Container(
              color: Colors.grey[200],
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(widget.busStation.name,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  ListTile(
                    title: const Text('Location'),
                    subtitle: Text(widget.busStation.location),
                  ),
                  const SizedBox(height: 20),
                  const Text('Listed Saccos',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )),
                  StreamBuilder<List<SaccoModel>>(
                      stream: saccoStream(widget.busStation.saccoIds),
                      builder: (context, snapshot) {
                        var saccos = snapshot.data!;
                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: saccos.length,
                          itemBuilder: (context, index) {
                            SaccoModel sacco = saccos[index];
                            return DashboardTile(
                              title: sacco.name,
                              // subtitle: Text(sacco.location),
                              // trailing: Text(sacco.phoneNumber),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            SaccoDetailsScreen(sacco: sacco)));
                              },
                            );
                          },
                        );
                      }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // fetch saccos using bus.saccoId
  Future<List<SaccoModel>> fetchSaccos(String saccoId) async {
    List<SaccoModel> saccos = [];
    await saccoCollection
        .where('saccoId', isEqualTo: saccoId)
        .get()
        .then((value) {
      for (var element in value.docs) {
        return saccos.add(SaccoModel.fromMap(element.data()));
      }
    });
    return saccos;
  }

  Stream<List<SaccoModel>> saccoStream(List<String> saccoIds) {
    List<SaccoModel> saccos = [];
    for (var saccoId in saccoIds) {
      return saccoCollection
          .where('saccoId', isEqualTo: saccoId)
          .snapshots()
          .map((snapshot) {
        List<SaccoModel> saccos = [];
        snapshot.docs.forEach((document) {
          setState(() {
            saccos.add(SaccoModel.fromMap(document.data()));
          });
        });
        return saccos;
      });
    }
    return saccos != null ? Stream.value(saccos) : const Stream.empty();
  }
}
