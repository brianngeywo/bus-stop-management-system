import 'package:bus_sacco/sacco_details_screen.dart';
import 'package:bus_sacco/test_datas.dart';
import 'package:flutter/material.dart';

class SaccosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saccos'),
      ),
      body: ListView.builder(
        itemCount: saccos.length,
        itemBuilder: (context, index) {
          final sacco = saccos[index];
          return ListTile(
            title: Text(sacco.name),
            subtitle: Text(sacco.contactInfo),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SaccoDetailsScreen(sacco: sacco)));
            },
          );
        },
      ),
    );
  }
}
