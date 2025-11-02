import 'package:flutter/material.dart';

//import'package:projet1/pages/accueil.dart';
class Input extends StatelessWidget {
  final String label;
  final String hint;
  final bool obscureText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int maxlines;

  const Input({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.maxlines = 1, // par defaut 1
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 12.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        maxLength: maxlines > 1
            ? null
            : 25, // si multiligne, pas de limite de caracteres
        keyboardType: keyboardType,
        validator: validator,
        maxLines: maxlines,
        style: TextStyle(fontSize: 14.0),
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          prefixIcon: prefixIcon,

          suffixIcon: suffixIcon,
          suffixIconColor: Colors.blue,
          //labelStyle: TextStyle(color: Colors.white),
          hintText: hint,
          prefixIconColor: const Color.fromARGB(255, 137, 25, 138),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
        ),

        // validator: (value) {
        //   if (value == null || value.isEmpty) {
        //     return "Veuillez remplir votre  $label ";
        //   }
        //   return null;
        // },
      ),
    );
  }
}
