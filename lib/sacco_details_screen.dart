import 'package:bus_sacco/bus_details_screen.dart';
import 'package:bus_sacco/constants.dart';
import 'package:bus_sacco/driver_details_screen.dart';
import 'package:bus_sacco/models/bus_model.dart';
import 'package:bus_sacco/models/bus_route_model.dart';
import 'package:bus_sacco/models/driver_model.dart';
import 'package:bus_sacco/models/sacco_model.dart';
import 'package:bus_sacco/sidebar.dart';
import 'package:flutter/material.dart';

class SaccoDetailsScreen extends StatefulWidget {
  final SaccoModel sacco;

  SaccoDetailsScreen({required this.sacco});

  @override
  State<SaccoDetailsScreen> createState() => _SaccoDetailsScreenState();
}

class _SaccoDetailsScreenState extends State<SaccoDetailsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    getBusesBySaccoId(widget.sacco.saccoId);
    getBusRoutesBySaccoId(widget.sacco.saccoId);
    getDriversBySaccoId(widget.sacco.saccoId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sacco Details'),
      ),
      body: Row(
        children: [
          const MySidebar(),
          Expanded(
            flex: 4,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Sacco Name',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    widget.sacco.name,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    'Contact Information',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    widget.sacco.phoneNumber,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                  Text(
                    widget.sacco.emailAdress,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                  const SizedBox(height: 24.0),
                  const Text(
                    'Days of operations',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.sacco.activeDays.length,
                    itemBuilder: (context, index) {
                      var day = widget.sacco.activeDays[index];
                      return ListTile(
                        title: Text(day),
                      );
                    },
                  ),
                  const SizedBox(height: 24.0),
                  const Text(
                    'List of Drivers',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  StreamBuilder<List<DriverModel>>(
                      stream: getDriversBySaccoIdStream(widget.sacco.saccoId),
                      builder: (context, snapshot) {
                        if (snapshot.data!.isEmpty) {
                          return const Center(
                            child: Text('No drivers found'),
                          );
                        }
                        if (snapshot.hasError) {
                          return const Center(
                            child: Text('An error occurred'),
                          );
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snapshot.connectionState == ConnectionState.none) {
                          return const Center(
                            child: Text('No drivers found'),
                          );
                        }
                        if (snapshot.hasData) {
                          var drivers = snapshot.data!;
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: drivers.length,
                            itemBuilder: (context, index) {
                              DriverModel driver = drivers[index];
                              return ListTile(
                                title: Text(driver.name),
                                subtitle: Text(driver.contactInfo),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DriverDetailsScreen(driver: driver),
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }),
                  const SizedBox(height: 24.0),
                  const Text(
                    'List of Buses',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  StreamBuilder<List<BusModel>>(
                      stream: getBusesBySaccoIdStream(widget.sacco.saccoId),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snapshot.data!.isEmpty) {
                          return const Center(
                            child: Text('No buses found'),
                          );
                        }
                        if (snapshot.hasError) {
                          return const Center(
                            child: Text('An error occurred'),
                          );
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snapshot.connectionState == ConnectionState.none) {
                          return const Center(
                            child: Text('No buses found'),
                          );
                        }
                        if (snapshot.data!.isEmpty) {
                          return const Center(
                            child: Text('No buses found'),
                          );
                        }
                        if (snapshot.hasData) {
                          var buses = snapshot.data!;
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: buses.length,
                            itemBuilder: (context, index) {
                              BusModel bus = buses[index];
                              return ListTile(
                                title: const Text('Bus Number Plate'),
                                subtitle: Text(bus.numberPlate),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          BusDetailsScreen(bus: bus),
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }),
                  const SizedBox(height: 24.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper functions to retrieve related driver, bus, and route information for a Sacco
  List<DriverModel> getDriversBySaccoId(String saccoId) {
    List<DriverModel> drivers = [];
    // Replace this with your actual implementation
    driversCollection.where('saccoId', isEqualTo: saccoId).get().then((value) {
      value.docs.forEach((element) {
        drivers.add(DriverModel.fromMap(element.data()));
      });
    });
    return drivers;
  }

  Stream<List<DriverModel>> getDriversBySaccoIdStream(String saccoId) {
    return driversCollection
        .where('saccoId', isEqualTo: saccoId)
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs
            .map((doc) => DriverModel.fromMap(doc.data()))
            .toList());
  }

  List<BusModel> getBusesBySaccoId(String saccoId) {
    List<BusModel> buses = [];
    busesCollection.where('saccoId', isEqualTo: saccoId).get().then((value) {
      value.docs.forEach((element) {
        buses.add(BusModel.fromMap(element.data()));
      });
    });
    return buses;
  }

  Stream<List<BusModel>>? getBusesBySaccoIdStream(String saccoId) {
    return busesCollection.where('saccoId', isEqualTo: saccoId).snapshots().map(
        (querySnapshot) => querySnapshot.docs
            .map((doc) => BusModel.fromMap(doc.data()))
            .toList());
  }

  List<BusRouteModel> getBusRoutesBySaccoId(String saccoId) {
    List<BusRouteModel> routes = [];
    busRoutesCollection
        .where('saccoId', isEqualTo: saccoId)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        routes.add(BusRouteModel.fromMap(element.data()));
      });
    });
    return routes;
  }

  Stream<List<BusRouteModel>> getBusRoutesBySaccoIdStream(String saccoId) {
    return busRoutesCollection
        .where('saccoId', isEqualTo: saccoId)
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs
            .map((doc) => BusRouteModel.fromMap(doc.data()))
            .toList());
  }
}
