import 'package:bus_sacco/bus_details_screen.dart';
import 'package:bus_sacco/constants.dart';
import 'package:bus_sacco/models/bus_model.dart';
import 'package:flutter/material.dart';

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
      appBar: AppBar(
        title: Text('Buses'),
      ),
      body: StreamBuilder<List<BusModel>>(
          stream: _fetchBusesFromFirestore(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Something went wrong'),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              var fetched_buses = snapshot.data!;
              return ListView.builder(
                  itemCount: fetched_buses.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BusDetailsScreen(
                              bus: fetched_buses[index],
                            ),
                          ),
                        );
                      },
                      title: Text(fetched_buses[index].numberPlate),
                      subtitle: Text(fetched_buses[index].routeId),
                    );
                  });
            }
            return Center(
              child: Text('No buses found'),
            );
          }),
    );
  }
}
