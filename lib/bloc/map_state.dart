import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapState extends Equatable {
  final CameraPosition? initialCamera;
  final Marker? pickedMarker;
  final String? pickedAddress;
  final String? currentAddress;
  final bool isLoading;

  const MapState({
    this.initialCamera,
    this.pickedMarker,
    this.pickedAddress,
    this.currentAddress,
    this.isLoading = false,
  });

  MapState copyWith({
    CameraPosition? initialCamera,
    Marker? pickedMarker,
    String? pickedAddress,
    String? currentAddress,
    bool? isLoading,
  }) {
    return MapState(
      initialCamera: initialCamera ?? this.initialCamera,
      pickedMarker: pickedMarker,
      pickedAddress: pickedAddress,
      currentAddress: currentAddress ?? this.currentAddress,
      isLoading: isLoading ?? false,
    );
  }

  @override
  List<Object?> get props =>
      [initialCamera, pickedMarker, pickedAddress, currentAddress, isLoading];
}
