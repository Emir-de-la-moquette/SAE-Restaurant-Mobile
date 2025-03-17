import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:provider/provider.dart';
import '../models/task.dart';
import '../viewmodel/task_view_model.dart';
import 'detail.dart';


class FormulaireAjoute extends StatefulWidget {
  const FormulaireAjoute({super.key});

  @override
  State<FormulaireAjoute> createState() => _FormExampleState();
}

class _FormExampleState extends State<FormulaireAjoute> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          Text("nom de la tache",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
          TextFormField(
            decoration: const InputDecoration(hintText: 'nom de la tache'),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please give your tache';
              }
              return null;
            },
          ),

          Text("description",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
          TextFormField(
              decoration: const InputDecoration(hintText: 'Enter your description')
          ),

          Text("tag"),
          TextFormField(
            decoration: const InputDecoration(hintText: 'Enter your tag'),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please give your tag';
              }
              return null;
            },
          ),

          Text("difficulty",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
          TextFormField(
            decoration: const InputDecoration(hintText: 'Enter your difficulty'),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please give your difficulty';
              }
              return null;
            },
          ),

          Text("number of hours",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
          TextFormField(
            decoration: const InputDecoration(hintText: 'Enter your number of hours'),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please give your number of hours';
              }
              return null;
            },
          ),


          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Validate will return true if the form is valid, or false if
                // the form is invalid.
                if (_formKey.currentState!.validate()) {
                  // Process data.
                }
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
