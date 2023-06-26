import 'package:bus_sacco/bus_details_screen.dart';
import 'package:bus_sacco/constants.dart';
import 'package:bus_sacco/main_app_bar.dart';
import 'package:bus_sacco/models/bus_model.dart';
import 'package:bus_sacco/models/bus_route_model.dart';
import 'package:bus_sacco/models/driver_model.dart';
import 'package:bus_sacco/sidebar.dart';
import 'package:flutter/material.dart';

class DriverDetailsScreen extends StatefulWidget {
  final DriverModel driver;

  DriverDetailsScreen({required this.driver});

  @override
  State<DriverDetailsScreen> createState() => _DriverDetailsScreenState();
}

class _DriverDetailsScreenState extends State<DriverDetailsScreen> {
  // List<BusModel> buses = [];
  BusRouteModel? _route;
  void fetchDetails() async {
    // buses = await getBusesByDriverId(widget.driver.driverId);
    var route = await getRoutesByDriverId(widget.driver.driverId);
    setState(() {
      // buses = buses;
      _route = route;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    // fetchDetails();
    fetchDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar('Driver Details'),
      body: Row(
        children: [
          const MySidebar(),
          Expanded(
            flex: 4,
            child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Name',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    widget.driver.name,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('Contact Info',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(widget.driver.contactInfo),
                ),
                const Divider(),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Assigned Buses',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                StreamBuilder<List<BusModel>>(
                    stream: busesStream(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var buses = snapshot.data!;
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: buses.length,
                          itemBuilder: (context, index) {
                            var bus = buses[index];
                            return ListTile(
                              title: Text(bus.numberPlate),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BusDetailsScreen(
                                      bus: bus,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper functions to retrieve related bus and route information
  Future<List<BusModel>> getBusesByDriverId(String driverId) async {
    List<BusModel> my_buses = [];
    await busesCollection
        .where('driverId', isEqualTo: driverId)
        .limit(1)
        .get()
        .then(
      (snapshot) {
        for (var doc in snapshot.docs) {
          setState(() {
            my_buses.add(
              BusModel(
                busId: doc.id,
                numberPlate: doc['numberPlate'],
                routeId: doc['routeId'],
                driverId: doc['driverId'],
                saccoId: doc['saccoId'],
              ),
            );
          });
        }
      },
    );
    return my_buses;
  }

  Stream<List<BusModel>> busesStream() {
    List<BusModel> buses = [];
    return busesCollection
        .where('driverId', isEqualTo: widget.driver.driverId)
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs
            .map((doc) => BusModel.fromMap(doc.data()))
            .toList());
  }

  //
  Future<BusRouteModel?> getRoutesByDriverId(String driverId) async {
    BusRouteModel? my_route;
    List<BusModel> my_buses = await getBusesByDriverId(driverId);
    // fetch buses from firestore
    // for each bus, fetch the route from firestore
    for (BusModel bus in my_buses) {
      // fetch the route from firestore
      await busRoutesCollection.doc(bus.routeId).get().then(
        (doc) {
          setState(() {
            my_route = BusRouteModel.fromMap(doc.data()!);
          });
          return my_route;
        },
      );
    }
    return my_route;
  }
}
