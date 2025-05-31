// lib/modules/home/widgets/interest_dialog.dart (Modify this file)
import 'package:faculdadeextensao/core/constants.dart';
import 'package:flutter/material.dart';

// Assuming your Show model is accessible or you pass the title and date
// For simplicity, I'll add title and date as parameters.
// Your existing onConfirm and other logic should remain.

class InterestDialog extends StatefulWidget {
  final Function(String name, String email) onConfirm;
  final String showTitle; // Added for description
  final String showDate;  // Added for description

  const InterestDialog({
    Key? key,
    required this.onConfirm,
    required this.showTitle, // Pass this from where you call showDialog
    required this.showDate,  // Pass this from where you call showDialog
  }) : super(key: key);

  @override
  _InterestDialogState createState() => _InterestDialogState();
}

class _InterestDialogState extends State<InterestDialog> {
  final _formKey = GlobalKey<FormState>();
  String _name = "";
  String _email = "";

  // Add your existing state variables like isSubmitting, isSuccess etc.
  // For brevity, I'm skipping the full state management shown in React code.
  // You'll need to integrate this UI with your existing state.
  bool _isSubmitting = false; // Example
  bool _isSuccess = false;    // Example

  void _handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() => _isSubmitting = true);

      // Simulate API call and success/failure
      // Replace with your actual widget.onConfirm call
      // await widget.onConfirm(_name, _email);

      // Example simulation:
      await Future.delayed(const Duration(seconds: 1));
      bool success = true; // Or false for testing
      
      if (success) {
         widget.onConfirm(_name, _email); // Call your existing onConfirm
         setState(() {
           _isSuccess = true;
           _isSubmitting = false;
         });
         // Auto-close dialog after success message
         Future.delayed(const Duration(seconds: 2), () {
           if (mounted && _isSuccess) { // Check if still mounted
             Navigator.of(context).pop();
           }
         });
      } else {
        setState(() => _isSubmitting = false);
        // Show error if needed, your SnackBar will handle this mostly
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Falha no envio. Por favor, tente novamente.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Dialog( // Use Dialog for more control over constraints
      backgroundColor: gray800,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 425),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: _isSuccess ? _buildSuccessView() : _buildFormView(),
        ),
      ),
    );
  }

  Widget _buildFormView() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Registrar Interesse',
            style: Theme.of(context).dialogTheme.titleTextStyle,
          ),
          const SizedBox(height: 8),
          Text(
            'Manifeste seu interesse em participar de "${widget.showTitle}" no dia ${widget.showDate}.',
            style: Theme.of(context).dialogTheme.contentTextStyle,
          ),
          const SizedBox(height: 24),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Nome Completo',
              // className: "bg-gray-700 border-gray-600" handled by theme
            ),
            style: const TextStyle(color: Colors.white),
            onSaved: (value) => _name = value ?? "",
            validator: (value) =>
                (value == null || value.isEmpty) ? 'Por favor, insira seu nome' : null,
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'E-mail',
              // className: "bg-gray-700 border-gray-600" handled by theme
            ),
            style: const TextStyle(color: Colors.white),
            keyboardType: TextInputType.emailAddress,
            onSaved: (value) => _email = value ?? "",
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, insira seu e-mail';
              }
              if (!value.contains('@')) { // Basic email validation
                return 'Por favor, insira um e-mail válido';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(
                child: const Text('Cancelar', style: TextStyle(color: Colors.white)),
                onPressed: () => Navigator.of(context).pop(),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  side: BorderSide(color: gray600),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: _isSubmitting ? null : _handleSubmit,
                style: ElevatedButton.styleFrom(backgroundColor: rose600),
                child: Text(_isSubmitting ? 'Enviando...' : 'Registrar Interesse'),
              ),
            ],
          ),
        ],
      ),
    );
  }

   Widget _buildSuccessView() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
            color: Colors.green, // Tailwind green-600 is approx this
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.check, color: Colors.white, size: 28),
        ),
        const SizedBox(height: 16),
        Text(
          'Obrigado!',
          style: headline2Style.copyWith(fontSize: 20),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          "Registramos seu interesse em ${widget.showTitle}. Enviaremos atualizações sobre este evento.",
          textAlign: TextAlign.center,
          style: bodyTextStyle.copyWith(color: gray400),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}