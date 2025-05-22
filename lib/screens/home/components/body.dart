import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plant_app/bloc/map_bloc.dart';
import 'package:plant_app/bloc/map_event.dart';
import 'package:plant_app/constants.dart';
import 'package:plant_app/screens/home/components/featurred_plants.dart';
import 'package:plant_app/screens/home/components/header_with_searchbox..dart';
import 'package:plant_app/screens/home/components/recomend_plants.dart';
import 'package:plant_app/screens/home/components/title_with_more_bbtn.dart';
import 'package:plant_app/screens/maps/maps_screen.dart'; // import halaman map

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String selectedAddress = '';

 Future<void> _goToMap() async {
  final result = await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => BlocProvider(
        create: (_) => MapBloc()..add(LoadCurrentLocation()),
        child: const MapsScreen(),
      ),
    ),
  );

  if (result != null && mounted) {
    setState(() {
      selectedAddress = result;
    });
  }
}


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          HeaderWithSearchBox(
            size: size,
            address: selectedAddress,
            onAddressTap: _goToMap, // passing function ke header
          ),
          TitleWithMoreBtn(title: "Recomended", press: () {}),
          RecomendsPlants(),
          TitleWithMoreBtn(title: "Featured Plants", press: () {}),
          FeaturedPlants(),
          const SizedBox(height: kDefaultPadding),
        ],
      ),
    );
  }
}
