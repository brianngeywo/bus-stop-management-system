import 'package:bus_sacco/constants.dart';
import 'package:bus_sacco/models/bus_station.dart';
import 'package:bus_sacco/models/sacco_model.dart';
import 'package:bus_sacco/sacco_details_screen.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.busStation.name),
      ),
      body: Column(
        children: [
          ListTile(
            title: const Text('Location:'),
            subtitle: Text(widget.busStation.location),
          ),
          ListTile(
            title: const Text('ID:'),
            subtitle: Text(widget.busStation.stationId.toString()),
          ),
          const SizedBox(height: 20),
          const Text('Saccos:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          StreamBuilder<List<SaccoModel>>(
              stream: saccoStream(widget.busStation.saccoIds),
              builder: (context, snapshot) {
                var saccos = snapshot.data!;
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: saccos.length,
                  itemBuilder: (context, index) {
                    SaccoModel sacco = saccos[index];
                    return ListTile(
                      title: Text(sacco.name),
                      subtitle: Text('Contact: ${sacco.phoneNumber}'),
                      trailing: Text('ID: ${sacco.saccoId}'),
                      onTap: () {
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
    return saccos != null ? Stream.value(saccos) : Stream.empty();
  }
}
