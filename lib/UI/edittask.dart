import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:td2/viewmodels/taskviewmodels.dart';
import 'package:td2/models/task.dart';

import '../models/task.dart';
class EditTask extends StatefulWidget {
  final Task task;
  const EditTask({super.key, required this.task});

  @override
  State<EditTask> createState() {
    return _EditTaskState(task: this.task);
  }
}

class _EditTaskState extends State<EditTask> {
  final _formKey = GlobalKey<FormBuilderState>();
  final Task task;

  _EditTaskState({required this.task});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editer une task'),
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
                    initialValue: this.task.title,
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

                          context.read<TaskViewModel>().editTask(
                                  widget.task.id ,
                                  _formKey.currentState?.fields['Title']?.value,
                                  ([_formKey.currentState?.fields['Tags']?.value]),
                                  int.parse(_formKey.currentState?.fields['NbHours']?.value),
                                  int.parse(_formKey.currentState?.fields['Difficulty']?.value),
                                  _formKey.currentState?.fields['Description']?.value
                          );
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('Modifier')
                  )
                ],
              ),
            ),
        ),
      ),
    );
  }

}