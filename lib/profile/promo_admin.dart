import 'package:flutter/material.dart';

class PromoAdmin extends StatelessWidget {
  const PromoAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFECF1FA), // Light blue background
      appBar: AppBar(
        backgroundColor: const Color(0xFFECF1FA),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Job Manage / admin",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF233A66),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Table(
                border: TableBorder.all(color: Colors.grey),
                columnWidths: const {
                  0: FixedColumnWidth(20),
                  1: FixedColumnWidth(80),
                  2: FixedColumnWidth(120),
                  3: FixedColumnWidth(70),
                  4: FixedColumnWidth(40),
                  5: FixedColumnWidth(50),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: const [
                  TableRow(
                    children: [
                      TableCell(child: Center(child: Text('ID'))),
                      TableCell(child: Center(child: Text('Job title'))),
                      TableCell(child: Center(child: Text('Email'))),
                      TableCell(child: Center(child: Text('Category'))),
                      TableCell(child: Center(child: Text('Edit'))),
                      TableCell(child: Center(child: Text('Delete'))),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(child: Center(child: Text('1'))),
                      TableCell(child: Center(child: Text('Max Mendes'))),
                      TableCell(child: Center(child: Text('max@gmail.com'))),
                      TableCell(child: Center(child: Text(''))),
                      TableCell(child: Center(child: Text(''))),
                      TableCell(child: Center(child: Text(''))),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(child: Center(child: Text('2'))),
                      TableCell(child: Center(child: Text('Mark Hugo'))),
                      TableCell(child: Center(child: Text('mark@gmail.com'))),
                      TableCell(child: Center(child: Text(''))),
                      TableCell(child: Center(child: Text(''))),
                      TableCell(child: Center(child: Text(''))),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(child: Center(child: Text('3'))),
                      TableCell(child: Center(child: Text('Smith'))),
                      TableCell(child: Center(child: Text('smith@gmail.com'))),
                      TableCell(child: Center(child: Text(''))),
                      TableCell(child: Center(child: Text(''))),
                      TableCell(child: Center(child: Text(''))),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(child: Center(child: Text('4'))),
                      TableCell(child: Center(child: Text('Kendrick'))),
                      TableCell(
                        child: Center(child: Text('kendrick@gmail.com')),
                      ),
                      TableCell(child: Center(child: Text(''))),
                      TableCell(child: Center(child: Text(''))),
                      TableCell(child: Center(child: Text(''))),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        height: 350,
        decoration: const BoxDecoration(color: Color(0xFF233A66)),
        child: Center(
          child: Image.asset(
            'img/Logopng.png', // Replace with your actual logo path
            height: 200,
          ),
        ),
      ),
    );
  }
}
