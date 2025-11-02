import 'package:flutter/material.dart';
import 'package:activiteaccesapi/widgets/input.dart';
import 'package:activiteaccesapi/Models/meteo_model.dart';
import 'package:activiteaccesapi/widgets/meteo_widget.dart';
import 'package:activiteaccesapi/services/meteo_service.dart';

class PrevisionInterface extends StatefulWidget {
  const PrevisionInterface({super.key, required this.title});
  final String title;

  @override
  State<PrevisionInterface> createState() => _PrevisionInterfaceState();
}

class _PrevisionInterfaceState extends State<PrevisionInterface> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //controlleurs
  final TextEditingController _nomVilleController = TextEditingController();
  bool _isLoading = false; // Indique si l'app attend une réponse du serveur
  // Map<String, dynamic>? _DonneesMeteo; // Stocke les données météo récupérées
  MeteoModel? _donneesMeteo;
  String? _erreur; // Message d'erreur à afficher si la requête échoue

  @override
  void dispose() {
    _nomVilleController.dispose();
    super.dispose();
  }

  // Méthode qui appelle l'API OpenWeather et met à jour l'état
  Future<void> _recupererDonnees() async {
    if (!_formKey.currentState!.validate()) return;
    final ville = _nomVilleController.text
        .trim(); // Récupère la ville saisie par l'utilisateur
    // Indique que le chargement commence (affiche le CircularProgressIndicator)
    setState(() {
      _isLoading = true;
      _erreur = null;
      _donneesMeteo = null;
    });
    final meteo = await MeteoService.fetchMeteo(ville);
    //print("Résultat API: $meteo"); // pour debug
    // Indique que le chargement commence (affiche le CircularProgressIndicator)
    setState(() {
      _isLoading = false;
      if (meteo == null) {
        _erreur = "Ville introuvable ou erreur de connexion.";
      } else {
        _donneesMeteo = meteo;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// =======================================================
      /// Projet : Activité Accès API Météo
      /// Auteur : Joseph ELEGBEDE
      /// Date : 02/11/2025
      /// Description : Page principale pour récupérer et afficher
      /// les données météo via OpenWeather API.
      /// =======================================================
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 8, 147, 246),
        title: const Text('Application météo'),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: const Text(
                      "Entrer le nom d'\ une ville",
                      style: TextStyle(
                        color: Color.fromARGB(255, 8, 147, 246),
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Input(
                    label: "Entrez une ville",
                    hint: "Ex : Cotonou, Paris, Dakar...",
                    controller: _nomVilleController,
                    keyboardType: TextInputType.text,
                    prefixIcon: const Icon(
                      Icons.location_city,
                      color: Color.fromARGB(255, 8, 147, 246),
                    ),
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? "Champ obligatoire: veuillez saisir le nom de la ville"
                        : null,
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _recupererDonnees,
                      icon: const Icon(Icons.search),
                      label: const Text("Obtenir la météo"),
                      style: ElevatedButton.styleFrom(
                        //fixedSize: Size(250, 60),
                        backgroundColor: const Color.fromARGB(255, 8, 147, 246),
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (_isLoading)
                    SizedBox(
                      height: 200,
                      child: Center(
                        child: Column(
                          children: [
                            CircularProgressIndicator(
                              color: Color.fromARGB(255, 8, 147, 246),
                              strokeWidth: 5, //anneau plus epais
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Chargement ...",
                              style: TextStyle(color: Colors.blue),
                            ),
                          ],
                        ),
                      ),
                    )
                  else if (_erreur != null)
                    Text(
                      _erreur!,
                      style: const TextStyle(color: Colors.red, fontSize: 16),
                    )
                  else if (_donneesMeteo != null)
                    MeteoWidget(donneesMeteo: _donneesMeteo!),
                  SizedBox(height: 180),
                  // Signature visible dans l'app
                  const Text(
                    "Développé par Joseph ELEGBEDE,  Date : 02/11/2025",
                    style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
            // const Divider(height: 30, thickness: 1),
            // SizedBox(
            //   height: 400, //appel direct de la classe Listedesredacters
            // ),
          ],
        ),
      ),
    );
  }
}
