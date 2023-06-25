import 'package:bus_sacco/bus_route_details_screen.dart';
import 'package:bus_sacco/constants.dart';
import 'package:flutter/material.dart';

import 'models/bus_route_model.dart';

class BusRoutesScreen extends StatefulWidget {
  @override
  State<BusRoutesScreen> createState() => _BusRoutesScreenState();
}

class _BusRoutesScreenState extends State<BusRoutesScreen> {
  List<BusRouteModel> busRoutes = [];
  void fetchDetails() async {
    busRoutes = getAllBusRoutesFromFirestore();
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bus Routes'),
      ),
      body: StreamBuilder<List<BusRouteModel>>(
        stream: busRoutesCollection.snapshots().map((snapshot) {
          List<BusRouteModel> routes = [];
          snapshot.docs.forEach((element) {
            routes.add(BusRouteModel.fromMap(element.data()));
          });
          return routes;
        }),
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
          if (snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No bus routes found'),
            );
          }
          if (snapshot.data!.length > 0) {
            var routes = snapshot.data!;
            return ListView.builder(
              itemCount: routes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                      routes[index].source + ' - ' + routes[index].destination),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BusRouteDetailsScreen(
                          route: snapshot.data![index],
                        ),
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
        },
      ),
    );
  }

  List<BusRouteModel> getAllBusRoutesFromFirestore() {
    List<BusRouteModel> routes = [];
    busRoutesCollection.get().then((value) {
      value.docs.forEach((element) {
        routes.add(BusRouteModel.fromMap(element.data()));
      });
    });
    return routes;
  }
}
