import 'package:flutter/material.dart';

// Clase que representa un TextFormField personalizado con propiedades adicionales
class CostomTextFormFild extends StatelessWidget {
  // Constructor con parámetros obligatorios e opcionales
  CostomTextFormFild({
    Key? key,
    required this.hint,
    this.suffixIcon,
    this.onTapSuffixIcon,
    this.obscureText = false,
    this.validator,
    this.onChanged,
    this.onEditingComplete,
    this.controller,
    required this.prefixIcon,
    this.filled = false,
    this.enabled = true,
    this.initialValue,
  }) : super(key: key);

  // Propiedades que representan las propiedades del TextFormField
  String hint;
  IconData prefixIcon;
  IconData? suffixIcon;
  VoidCallback? onTapSuffixIcon;
  bool obscureText;
  bool filled;
  bool enabled;
  String? initialValue;

  TextEditingController? controller;
  Function()? onEditingComplete;

  String? Function(String?)? validator;
  Function(String)? onChanged;

  // Método build que devuelve el TextFormField personalizado
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        // Configuración inicial del TextFormField
        initialValue: initialValue,
        onEditingComplete: onEditingComplete,
        controller: controller,
        onChanged: onChanged,
        validator: validator,
        obscureText: obscureText,
        // Decoración del TextFormField
        decoration: InputDecoration(
          // Configuración del borde del TextFormField
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: const BorderSide(color: Colors.white),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: const BorderSide(color: Colors.green),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: const BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: const BorderSide(color: Colors.red),
          ),
          // Texto de ayuda del TextFormField
          hintText: hint,
          // Estilo del texto de ayuda
          hintStyle: const TextStyle(
            fontFamily: "Roboto",
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
          // Icono de prefijo del TextFormField
          prefixIcon: Icon(
            prefixIcon,
            color: Colors.green,
            size: 20,
          ),
          // Icono de sufijo del TextFormField
          suffixIcon: IconButton(
            icon: Icon(
              suffixIcon,
              color: Colors.grey,
              size: 20,
            ),
            onPressed: onTapSuffixIcon,
          ),
          // Configuración de relleno del TextFormField
          filled: filled,
          enabled: enabled,
        ),
      ),
    );
  }
}
