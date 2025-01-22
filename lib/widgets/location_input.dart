import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/screens/map_screen.dart';
import 'package:great_places/utils/location_util.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  Function(LatLng position) onSelectPosition;

  LocationInput({super.key, required this.onSelectPosition});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl = '';

  Future<void> _getCurrentUserLocation() async {
    try {
      final locationData = await Location().getLocation();

      if (locationData.latitude == null || locationData.longitude == null) {
        return;
      }

      final staticMapImageUrl = LocationUtil.generateLocationImagePreview(
        latitude: locationData.latitude!,
        longitude: locationData.longitude!,
      );

      setState(() {
        _previewImageUrl = staticMapImageUrl;
      });
    } catch (e) {
      // Caso o usuário não dê permissão para acessar sua localização
      return;
    }
  }

  Future<void> _selectOnMap() async {
    final selectedPosition = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        builder: (ctx) => MapScreen(),
      ),
    );

    if (selectedPosition == null) return;

    final staticMapImageUrl = LocationUtil.generateLocationImagePreview(
      latitude: selectedPosition.latitude,
      longitude: selectedPosition.longitude,
    );

    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });

    widget.onSelectPosition(selectedPosition);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _previewImageUrl.isNotEmpty
              ? Image.network(
                  _previewImageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : const Text('Localização não informada'),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              icon: const Icon(Icons.location_on),
              label: const Text('Localização atual'),
              onPressed: _getCurrentUserLocation,
            ),
            TextButton.icon(
              icon: const Icon(Icons.map),
              label: const Text('selecione no mapa'),
              onPressed: _selectOnMap,
            ),
          ],
        ),
      ],
    );
  }
}
