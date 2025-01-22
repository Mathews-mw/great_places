import 'package:flutter/material.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:great_places/screens/place_details_screen.dart';
import 'package:great_places/screens/place_form_screen.dart';
import 'package:great_places/screens/places_list_screen.dart';
import 'package:great_places/utils/app_routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => GreatPlaces(),
      child: MaterialApp(
        title: 'Great Places',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.indigo,
            primary: Colors.indigo, // Vibrant green for primary branding
            onPrimary: Colors.white, // White text/icons on primary color
            secondary: Colors.amber, // Bright blue for secondary elements
            onSecondary: Colors.white, // White text/icons on secondary color
            error: Colors.redAccent, // Red for error messages/alerts
            onError: Colors.white, // White text/icons on error color
            surface: Color(
                0xFFF5F5F5), // Light gray for surfaces like cards, dialogs
            onSurface:
                Color(0xFF333333), // Dark gray text/icons on surface color
            brightness: Brightness.light,
          ),
          appBarTheme: AppBarTheme().copyWith(
            backgroundColor: Theme.of(context).colorScheme.primary,
            titleTextStyle: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            iconTheme: IconThemeData().copyWith(
              color: Colors.white,
              weight: 10.0,
              size: 26.0,
            ),
          ),
          useMaterial3: true,
        ),
        home: const PlacesListScreen(),
        routes: {
          AppRoutes.PLACE_FORM: (ctx) => PlaceFormScreen(),
          AppRoutes.PLACE_DETAILS: (ctx) => PlaceDetailsScreen(),
        },
      ),
    );
  }
}
