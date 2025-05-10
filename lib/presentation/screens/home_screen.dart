import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:specimen_one/core/constants/app_constants.dart';
import 'package:specimen_one/core/utils/responsive_helper.dart';
import 'package:specimen_one/data/repositories/test_repository.dart';
import 'package:specimen_one/presentation/widgets/category_card.dart';
import 'package:specimen_one/presentation/widgets/search_bar.dart';
import 'package:specimen_one/presentation/screens/test_list_screen.dart';
import 'package:specimen_one/presentation/screens/settings_screen.dart';

/// Der HomeScreen ist der Hauptbildschirm der App
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = true;
  Map<String, int> _testCountByCategory = {};

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final testRepository = Provider.of<TestRepository>(context, listen: false);
    final counts = await testRepository.getTestCountByCategory();

    setState(() {
      _testCountByCategory = counts;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Anzahl der Spalten im Grid basierend auf der Bildschirmgröße
    final gridCrossAxisCount = ResponsiveHelper.getGridCrossAxisCount(context);
    
    // Abstand zwischen Grid-Elementen basierend auf der Bildschirmgröße
    final gridSpacing = ResponsiveHelper.getGridSpacing(context);
    
    // Padding basierend auf der Bildschirmgröße
    final padding = ResponsiveHelper.getPadding(context);
    
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
          AppConstants.appName,
          style: TextStyle(
            fontSize: ResponsiveHelper.getFontSize(context, base: 20),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsScreen(),
                ),
              );
            },
          ),
        ],
      ),
      // Für Desktop- und Tablet-Geräte verwenden wir ein anderes Layout
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ResponsiveHelper.responsiveLayout(
              context: context,
              // Mobile Layout (Standardlayout)
              mobile: Column(
                children: [
                  Padding(
                    padding: padding,
                    child: CustomSearchBar(
                      onSearch: _handleSearch,
                    ),
                  ),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: gridCrossAxisCount,
                      padding: padding,
                      childAspectRatio: 1.5,
                      mainAxisSpacing: gridSpacing,
                      crossAxisSpacing: gridSpacing,
                      children: _buildCategoryCards(),
                    ),
                  ),
                ],
              ),
              // Tablet Layout (mit größerem Grid und angepasstem Padding)
              tablet: Column(
                children: [
                  Padding(
                    padding: padding,
                    child: CustomSearchBar(
                      onSearch: _handleSearch,
                    ),
                  ),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: gridCrossAxisCount,
                      padding: padding,
                      childAspectRatio: 1.8, // Breiteres Verhältnis für Tablets
                      mainAxisSpacing: gridSpacing,
                      crossAxisSpacing: gridSpacing,
                      children: _buildCategoryCards(),
                    ),
                  ),
                ],
              ),
              // Desktop Layout (mit Seitenleiste und größerem Grid)
              desktop: Row(
                children: [
                  // Seitenleiste für Desktop
                  Container(
                    width: 250,
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    padding: padding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Kategorien',
                          style: TextStyle(
                            fontSize: ResponsiveHelper.getFontSize(context, base: 18),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: ListView(
                            children: AppConstants.testKategorien.map((kategorie) {
                              final count = _testCountByCategory[kategorie] ?? 0;
                              return ListTile(
                                title: Text(kategorie),
                                trailing: Text('$count'),
                                onTap: () => _navigateToCategory(kategorie),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Hauptbereich für Desktop
                  Expanded(
                    child: Column(
                      children: [
                        Padding(
                          padding: padding,
                          child: CustomSearchBar(
                            onSearch: _handleSearch,
                          ),
                        ),
                        Expanded(
                          child: GridView.count(
                            crossAxisCount: gridCrossAxisCount,
                            padding: padding,
                            childAspectRatio: 2.0, // Noch breiteres Verhältnis für Desktop
                            mainAxisSpacing: gridSpacing,
                            crossAxisSpacing: gridSpacing,
                            children: _buildCategoryCards(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implementieren Sie die Funktion zum Hinzufügen eines neuen Tests
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Diese Funktion ist noch nicht implementiert'),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
  
  /// Baut die Kategorie-Karten für das Grid
  List<Widget> _buildCategoryCards() {
    return AppConstants.testKategorien.map((kategorie) {
      final count = _testCountByCategory[kategorie] ?? 0;
      return CategoryCard(
        title: kategorie,
        count: count,
        onTap: () => _navigateToCategory(kategorie),
      );
    }).toList();
  }
  
  /// Navigiert zur Testliste für eine bestimmte Kategorie
  void _navigateToCategory(String kategorie) async {
    final testRepository = Provider.of<TestRepository>(
      context,
      listen: false,
    );
    final tests = await testRepository.getTests(
      kategorie: kategorie,
    );
    
    if (!mounted) return;
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TestListScreen(
          title: kategorie,
          tests: tests,
        ),
      ),
    );
  }
  
  /// Behandelt die Suche nach Tests
  void _handleSearch(String query) async {
    final testRepository = Provider.of<TestRepository>(
      context,
      listen: false,
    );
    final tests = await testRepository.searchTests(query);
    
    if (!mounted) return;
    
    if (tests.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Keine Tests gefunden'),
        ),
      );
      return;
    }
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TestListScreen(
          title: 'Suchergebnisse',
          tests: tests,
        ),
      ),
    );
  }
}
