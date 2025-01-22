import 'package:flutter/material.dart';
import 'package:great_places/models/place.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  final bool isReadOnly;
  final PlaceLocation initialLocation;

  const MapScreen({
    super.key,
    this.isReadOnly = false,
    this.initialLocation = const PlaceLocation(
      latitude: 37.419857,
      longitude: -122.078827,
    ),
  });

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng _pickedPosition = LatLng(0, 0);

  void _selectPosition(LatLng position) {
    setState(() {
      _pickedPosition = position;
    });
  }

  @override
  void initState() {
    super.initState();

    if (widget.isReadOnly) {
      _pickedPosition = LatLng(
        widget.initialLocation.latitude,
        widget.initialLocation.longitude,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecione a posição'),
        actions: [
          if (widget.isReadOnly == false)
            IconButton(
              icon: Icon(Icons.check),
              onPressed: () {
                Navigator.of(context).pop(_pickedPosition);
              },
            ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.initialLocation.latitude,
            widget.initialLocation.longitude,
          ),
          zoom: 13,
        ),
        onTap: widget.isReadOnly ? null : _selectPosition,
        markers: {
          Marker(
            markerId: MarkerId('p1'),
            position: _pickedPosition,
          )
        },
      ),
    );
  }
}
