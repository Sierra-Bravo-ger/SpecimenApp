import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:specimen_one/data/models/test_model.dart';
import 'package:specimen_one/data/models/einheit_model.dart';
import 'package:specimen_one/data/models/referenzwert_model.dart';
import 'package:specimen_one/data/repositories/test_repository.dart';

/// TestDetailScreen zeigt detaillierte Informationen zu einem Test an
class TestDetailScreen extends StatefulWidget {
  final LabTest test;

  const TestDetailScreen({
    Key? key,
    required this.test,
  }) : super(key: key);

  @override
  State<TestDetailScreen> createState() => _TestDetailScreenState();
}

class _TestDetailScreenState extends State<TestDetailScreen> {
  bool _isLoading = true;
  Einheit? _einheit;
  List<Referenzwert> _referenzwerte = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final testRepository = Provider.of<TestRepository>(context, listen: false);
    
    final einheit = await testRepository.getEinheitById(widget.test.einheitId);
    final referenzwerte = await testRepository.getReferenzwerteForTest(widget.test.id);
    
    setState(() {
      _einheit = einheit;
      _referenzwerte = referenzwerte;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
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
        title: Text(widget.test.name),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoCard(),
                  const SizedBox(height: 16.0),
                  _buildMaterialCard(),
                  const SizedBox(height: 16.0),
                  _buildReferenzwerteCard(),
                ],
              ),
            ),
    );
  }

  Widget _buildInfoCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Allgemeine Informationen',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Divider(),
            _buildInfoRow('ID', widget.test.id),
            _buildInfoRow('Name', widget.test.name),
            _buildInfoRow('Kategorie', widget.test.kategorie),
            _buildInfoRow('Status', widget.test.aktiv ? 'Aktiv' : 'Inaktiv'),
            _buildInfoRow('Einheit', _einheit?.bezeichnung ?? 'Keine Angabe'),
            _buildInfoRow('Befundzeit', widget.test.befundzeit),
            _buildInfoRow('Durchführung', widget.test.durchfuehrung),
            if (widget.test.loinc.isNotEmpty && widget.test.loinc != 'folgt')
              _buildInfoRow('LOINC', widget.test.loinc),
            _buildInfoRow('Mindestmenge', '${widget.test.mindestmengeMl} ml'),
            _buildInfoRow('Lagerung', widget.test.lagerung),
          ],
        ),
      ),
    );
  }

  Widget _buildMaterialCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Material und Synonyme',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Divider(),
            _buildInfoRow('Material', widget.test.material),
            _buildInfoRow('Synonyme', widget.test.synonyme),
          ],
        ),
      ),
    );
  }

  Widget _buildReferenzwerteCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Referenzwerte',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Divider(),
            _referenzwerte.isEmpty
                ? const Text('Keine Referenzwerte verfügbar')
                : Column(
                    children: _referenzwerte.map((referenzwert) {
                      return ListTile(
                        title: Text(
                          '${referenzwert.wertMin} - ${referenzwert.wertMax} ${referenzwert.einheit}',
                        ),
                        subtitle: Text(
                          'Geschlecht: ${referenzwert.geschlecht}, Alter: ${referenzwert.alterMin}-${referenzwert.alterMax} Jahre',
                        ),
                      );
                    }).toList(),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}
