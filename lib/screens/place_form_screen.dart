import 'dart:io';

import 'package:flutter/material.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:great_places/widgets/image_input.dart';
import 'package:great_places/widgets/location_input.dart';
import 'package:provider/provider.dart';

class PlaceFormScreen extends StatefulWidget {
  const PlaceFormScreen({super.key});

  @override
  State<PlaceFormScreen> createState() => _PlaceFormScreenState();
}

class _PlaceFormScreenState extends State<PlaceFormScreen> {
  final _titleController = TextEditingController();
  File _pickedImage = File('');

  void _selectImage(File image) {
    _pickedImage = image;
  }

  Future<void> _submitForm() async {
    if (_titleController.text.isEmpty || _pickedImage.path.isEmpty) {
      return;
    }

    final greatPlacesProvider =
        Provider.of<GreatPlaces>(context, listen: false);

    await greatPlacesProvider.addPlace(
      title: _titleController.text,
      image: _pickedImage,
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Lugar'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      controller: _titleController,
                      decoration: InputDecoration(labelText: 'Título'),
                    ),
                    const SizedBox(height: 10),
                    ImageInput(onSelectImage: _selectImage),
                    const SizedBox(height: 10),
                    LocationInput(),
                  ],
                ),
              ),
            ),
            ElevatedButton.icon(
              onPressed: _submitForm,
              icon: const Icon(Icons.add),
              label: const Text('Adicionar'),
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll<Color>(Colors.amber),
                surfaceTintColor: WidgetStatePropertyAll<Color>(Colors.amber),
              ),
            )
          ],
        ),
      ),
    );
  }
}
