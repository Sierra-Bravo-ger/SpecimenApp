import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:specimen_one/core/utils/responsive_helper.dart';
import 'package:specimen_one/data/models/test_model.dart';
import 'package:specimen_one/presentation/screens/test_detail_screen.dart';

/// TestListScreen zeigt eine Liste von Tests an
class TestListScreen extends StatelessWidget {
  final String title;
  final List<LabTest> tests;

  const TestListScreen({
    Key? key,
    required this.title,
    required this.tests,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Responsives Design basierend auf der Bildschirmgröße
    final padding = ResponsiveHelper.getPadding(context);
    final isDesktop = ResponsiveHelper.isDesktop(context);
    
    return Scaffold(
      appBar: AppBar(
        // Logo in der linken Ecke
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset(
            'assets/images/icons/component.svg',
            width: 32,
            height: 32,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: ResponsiveHelper.getFontSize(context, base: 20),
          ),
        ),
      ),
      body: tests.isEmpty
          ? Center(
              child: Text(
                'Keine Tests gefunden',
                style: TextStyle(
                  fontSize: ResponsiveHelper.getFontSize(context, base: 16),
                ),
              ),
            )
          : ResponsiveHelper.responsiveLayout(
              context: context,
              // Mobile Layout (Standardlayout)
              mobile: ListView.builder(
                itemCount: tests.length,
                padding: padding,
                itemBuilder: (context, index) {
                  return _buildTestCard(context, tests[index]);
                },
              ),
              // Tablet Layout (mit größeren Karten)
              tablet: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2.5,
                  mainAxisSpacing: ResponsiveHelper.getGridSpacing(context),
                  crossAxisSpacing: ResponsiveHelper.getGridSpacing(context),
                ),
                itemCount: tests.length,
                padding: padding,
                itemBuilder: (context, index) {
                  return _buildTestCard(context, tests[index]);
                },
              ),
              // Desktop Layout (mit größeren Karten und mehr Spalten)
              desktop: Row(
                children: [
                  // Seitenleiste für Desktop mit Filteroptionen
                  if (isDesktop)
                    Container(
                      width: 250,
                      color: Theme.of(context).colorScheme.surfaceVariant,
                      padding: padding,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Filter',
                            style: TextStyle(
                              fontSize: ResponsiveHelper.getFontSize(context, base: 18),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          // Hier könnten später Filteroptionen hinzugefügt werden
                          const Text('Aktive Tests'),
                          const Text('Inaktive Tests'),
                          const Text('Alle Tests'),
                        ],
                      ),
                    ),
                  // Hauptbereich für Desktop
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: isDesktop ? 3 : 2,
                        childAspectRatio: 3.0,
                        mainAxisSpacing: ResponsiveHelper.getGridSpacing(context),
                        crossAxisSpacing: ResponsiveHelper.getGridSpacing(context),
                      ),
                      itemCount: tests.length,
                      padding: padding,
                      itemBuilder: (context, index) {
                        return _buildTestCard(context, tests[index]);
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
  
  /// Baut eine Testkarte für die Liste oder das Grid
  Widget _buildTestCard(BuildContext context, LabTest test) {
    final isDesktop = ResponsiveHelper.isDesktop(context);
    final isTablet = ResponsiveHelper.isTablet(context);
    
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: isDesktop ? 8.0 : (isTablet ? 12.0 : 16.0),
        vertical: isDesktop ? 6.0 : (isTablet ? 8.0 : 8.0),
      ),
      elevation: isDesktop ? 2 : 1,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TestDetailScreen(
                test: test,
              ),
            ),
          );
        },
        // Verwende ein Container mit fixiertem Inhalt
        child: Container(
          constraints: BoxConstraints(
            minHeight: test.befundzeit.isNotEmpty ? 120.0 : 100.0,
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            // Verwende ein ListView statt Column, um Scrolling zu ermöglichen, falls nötig
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(), // Deaktiviere Scrolling
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Titel und Status-Icon
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          test.name,
                          style: TextStyle(
                            fontSize: ResponsiveHelper.getFontSize(context, base: 16),
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      Icon(
                        test.aktiv ? Icons.check_circle : Icons.cancel,
                        color: test.aktiv ? Colors.green : Colors.red,
                        size: isDesktop ? 24 : 20,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  
                  // Test-ID
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Text(
                      'ID: ${test.id}',
                      style: TextStyle(
                        fontSize: ResponsiveHelper.getFontSize(context, base: 14),
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  
                  // Material
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Text(
                      'Material: ${test.material}',
                      style: TextStyle(
                        fontSize: ResponsiveHelper.getFontSize(context, base: 14),
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  
                  // Befundzeit (optional)
                  if (test.befundzeit.isNotEmpty)
                    Text(
                      'Befundzeit: ${test.befundzeit}',
                      style: TextStyle(
                        fontSize: ResponsiveHelper.getFontSize(context, base: 14),
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
