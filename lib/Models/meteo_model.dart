class MeteoModel {
  final String ville;
  final double temperature;
  final String description;

  MeteoModel({
    required this.ville,
    required this.temperature,
    required this.description,
  });

  //Factory pour creer un objet JSON de l'API
  factory MeteoModel.fromJson(Map<String, dynamic> json) {
    return MeteoModel(
      ville: json['name'],
      temperature: json['main']['temp'].toDouble(),
      description: json['weather'][0]['description'],
    );
  }
}
