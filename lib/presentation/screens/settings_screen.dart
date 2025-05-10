import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:specimen_one/core/constants/app_constants.dart';

/// SettingsScreen ermöglicht die Konfiguration der App-Einstellungen
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _useHive = true;
  bool _darkMode = false;
  String _lastSync = 'Nie';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    
    setState(() {
      _useHive = prefs.getBool('use_hive') ?? true;
      _darkMode = prefs.getBool('dark_mode') ?? false;
      _lastSync = prefs.getString('last_sync') ?? 'Nie';
      _isLoading = false;
    });
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    
    await prefs.setBool('use_hive', _useHive);
    await prefs.setBool('dark_mode', _darkMode);
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Einstellungen gespeichert'),
      ),
    );
  }

  Future<void> _resetDatabase() async {
    // Zeige einen Bestätigungsdialog an
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Datenbank zurücksetzen'),
        content: const Text(
          'Möchten Sie wirklich die Datenbank zurücksetzen? '
          'Alle Änderungen gehen verloren und die Daten werden aus den '
          'JSON-Dateien neu geladen.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Abbrechen'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Zurücksetzen'),
          ),
        ],
      ),
    );
    
    if (confirm != true) return;
    
    // TODO: Implementieren Sie die Funktion zum Zurücksetzen der Datenbank
    
    // Aktualisiere den letzten Synchronisationszeitpunkt
    final prefs = await SharedPreferences.getInstance();
    final now = DateTime.now();
    final formattedDate = '${now.day}.${now.month}.${now.year} ${now.hour}:${now.minute}';
    
    await prefs.setString('last_sync', formattedDate);
    
    setState(() {
      _lastSync = formattedDate;
    });
    
    if (!mounted) return;
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Datenbank wurde zurückgesetzt'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Einstellungen'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                ListTile(
                  title: const Text('App-Informationen'),
                  subtitle: Text(
                    '${AppConstants.appName} ${AppConstants.appVersion}',
                  ),
                  leading: const Icon(Icons.info),
                ),
                const Divider(),
                SwitchListTile(
                  title: const Text('Hive-Datenbank verwenden'),
                  subtitle: const Text(
                    'Schnellere NoSQL-Datenbank anstelle von SQLite',
                  ),
                  value: _useHive,
                  onChanged: (value) {
                    setState(() {
                      _useHive = value;
                    });
                  },
                ),
                SwitchListTile(
                  title: const Text('Dunkles Design'),
                  subtitle: const Text(
                    'Dunkles Farbschema für die App verwenden',
                  ),
                  value: _darkMode,
                  onChanged: (value) {
                    setState(() {
                      _darkMode = value;
                    });
                  },
                ),
                const Divider(),
                ListTile(
                  title: const Text('Letzte Synchronisation'),
                  subtitle: Text(_lastSync),
                  leading: const Icon(Icons.sync),
                ),
                ListTile(
                  title: const Text('Datenbank zurücksetzen'),
                  subtitle: const Text(
                    'Alle Daten werden aus den JSON-Dateien neu geladen',
                  ),
                  leading: const Icon(Icons.restore),
                  onTap: _resetDatabase,
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: _saveSettings,
                    child: const Text('Einstellungen speichern'),
                  ),
                ),
              ],
            ),
    );
  }
}
