import 'package:flutter/material.dart';

/// Hilfsklasse für responsives Design
/// Ermöglicht die Anpassung der Benutzeroberfläche an verschiedene Bildschirmgrößen
class ResponsiveHelper {
  /// Prüft, ob das Gerät ein Mobilgerät ist (kleiner Bildschirm)
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 600;
  }

  /// Prüft, ob das Gerät ein Tablet ist (mittlerer Bildschirm)
  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.width >= 600 && 
           MediaQuery.of(context).size.width < 1200;
  }

  /// Prüft, ob das Gerät ein Desktop ist (großer Bildschirm)
  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1200;
  }

  /// Gibt die Anzahl der Spalten für ein Grid basierend auf der Bildschirmgröße zurück
  static int getGridCrossAxisCount(BuildContext context) {
    if (isMobile(context)) {
      return 2; // 2 Spalten für Mobilgeräte
    } else if (isTablet(context)) {
      return 3; // 3 Spalten für Tablets
    } else {
      return 4; // 4 Spalten für Desktops
    }
  }

  /// Gibt den Abstand zwischen Grid-Elementen basierend auf der Bildschirmgröße zurück
  static double getGridSpacing(BuildContext context) {
    if (isMobile(context)) {
      return 8.0; // Kleinerer Abstand für Mobilgeräte
    } else if (isTablet(context)) {
      return 12.0; // Mittlerer Abstand für Tablets
    } else {
      return 16.0; // Größerer Abstand für Desktops
    }
  }

  /// Gibt die Breite für einen Container basierend auf der Bildschirmgröße zurück
  static double getContainerWidth(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    
    if (isMobile(context)) {
      return width * 0.9; // 90% der Bildschirmbreite für Mobilgeräte
    } else if (isTablet(context)) {
      return width * 0.8; // 80% der Bildschirmbreite für Tablets
    } else {
      return width * 0.7; // 70% der Bildschirmbreite für Desktops
    }
  }

  /// Gibt die Schriftgröße basierend auf der Bildschirmgröße zurück
  static double getFontSize(BuildContext context, {required double base}) {
    if (isMobile(context)) {
      return base; // Basis-Schriftgröße für Mobilgeräte
    } else if (isTablet(context)) {
      return base * 1.1; // 10% größer für Tablets
    } else {
      return base * 1.2; // 20% größer für Desktops
    }
  }

  /// Gibt den Seitenrand basierend auf der Bildschirmgröße zurück
  static EdgeInsets getPadding(BuildContext context) {
    if (isMobile(context)) {
      return const EdgeInsets.all(12.0); // Kleinerer Rand für Mobilgeräte
    } else if (isTablet(context)) {
      return const EdgeInsets.all(16.0); // Mittlerer Rand für Tablets
    } else {
      return const EdgeInsets.all(24.0); // Größerer Rand für Desktops
    }
  }

  /// Gibt ein responsives Layout zurück, das je nach Bildschirmgröße unterschiedliche Widgets anzeigt
  static Widget responsiveLayout({
    required BuildContext context,
    required Widget mobile,
    Widget? tablet,
    Widget? desktop,
  }) {
    if (isDesktop(context) && desktop != null) {
      return desktop;
    } else if (isTablet(context) && tablet != null) {
      return tablet;
    } else {
      return mobile;
    }
  }
}
