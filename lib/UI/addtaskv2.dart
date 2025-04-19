import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:td2/viewmodels/taskviewmodels.dart';
import 'package:td2/models/task.dart';
class AddTaskV2 extends StatefulWidget {

  const AddTaskV2({super.key});

  @override
  State<AddTaskV2> createState() {
    return _AddTaskV2State();
  }
}

class _AddTaskV2State extends State<AddTaskV2> {
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter une task'),
      ),
      body: Center(
        child: FormBuilder(
            key: _formKey,
            child: Padding(
                padding: EdgeInsets.all(150.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FormBuilderTextField(
                    name: 'Title',
                    decoration: const InputDecoration(labelText: 'Title'),
                    validator:
                    FormBuilderValidators.compose([
                      FormBuilderValidators.required()
                    ]),
                  ),
                  FormBuilderTextField(
                    name: 'Description',
                    decoration: const InputDecoration(labelText: 'Description:'),
                    validator: FormBuilderValidators.compose(
                        [FormBuilderValidators.required()]),
                  ),
                  FormBuilderTextField(
                    name: 'Tags',
                    decoration: const InputDecoration(labelText: 'Tags:'),
                    validator: FormBuilderValidators.compose(
                        [FormBuilderValidators.required()]),
                  ),
                  FormBuilderTextField(
                    name: 'Difficulty',
                    decoration: const InputDecoration(labelText: 'Difficulté:'),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.integer()
                    ]),
                  ),
                  FormBuilderTextField(
                    name: 'NbHours',
                    decoration:
                    const InputDecoration(labelText: "Nombre d'heures:"),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.integer()
                    ]),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          textStyle: TextStyle(fontSize: 20),
                          backgroundColor: Colors.purple
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()){

                          context.read<TaskViewModel>().insertTask(
                              Task.createTask(
                                  _formKey.currentState?.fields['Title']?.value,
                                  ([_formKey.currentState?.fields['Tags']?.value]),
                                  int.parse(_formKey.currentState?.fields['NbHours']?.value),
                                  int.parse(_formKey.currentState?.fields['Difficulty']?.value),
                                  _formKey.currentState?.fields['Description']?.value
                              )
                          );
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('Ajouter')
                  )
                ],
              ),
            ),
        ),
      ),
    );
  }

}