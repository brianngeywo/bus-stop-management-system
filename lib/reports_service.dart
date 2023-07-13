import 'dart:html' as html;

import 'package:bus_sacco/models/bus_route_model.dart';
import 'package:bus_sacco/models/driver_model.dart';
import 'package:csv/csv.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart' as pwLib;

import 'models/bus_model.dart';
import 'models/bus_station.dart';

class ReportService {
  Future<void> generateBusesPDFReport({required List<BusModel> busList}) async {
    final pdf = pw.Document();

    // Add content to the PDF report
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pwLib.Container(
            child: pwLib.Column(
              children: [
                pwLib.Text('Bus Report',
                    style: pwLib.TextStyle(
                        fontSize: 20, fontWeight: pwLib.FontWeight.bold)),
                pwLib.SizedBox(height: 20),
                for (final bus in busList)
                  pwLib.Container(
                    margin: const pwLib.EdgeInsets.symmetric(vertical: 10),
                    child: pwLib.Column(
                      crossAxisAlignment: pwLib.CrossAxisAlignment.start,
                      children: [
                        pwLib.Text('Bus ID: ${bus.busId}'),
                        pwLib.Text('Number Plate: ${bus.numberPlate}'),
                        pwLib.Text('Route ID: ${bus.routeId}'),
                        pwLib.Text('Sacco ID: ${bus.saccoId}'),
                        pwLib.Text('Driver ID: ${bus.driverId}'),
                        pwLib.Text('Has Left Source: ${bus.hasLeftSource}'),
                        pwLib.Text(
                            'Has Arrived Destination: ${bus.hasArrivedDestination}'),
                      ],
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );

    // Save the PDF file
    final pdfBytes = await pdf.save();
    final blob = html.Blob([pdfBytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..style.display = 'none'
      ..download = 'buses-report.pdf';

    html.document.body?.children.add(anchor);
    anchor.click();
    html.document.body?.children.remove(anchor);
    html.Url.revokeObjectUrl(url);
    // Open the generated PDF using a PDF viewer or a PDF viewing plugin
    // You can use a PDF viewing package or launch the file with a PDF viewer application
  }

  Future<void> generateBusesCSVReport({required List<BusModel> busList}) async {
    final List<List<dynamic>> rows = [];

    // Add headers
    rows.add([
      'Bus ID',
      'Number Plate',
      'Route ID',
      'Sacco ID',
      'Driver ID',
      'Has Left Source',
      'Has Arrived Destination',
    ]);

    // Add data rows
    for (final bus in busList) {
      rows.add([
        bus.busId,
        bus.numberPlate,
        bus.routeId,
        bus.saccoId,
        bus.driverId,
        bus.hasLeftSource,
        bus.hasArrivedDestination,
      ]);
    }

    // Convert rows to CSV format
    final csvData = ListToCsvConverter().convert(rows);

    final blob = html.Blob([csvData], 'text/csv;charset=utf-8;');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..style.display = 'none'
      ..download = 'buses-report.csv';

    html.document.body?.children.add(anchor);
    anchor.click();
    html.document.body?.children.remove(anchor);
    html.Url.revokeObjectUrl(url);
  }

  Future<void> generateBusStationsPDFReport(
      {required List<BusStationModel> busStationsList}) async {
    final pdf = pw.Document();

    // Add content to the PDF report
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pwLib.Container(
            child: pwLib.Column(
              children: [
                pwLib.Text('Bus Stations Report',
                    style: pwLib.TextStyle(
                        fontSize: 20, fontWeight: pwLib.FontWeight.bold)),
                pwLib.SizedBox(height: 20),
                for (final busStation in busStationsList)
                  pwLib.Container(
                    margin: const pwLib.EdgeInsets.symmetric(vertical: 10),
                    child: pwLib.Column(
                      crossAxisAlignment: pwLib.CrossAxisAlignment.start,
                      children: [
                        pwLib.Text('Bus station name: ${busStation.name}'),
                        pwLib.Text('Bus station id: ${busStation.stationId}'),
                        pwLib.Text(
                            'Bus station location: ${busStation.location}'),
                      ],
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );

    // Save the PDF file
    final pdfBytes = await pdf.save();
    final blob = html.Blob([pdfBytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..style.display = 'none'
      ..download = 'bus-stations-report.pdf';

    html.document.body?.children.add(anchor);
    anchor.click();
    html.document.body?.children.remove(anchor);
    html.Url.revokeObjectUrl(url);
    // Open the generated PDF using a PDF viewer or a PDF viewing plugin
    // You can use a PDF viewing package or launch the file with a PDF viewer application
  }

  Future<void> generateBusStationsCSVReport(
      {required List<BusStationModel> busStationsList}) async {
    final List<List<dynamic>> rows = [];
    // Add headers
    rows.add([
      'Bus station ID',
      'Bus station name',
      'Bus station location',
    ]);

    // Add data rows
    for (final busStation in busStationsList) {
      rows.add([
        busStation.stationId,
        busStation.name,
        busStation.location,
      ]);
    }

    // Convert rows to CSV format
    final csvData = ListToCsvConverter().convert(rows);

    final blob = html.Blob([csvData], 'text/csv;charset=utf-8;');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..style.display = 'none'
      ..download = 'bus-station-report.csv';

    html.document.body?.children.add(anchor);
    anchor.click();
    html.document.body?.children.remove(anchor);
    html.Url.revokeObjectUrl(url);
  }

  generateBusDriversCSVReport({required List<DriverModel> driversList}) async {
    final List<List<dynamic>> rows = [];
    // Add headers
    rows.add([
      'Driver Name',
      'Driver ID',
      'Contact Info',
      'Sacco ID',
    ]);

    // Add data rows
    for (final DRIVER in driversList) {
      rows.add([
        DRIVER.name,
        DRIVER.driverId,
        DRIVER.contactInfo,
        DRIVER.saccoId,
      ]);
    }

    // Convert rows to CSV format
    final csvData = ListToCsvConverter().convert(rows);

    final blob = html.Blob([csvData], 'text/csv;charset=utf-8;');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..style.display = 'none'
      ..download = 'bus-drivers-report.csv';

    html.document.body?.children.add(anchor);
    anchor.click();
    html.document.body?.children.remove(anchor);
    html.Url.revokeObjectUrl(url);
  }

  generateBusDriversPDFReport({required List<DriverModel> driversList}) async {
    final pdf = pw.Document();

    // Add content to the PDF report
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pwLib.Container(
            child: pwLib.Column(
              children: [
                pwLib.Text('Bus Drivers Report',
                    style: pwLib.TextStyle(
                        fontSize: 20, fontWeight: pwLib.FontWeight.bold)),
                pwLib.SizedBox(height: 20),
                for (final driver in driversList)
                  pwLib.Container(
                    margin: const pwLib.EdgeInsets.symmetric(vertical: 10),
                    child: pwLib.Column(
                      crossAxisAlignment: pwLib.CrossAxisAlignment.start,
                      children: [
                        pwLib.Text('Bus driver name: ${driver.name}'),
                        pwLib.Text('Bus driver id: ${driver.driverId}'),
                        pwLib.Text('Bus driver sacco id: ${driver.saccoId}'),
                        pwLib.Text(
                            'Bus driver contact info: ${driver.contactInfo}'),
                      ],
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );

    // Save the PDF file
    final pdfBytes = await pdf.save();
    final blob = html.Blob([pdfBytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..style.display = 'none'
      ..download = 'bus-drivers-report.pdf';

    html.document.body?.children.add(anchor);
    anchor.click();
    html.document.body?.children.remove(anchor);
    html.Url.revokeObjectUrl(url);
    // Open the generated PDF using a PDF viewer or a PDF viewing plugin
    // You can use a PDF viewing package or launch the file with a PDF viewer application
  }

  generateBusRoutesCSVReport({required List<BusRouteModel> busRoutesList}) {
    final List<List<dynamic>> rows = [];
    // Add headers
    rows.add([
      'Bus route ID',
      'Bus route source',
      'Bus route destination',
      'Bus route fare rate',
    ]);

    // Add data rows
    for (final busRoute in busRoutesList) {
      rows.add([
        busRoute.routeId,
        busRoute.source,
        busRoute.destination,
        busRoute.fareRate,
      ]);
    }

    // Convert rows to CSV format
    final csvData = ListToCsvConverter().convert(rows);

    final blob = html.Blob([csvData], 'text/csv;charset=utf-8;');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..style.display = 'none'
      ..download = 'bus-routes-report.csv';

    html.document.body?.children.add(anchor);
    anchor.click();
    html.document.body?.children.remove(anchor);
    html.Url.revokeObjectUrl(url);
  }

  generateBusRoutesPDFReport({required List<BusRouteModel> routesList}) async {
    final pdf = pw.Document();

    // Add content to the PDF report
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pwLib.Container(
            child: pwLib.Column(
              children: [
                pwLib.Text('Bus Routes Report',
                    style: pwLib.TextStyle(
                        fontSize: 20, fontWeight: pwLib.FontWeight.bold)),
                pwLib.SizedBox(height: 20),
                for (final route in routesList)
                  pwLib.Container(
                    margin: const pwLib.EdgeInsets.symmetric(vertical: 10),
                    child: pwLib.Column(
                      crossAxisAlignment: pwLib.CrossAxisAlignment.start,
                      children: [
                        pwLib.Text(
                            'Bus route name: ${route.source} - ${route.destination}'),
                        pwLib.Text('Bus route id: ${route.routeId}'),
                        pwLib.Text('Bus route source: ${route.source}'),
                        pwLib.Text(
                            'Bus route destination: ${route.destination}'),
                        pwLib.Text(
                            'Bus route fare rate: Kshs ${route.fareRate}'),
                      ],
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );

    // Save the PDF file
    final pdfBytes = await pdf.save();
    final blob = html.Blob([pdfBytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..style.display = 'none'
      ..download = 'bus-routes-report.pdf';

    html.document.body?.children.add(anchor);
    anchor.click();
    html.document.body?.children.remove(anchor);
    html.Url.revokeObjectUrl(url);
    // Open the generated PDF using a PDF viewer or a PDF viewing plugin
    // You can use a PDF viewing package or launch the file with a PDF viewer application
  }
}
