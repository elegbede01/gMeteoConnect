import 'package:flutter/material.dart';
import 'package:activiteaccesapi/Models/meteo_model.dart';

class MeteoWidget extends StatelessWidget {
  final MeteoModel donneesMeteo;
  const MeteoWidget({super.key, required this.donneesMeteo});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                donneesMeteo.ville,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '${donneesMeteo.temperature.toStringAsFixed(1)}°C',
                style: const TextStyle(fontSize: 48, color: Colors.blue),
              ),
              const SizedBox(height: 10),
              Text(
                donneesMeteo.description.toUpperCase(),
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
