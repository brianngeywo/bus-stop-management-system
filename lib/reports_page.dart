import 'package:bus_sacco/download_report_tile.dart';
import 'package:bus_sacco/main_app_bar.dart';
import 'package:bus_sacco/report_preview_widget.dart';
import 'package:bus_sacco/reports_service.dart';
import 'package:bus_sacco/sidebar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'models/bus_model.dart';
import 'models/bus_route_model.dart';
import 'models/bus_station.dart';
import 'models/driver_model.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  List<BusModel> busList = [];
  List<BusStationModel> busStationsList = [];
  List<DriverModel> driverList = [];
  List<BusRouteModel> busRouteList = [];

  Future<void> fetchBuses() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection('buses').get();
      if (snapshot.docs.isNotEmpty) {
        for (QueryDocumentSnapshot<Map<String, dynamic>> doc in snapshot.docs) {
          BusModel sacco = BusModel.fromMap(doc.data());
          setState(() {
            busList.add(sacco);
          });
        }
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  // fetch bus stations
  Future<void> fetchBusStations() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection('bus_stations').get();
      if (snapshot.docs.isNotEmpty) {
        for (QueryDocumentSnapshot<Map<String, dynamic>> doc in snapshot.docs) {
          BusStationModel busStation = BusStationModel.fromMap(doc.data());
          setState(() {
            busStationsList.add(busStation);
          });
        }
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  // fetch bus drivers
  Future<void> fetchBusDrivers() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection('drivers').get();
      if (snapshot.docs.isNotEmpty) {
        for (QueryDocumentSnapshot<Map<String, dynamic>> doc in snapshot.docs) {
          DriverModel driver = DriverModel.fromMap(doc.data());
          setState(() {
            driverList.add(driver);
          });
        }
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  // fetch bus routes
  Future<void> fetchBusRoutes() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection('routes').get();
      if (snapshot.docs.isNotEmpty) {
        for (QueryDocumentSnapshot<Map<String, dynamic>> doc in snapshot.docs) {
          BusRouteModel busRoute = BusRouteModel.fromMap(doc.data());
          setState(() {
            busRouteList.add(busRoute);
          });
        }
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  void initState() {
    fetchBuses();
    fetchBusStations();
    fetchBusDrivers();
    fetchBusRoutes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar('TranspoLink Sacco Reports'),
      body: Row(
        children: [
          const MySidebar(),
          Expanded(
            flex: 4,
            child: Container(
              padding: const EdgeInsets.all(20.0),
              color: Colors.grey[200],
              child: GridView.count(
                crossAxisCount: 3,
                children: [
                  DownloadReportTile(
                    title: "TranspoLink Buses Report",
                    downloadExcel: () {
                      showBusesPreviewDialog(false, busList);
                    },
                    downloadPdf: () {
                      showBusesPreviewDialog(true, busList);
                    },
                  ),
                  DownloadReportTile(
                    title: "TranspoLink Bus Stations Report",
                    downloadExcel: () {
                      showBusStationsPreviewDialog(false, busStationsList);
                    },
                    downloadPdf: () {
                      showBusStationsPreviewDialog(true, busStationsList);
                    },
                  ),
                  DownloadReportTile(
                    title: "TranspoLink Bus Drivers Report",
                    downloadExcel: () {
                      showBusDriversPreviewDialog(false, driverList);
                    },
                    downloadPdf: () {
                      showBusDriversPreviewDialog(true, driverList);
                    },
                  ),
                  DownloadReportTile(
                    title: "TranspoLink Bus Routes Report",
                    downloadExcel: () {
                      showBusRoutesPreviewDialog(false, busRouteList);
                    },
                    downloadPdf: () {
                      showBusRoutesPreviewDialog(true, busRouteList);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> showBusesPreviewDialog(
      bool isPDFReport, List<BusModel> busList) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Buses list Report'),
          content: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.6,
            child: BusesPreviewWidget(busList: busList),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (isPDFReport) {
                  await ReportService()
                      .generateBusesPDFReport(busList: busList);
                } else {
                  await ReportService()
                      .generateBusesCSVReport(busList: busList);
                }
                // await openFile(reportFile.path);
              },
              child: const Text('Download'),
            ),
          ],
        );
      },
    );
  }

  Future<void> showBusStationsPreviewDialog(
      bool isPDFReport, List<BusStationModel> busStationsList) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Bus stations list Report'),
          content: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.6,
            child: BusStationPreviewWidget(busStationsList: busStationsList),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (isPDFReport) {
                  await ReportService().generateBusStationsPDFReport(
                      busStationsList: busStationsList);
                } else {
                  await ReportService().generateBusStationsCSVReport(
                      busStationsList: busStationsList);
                }
                // await openFile(reportFile.path);
              },
              child: const Text('Download'),
            ),
          ],
        );
      },
    );
  }

  Future<void> showBusDriversPreviewDialog(
      bool isPDFReport, List<DriverModel> driversList) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Bus Drivers list Report'),
          content: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.6,
            child: BusDriversPreviewWidget(driversList: driversList),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (isPDFReport) {
                  await ReportService()
                      .generateBusDriversPDFReport(driversList: driversList);
                } else {
                  await ReportService()
                      .generateBusDriversCSVReport(driversList: driversList);
                }
                // await openFile(reportFile.path);
              },
              child: const Text('Download'),
            ),
          ],
        );
      },
    );
  }

  Future<void> showBusRoutesPreviewDialog(
      bool isPDFReport, List<BusRouteModel> routesList) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Bus routes list Report'),
          content: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.6,
            child: BusRoutesPreviewWidget(busRoutesList: routesList),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (isPDFReport) {
                  await ReportService()
                      .generateBusRoutesPDFReport(routesList: routesList);
                } else {
                  await ReportService()
                      .generateBusRoutesCSVReport(busRoutesList: routesList);
                }
                // await openFile(reportFile.path);
              },
              child: const Text('Download'),
            ),
          ],
        );
      },
    );
  }
}
