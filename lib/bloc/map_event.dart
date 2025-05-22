import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class MapEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadCurrentLocation extends MapEvent {}

class PickLocation extends MapEvent {
  final LatLng latLng;

  PickLocation(this.latLng);

  @override
  List<Object?> get props => [latLng];
}

class ClearPickedLocation extends MapEvent {}
