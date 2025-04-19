import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'homes.dart';
import 'mytheme.dart';
import '../main.dart';
import '../models/model.dart';

class signupScreen extends StatefulWidget {
  @override
  _signupScreenState createState() => _signupScreenState();
}

class _signupScreenState extends State<signupScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _telController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  void _signup(
      String nom, String prenom, String tel, String mail, String mdp) async {
    if (_formKey.currentState!.validate()) {
      // context.go('/connexion');
      if (userExist(mail)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Compte déjà existant ❌")),
        );
      } else {
        if (inscription(nom, prenom, tel, mail, mdp)) {
          refreshPref(7);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Connexion réussie 🎉")),
          );
          context.go('/');
        }
      }
    }
  }

  void _login() async {
    context.go('/connexion');
  }

  @override
  void dispose() {
    _nomController.dispose();
    _prenomController.dispose();
    _telController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Créer un compte")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // nom
                TextFormField(
                  controller: _nomController,
                  decoration: InputDecoration(
                    labelText: "Nom",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Veuillez entrer votre nom";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),

                // preom
                TextFormField(
                  controller: _prenomController,
                  decoration: InputDecoration(
                    labelText: "Prénom",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Veuillez entrer votre prénom";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),

                // tel
                TextFormField(
                  controller: _telController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: "Numéro de téléphone",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      // return "Veuillez entrer votre numéro de téléphone";
                      value = "";
                      return null;
                    }
                    if (!RegExp(r'^\+?\d{8,15}$').hasMatch(value)) {
                      return "Numéro de téléphone invalide";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),

                // mail
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Veuillez entrer un email";
                    }
                    if (!RegExp(
                            r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                        .hasMatch(value)) {
                      return "Email invalide";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),

                // mdp
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Mot de passe",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Veuillez entrer un mot de passe";
                    }
                    // if (value.length < 6) {
                    //   return "Le mot de passe doit contenir au moins 6 caractères";
                    // }
                    return null;
                  },
                ),
                SizedBox(height: 16),

                // confirm mdp
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Confirmer le mot de passe",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Veuillez confirmer votre mot de passe";
                    }
                    if (value != _passwordController.text) {
                      return "Les mots de passe ne correspondent pas";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 24),

                ElevatedButton(
                  onPressed: () {
                    _signup(
                      _nomController.text,
                      _prenomController.text,
                      _telController.text,
                      _emailController.text,
                      _passwordController.text,
                    );
                  },
                  child: Text("Créer un compte"),
                ),
                TextButton(
                  onPressed: _login,
                  child: Text(
                    "Vous voulez vous connecter ?",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.blue,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
