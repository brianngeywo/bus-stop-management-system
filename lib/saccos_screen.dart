import 'package:bus_sacco/constants.dart';
import 'package:bus_sacco/dashboard_item_tile.dart';
import 'package:bus_sacco/models/sacco_model.dart';
import 'package:bus_sacco/sacco_details_screen.dart';
import 'package:bus_sacco/sidebar.dart';
import 'package:flutter/material.dart';

import 'main_app_bar.dart';

class SaccosScreen extends StatefulWidget {
  @override
  State<SaccosScreen> createState() => _SaccosScreenState();
}

class _SaccosScreenState extends State<SaccosScreen> {
  List<SaccoModel> saccos = [];

  //create a stream to listen to changes in the Firestore collection
  Stream<List<SaccoModel>> _fetchSaccosFromFirestore() {
    return saccoCollection.snapshots().map((snapshot) {
      snapshot.docs.forEach((document) {
        saccos.add(SaccoModel.fromMap(document.data()));
      });
      return saccos;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar('Saccos'),
      body: Row(
        children: [
          MySidebar(),
          Expanded(
            flex: 4,
            child: Container(
              color: Colors.grey[200],
              padding: const EdgeInsets.all(16.0),
              child: StreamBuilder<List<SaccoModel>>(
                  stream: _fetchSaccosFromFirestore(),
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
                    if (snapshot.data == null || snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text('No data found'),
                      );
                    }
                    if (snapshot.hasData) {
                      List<SaccoModel> fetchedSaccos = snapshot.data ?? [];
                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                        ),
                        itemCount: fetchedSaccos.length,
                        itemBuilder: (context, index) {
                          SaccoModel _sacco = fetchedSaccos[index];
                          return DashboardTile(
                              title: _sacco.name,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SaccoDetailsScreen(
                                      sacco: _sacco,
                                    ),
                                  ),
                                );
                              });
                        },
                      );
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
