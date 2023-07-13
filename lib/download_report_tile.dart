import 'package:flutter/material.dart';

class DownloadReportTile extends StatelessWidget {
  final String title;
  final VoidCallback downloadPdf;
  final VoidCallback downloadExcel;

  DownloadReportTile({
    required this.title,
    required this.downloadPdf,
    required this.downloadExcel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        color: Colors.white,
        child: GridTile(
          footer: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.white70,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.cyan[900],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: downloadPdf,
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Download Pdf',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.white70,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.cyan[900],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: downloadExcel,
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Download Excel',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          child: Center(
            child: Text(title),
          ),
        ),
      ),
    );
  }
}
