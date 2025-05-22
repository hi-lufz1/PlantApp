import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plant_app/bloc/camera_bloc.dart';
import 'package:plant_app/bloc/camera_event.dart';
import 'package:plant_app/bloc/getmap_bloc/map_bloc.dart';
import 'package:plant_app/bloc/getmap_bloc/map_event.dart';
import 'package:plant_app/constants.dart';
import 'package:plant_app/screens/camera/camera_screen.dart';
import 'package:plant_app/screens/home/components/featurred_plants.dart';
import 'package:plant_app/screens/home/components/header_with_searchbox..dart';
import 'package:plant_app/screens/home/components/recomend_plants.dart';
import 'package:plant_app/screens/home/components/title_with_more_bbtn.dart';
import 'package:plant_app/screens/maps/maps_screen.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String selectedAddress = '';
  File? _profileImage;

  Future<void> _goToMap() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (_) => BlocProvider(
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

  Future<void> _openCamera() async {
    final file = await Navigator.push<File>(
      context,
      MaterialPageRoute(
        builder:
            (_) => BlocProvider(
              create: (_) => CameraBloc()..add(InitializeCamera()),
              child: const CameraScreen(),
            ),
      ),
    );

    if (file != null && mounted) {
      setState(() {
        _profileImage = file;
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
            onAddressTap: _goToMap,
            onCameraTap: _openCamera,
            profileImage: _profileImage,
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
