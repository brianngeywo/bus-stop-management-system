import 'package:bus_sacco/constants.dart';
import 'package:bus_sacco/main_app_bar.dart';
import 'package:bus_sacco/models/bus_route_model.dart';
import 'package:bus_sacco/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class BusRouteRegistrationScreen extends StatefulWidget {
  @override
  _BusRouteRegistrationScreenState createState() =>
      _BusRouteRegistrationScreenState();
}

class _BusRouteRegistrationScreenState
    extends State<BusRouteRegistrationScreen> {
  final TextEditingController _sourceController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  final TextEditingController _fareRateController = TextEditingController();
  List<String> _stops = [];
  bool _isLoading = false;

  void _addStop() {
    setState(() {
      _stops.add('');
    });
  }

  void _removeStop(int index) {
    setState(() {
      _stops.removeAt(index);
    });
  }

  void _updateStop(int index, String value) {
    setState(() {
      _stops[index] = value;
    });
  }

  void _registerBusRoute() {
    final String source = _sourceController.text;
    final String destination = _destinationController.text;
    final double fareRate = double.parse(_fareRateController.text);

    final BusRouteModel newBusRoute = BusRouteModel(
      routeId: const Uuid().v4(), // Assign a unique ID
      source: source,
      destination: destination,
      stops: _stops,
      fareRate: fareRate,
    );

    busRoutesCollection.doc(newBusRoute.routeId).set(newBusRoute.toMap());

    _sourceController.clear();
    _destinationController.clear();
    _fareRateController.clear();
    setState(() {
      _stops.clear();
    });

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Success'),
        content: const Text('Bus route registered successfully.'),
        actions: [
          TextButton(
            child: const Text('OK'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar('Register Bus Route'),
      body: Row(
        children: [
          const MySidebar(),
          Expanded(
            flex: 4,
            child: Container(
              color: Colors.grey[200],
              padding: const EdgeInsets.all(16),
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            'TranspoLink Register New Bus Route',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          const Divider(),
                          const SizedBox(height: 8.0),
                          TextField(
                            controller: _sourceController,
                            decoration:
                                const InputDecoration(labelText: 'From'),
                          ),
                          const SizedBox(height: 16.0),
                          TextField(
                            controller: _destinationController,
                            decoration: const InputDecoration(labelText: 'To'),
                          ),
                          const SizedBox(height: 16.0),
                          const Text('Stops',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8.0),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: _stops.length,
                            itemBuilder: (context, index) =>
                                _buildStopTextField(index),
                          ),
                          const SizedBox(height: 8.0),
                          TextButton(
                            onPressed: _addStop,
                            child: const Text('Add Stop'),
                          ),
                          const SizedBox(height: 16.0),
                          TextField(
                            controller: _fareRateController,
                            decoration:
                                const InputDecoration(labelText: 'Fare Rate'),
                            keyboardType: TextInputType.number,
                          ),
                          const SizedBox(height: 24.0),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.cyan[900],
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32.0,
                                vertical: 16.0,
                              ),
                            ),
                            onPressed: _registerBusRoute,
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Register Bus Route',
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStopTextField(int index) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            onChanged: (value) => _updateStop(index, value),
            decoration: InputDecoration(labelText: 'Stop ${index + 1}'),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.remove_circle),
          onPressed: () => _removeStop(index),
        ),
      ],
    );
  }
}
