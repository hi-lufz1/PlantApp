import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:plant_app/bloc/map_bloc.dart';
import 'package:plant_app/bloc/map_event.dart';
import 'package:plant_app/bloc/map_state.dart';

class MapsScreen extends StatefulWidget {
  const MapsScreen({super.key});

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pilih Alamat')),
      body: SafeArea(
        child: BlocBuilder<MapBloc, MapState>(
          builder: (context, state) {
            if (state.initialCamera == null || state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: state.initialCamera!,
                  onMapCreated: (ctrl) {},
                  onTap:
                      (latlng) =>
                          context.read<MapBloc>().add(PickLocation(latlng)),
                  markers:
                      state.pickedMarker != null ? {state.pickedMarker!} : {},
                  myLocationEnabled: true,
                ),
                Positioned(
                  top: 25,
                  left: 50,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(state.currentAddress ?? 'Kosong'),
                  ),
                ),
                if (state.pickedAddress != null)
                  Positioned(
                    bottom: 120,
                    left: 16,
                    right: 16,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          state.pickedAddress!,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: BlocBuilder<MapBloc, MapState>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (state.pickedAddress != null) ...[
                FloatingActionButton.extended(
                  onPressed: () => Navigator.pop(context, state.pickedAddress),
                  label: const Text("Pilih Alamat"),
                ),
                const SizedBox(height: 8),
                FloatingActionButton.extended(
                  onPressed:
                      () => context.read<MapBloc>().add(ClearPickedLocation()),
                  label: const Text("Hapus Alamat"),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}
