import 'package:flutter/material.dart';
import 'package:my_little_food/api/myapi.dart';

import 'detail.dart';

class Ecran2 extends StatelessWidget {
  final MyAPI myAPI = MyAPI();

  Ecran2({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: myAPI.getTasks(), // récupération des données JSON
        builder: (context, snapshot) {
          // en attendant les données, petite simulation de chargement
          if (snapshot.connectionState != ConnectionState.done &&
              !snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // en cas d'erreur
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          // si tout est OK, on affiche les données
          if (snapshot.data != null) {
            return ListView.builder(
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (BuildContext context, index) {
                  return Card(
                      color: Colors.white,
                      elevation: 7,
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.greenAccent,
                          child:
                              Text(snapshot.data?[index].id.toString() ?? ""),
                        ),
                        title: Text(snapshot.data?[index].title ?? ""),
                        subtitle:
                            Text(snapshot.data?[index].tags.join(" ") ?? ""),
                        trailing: IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Detail(task: snapshot.data![index])));
                          },
                        ),
                      ));
                });
          }
          return Container();
        });
  }
}
