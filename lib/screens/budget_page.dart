import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class BudgetPage extends StatefulWidget {
  const BudgetPage({Key? key}) : super(key: key);

  @override
  _BudgetPageState createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  List<String> pdfPaths = [];
  int _selectedIndex = 2; // Set initial index to Budgets tab

  void _onItemTapped(int index) {
    // Navigate to respective pages
    if (index == 1) {
      Navigator.pop(context); // Go back to previous page
    } else if (index == 2) {
      // No need to navigate, already on Budgets page
    } else {
      // Handle other taps accordingly
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    loadPdfs();
  }

  Future<void> loadPdfs() async {
    List<String> pdfAssets = [
      'assets/budget.pdf',
      // 'assets/budget2.pdf',
      // 'assets/budget3.pdf',
    ];

    for (String asset in pdfAssets) {
      final ByteData bytes = await DefaultAssetBundle.of(context).load(asset);
      final Uint8List list = bytes.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      final file = await File("${tempDir.path}/${asset.split('/').last}")
          .create(recursive: true);
      file.writeAsBytesSync(list);

      pdfPaths.add(file.path);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Budgets'),
      ),
      body: pdfPaths.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: pdfPaths.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Image.asset(
                    'assets/pdf_icon.png',
                    width: 24,
                    height: 24,
                  ),
                  title: Text('Budget'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PdfViewerPage(pdfPath: pdfPaths[index]),
                      ),
                    );
                  },
                );
              },
            ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Projects',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.file_copy),
            label: 'Budgets',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.yellow.shade700,
        unselectedItemColor: Colors.black, // Unselected color for all tabs
        onTap: _onItemTapped,
      ),
    );
  }
}

class PdfViewerPage extends StatelessWidget {
  final String pdfPath;
  const PdfViewerPage({Key? key, required this.pdfPath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Budget details'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: PDFView(
                filePath: pdfPath,
                enableSwipe: true, // Allow vertical swiping to change pages
                swipeHorizontal: false, // Disable horizontal swiping
                fitPolicy: FitPolicy.BOTH),
          ),
        ],
      ),
    );
  }
}
