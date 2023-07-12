import 'package:bus_sacco/bus_details_screen.dart';
import 'package:bus_sacco/constants.dart';
import 'package:bus_sacco/dashboard_item_tile.dart';
import 'package:bus_sacco/models/bus_model.dart';
import 'package:bus_sacco/sidebar.dart';
import 'package:flutter/material.dart';

import 'main_app_bar.dart';

class BusesScreen extends StatefulWidget {
  @override
  State<BusesScreen> createState() => _BusesScreenState();
}

class _BusesScreenState extends State<BusesScreen> {
  List<BusModel> buses = [];
  // fetch buses as stream from firestore
  Stream<List<BusModel>> _fetchBusesFromFirestore() {
    busesCollection.snapshots().listen((snapshot) {
      setState(() {
        buses =
            snapshot.docs.map((doc) => BusModel.fromMap(doc.data())).toList();
      });
    });
    return Stream.value(buses);
  }

  // fetch buses from firestore
  void _fetchBuses() async {
    busesCollection.get().then((snapshot) {
      setState(() {
        buses =
            snapshot.docs.map((doc) => BusModel.fromMap(doc.data())).toList();
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _fetchBuses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar('TranspoLink Sacco Buses'),
      body: Row(
        children: [
          MySidebar(),
          Expanded(
            flex: 4,
            child: Container(
              color: Colors.grey[200],
              padding: const EdgeInsets.all(16),
              child: StreamBuilder<List<BusModel>>(
                  stream: _fetchBusesFromFirestore(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text('Something went wrong'),
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      var fetched_buses = snapshot.data!;
                      return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4),
                          itemCount: fetched_buses.length,
                          itemBuilder: (context, index) {
                            return DashboardTile(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BusDetailsScreen(
                                      bus: fetched_buses[index],
                                    ),
                                  ),
                                );
                              },
                              title: fetched_buses[index].numberPlate,
                            );
                          });
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
