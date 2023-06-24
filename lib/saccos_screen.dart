import 'package:bus_sacco/constants.dart';
import 'package:bus_sacco/models/sacco_model.dart';
import 'package:bus_sacco/sacco_details_screen.dart';
import 'package:bus_sacco/test_datas.dart';
import 'package:flutter/material.dart';

class SaccosScreen extends StatefulWidget {
  @override
  State<SaccosScreen> createState() => _SaccosScreenState();
}

class _SaccosScreenState extends State<SaccosScreen> {
  //create a stream to listen to changes in the Firestore collection
  Stream<List<SaccoModel>> _fetchSaccosFromFirestore() {
    return saccoCollection.snapshots().map((snapshot) {
      List<SaccoModel> saccos = [];
      snapshot.docs.forEach((document) {
        saccos.add(SaccoModel.fromMap(document.data()));
      });
      return saccos;
    });
  }

  // fetch saccos from Firestore
  void _fetchSaccos() {
    saccoCollection.get().then((querySnapshot) {
      List<SaccoModel> fetchedSaccos = [];
      querySnapshot.docs.forEach((document) {
        fetchedSaccos.add(SaccoModel.fromMap(document.data()));
      });
      setState(() {
        saccos = fetchedSaccos;
      });
      return saccos;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _fetchSaccos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saccos'),
      ),
      body: StreamBuilder<List<SaccoModel>>(
          stream: _fetchSaccosFromFirestore(),
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
            List<SaccoModel> fetchedSaccos = snapshot.data ?? [];
            return ListView.builder(
              itemCount: fetchedSaccos.length,
              itemBuilder: (context, index) {
                SaccoModel sacco = fetchedSaccos[index];
                return ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SaccoDetailsScreen(
                          sacco: sacco,
                        ),
                      ),
                    );
                  },
                  title: Text(sacco.name),
                  subtitle: Text(sacco.location),
                );
              },
            );
          }),
    );
  }
}
