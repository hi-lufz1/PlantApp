import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'map_event.dart';
import 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(const MapState()) {
    on<LoadCurrentLocation>(_onLoadCurrentLocation);
    on<PickLocation>(_onPickLocation);
    on<ClearPickedLocation>(_onClearPickedLocation);
  }

  Future<void> _onLoadCurrentLocation(
    LoadCurrentLocation event,
    Emitter<MapState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));
      final pos = await _getPermission();
      final cam = CameraPosition(target: LatLng(pos.latitude, pos.longitude), zoom: 10);

      final placemark = await placemarkFromCoordinates(pos.latitude, pos.longitude);
      final p = placemark.first;

      emit(state.copyWith(
        initialCamera: cam,
        currentAddress: '${p.name}, ${p.locality}, ${p.country}',
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      rethrow;
    }
  }

  Future<void> _onPickLocation(
    PickLocation event,
    Emitter<MapState> emit,
  ) async {
    final placemarks = await placemarkFromCoordinates(
      event.latLng.latitude,
      event.latLng.longitude,
    );
    final p = placemarks.first;

    final marker = Marker(
      markerId: const MarkerId('picked'),
      position: event.latLng,
      infoWindow: InfoWindow(
        title: p.name?.isNotEmpty == true ? p.name : 'Lokasi dipilih',
        snippet: '${p.street}, ${p.locality}',
      ),
    );

    emit(state.copyWith(
      pickedMarker: marker,
      pickedAddress: '${p.name}, ${p.street}, ${p.locality}, ${p.country}, ${p.postalCode}',
    ));
  }

  void _onClearPickedLocation(
    ClearPickedLocation event,
    Emitter<MapState> emit,
  ) {
    emit(state.copyWith(
      pickedMarker: null,
      pickedAddress: null,
    ));
  }

  Future<Position> _getPermission() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      throw 'Location services belum aktif.';
    }

    LocationPermission perm = await Geolocator.checkPermission();
    if (perm == LocationPermission.denied) {
      perm = await Geolocator.requestPermission();
      if (perm == LocationPermission.denied) {
        throw 'Izin lokasi ditolak.';
      }
    }

    if (perm == LocationPermission.deniedForever) {
      throw 'Izin lokasi ditolak permanen.';
    }

    return await Geolocator.getCurrentPosition();
  }
}
