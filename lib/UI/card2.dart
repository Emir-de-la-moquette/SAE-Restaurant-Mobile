import 'package:flutter/material.dart';
import 'package:td2/api/MyAPI.dart';

class Ecran2 extends StatelessWidget {
  final myAPI = MyAPI();

  Ecran2({super.key});

  @override
  Widget build(BuildContext context) {
    //return Container(
    //color: Colors.black,
    //child: const Center(
    //child: Text("Ecran2"),
    //)
    //);
    return FutureBuilder(
        future: myAPI.getTasks(),
        builder: (context, snapshot) {

          if (snapshot.connectionState!=ConnectionState.done && !snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }


          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          if (snapshot.data != null) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return Card(
                    elevation: 6,
                    margin: const EdgeInsets.all(10),
                    child:  ListTile(
                      leading: CircleAvatar(backgroundColor: Colors.deepPurple, child: Text(snapshot.data?[index].id.toString()??""),),
                      title: Text(snapshot.data?[index].title??""),
                      subtitle: Text(snapshot.data?[index].tags.join(" ")??""),
                    )
                );
              },
            );
          }

          return Container();

        }
    );
  }
}