import 'package:flutter/material.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:great_places/utils/app_routes.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Lugares'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.PLACE_FORM);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false).loadPlaces(),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(child: CircularProgressIndicator())
                : Consumer<GreatPlaces>(
                    child: Center(
                      child: const Text('Nenhum local cadastrado'),
                    ),
                    builder: (ctx, greatPlaces, child) {
                      if (greatPlaces.itemsCount == 0) {
                        return child!;
                      }

                      return ListView.builder(
                        itemCount: greatPlaces.itemsCount,
                        itemBuilder: (ctx, i) {
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage:
                                  FileImage(greatPlaces.itemByIndex(i).image),
                            ),
                            title: Text(greatPlaces.itemByIndex(i).title),
                            subtitle: Text(
                              greatPlaces.itemByIndex(i).location.address ?? '',
                            ),
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                AppRoutes.PLACE_DETAILS,
                                arguments: greatPlaces.itemByIndex(i),
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
      ),
    );
  }
}
