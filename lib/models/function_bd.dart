import 'package:postgres/postgres.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'dart:io';



Future<PostgreSQLConnection> createConnection() async {
  final connection = PostgreSQLConnection(
    'aws-0-eu-west-3.pooler.supabase.com',
    5432,
    'postgres',
    username: 'postgres.vicnhizlpnnchlerpqtr',
    password: 'SAEMLF2025.',
  );
  await connection.open();
  return connection;
}


Future<List<Restaurant>> getMeilleurRestaurant(
    String codeRegion, String codeDepartement, String codeCommune, MySqlConnection conn) async {
  List<Restaurant> sortie = [];
  List<String> localisation = await lesNomsRegions(codeRegion, codeDepartement, codeCommune);

  var results = await conn.query(
      """
      SELECT r.*, AVG(NULLIF(n.Note, 0)) AS moy 
      FROM RESTAURANT r 
      LEFT JOIN NOTER n ON r.OsmID = n.OsmID 
      LEFT JOIN COMMUNE c ON r.CodeCommune = c.CodeCommune 
      LEFT JOIN DEPARTEMENT d ON c.CodeDepartement = d.CodeDepartement 
      LEFT JOIN REGION reg ON d.CodeRegion = reg.CodeRegion 
      WHERE c.codeRegion = ? AND c.codeDepartement = ? AND c.codeCommune = ? 
      GROUP BY r.OsmID ORDER BY moy, r.OsmID;
      """,
      [codeRegion, codeDepartement, codeCommune]);

  for (var row in results) {
    if (sortie.length < 10) {
      List<String> cuisine = [];
      var cuisineResults = await conn.query(
          "SELECT * FROM RESTAURANT NATURAL JOIN PREPARER WHERE OsmID = ?", [row['OsmID']]);

      for (var row2 in cuisineResults) {
        cuisine.add(row2['nomcuisine'] as String);
      }

      var restaurant = Restaurant(
        row['OsmID'],
        row['nomrestaurant'],
        row['description'] ?? "",
        localisation[0],
        localisation[1],
        localisation[2],
        row['longitude'],
        row['latitude'],
        row['siteweb'] ?? "",
        row['facebook'] ?? "",
        row['telrestaurant'] ?? "",
        (row['moy'] as double?) ?? 0.0,
        row['capacite'] ?? 0,
        row['fumeur'] ?? 0,
        row['drive'] ?? 0,
        row['aemporter'] ?? 0,
        row['livraison'] ?? 0,
        row['vegetarien'] ?? 0,
        row['horrairesouverture'] ?? "",
        cuisine,
        await fetchNoteRestaurant(row['OsmID']),
      );

      sortie.add(restaurant);
    }
  }
  return sortie;
}

Future<List<Restaurant>> getRestaurantPopulaire(
    String codeRegion, String codeDepartement, String codeCommune, PostgreSQLConnection conn) async {
  List<Restaurant> sortie = [];
  List<String> localisation = await lesNomsRegions(codeRegion, codeDepartement, codeCommune);

  var results = await conn.query(
      """
      SELECT r.*, AVG(NULLIF(n.Note, 0)) AS moy, COUNT(n.Note) AS place 
      FROM RESTAURANT r 
      LEFT JOIN NOTER n ON r.OsmID = n.OsmID 
      LEFT JOIN COMMUNE c ON r.CodeCommune = c.CodeCommune 
      LEFT JOIN DEPARTEMENT d ON c.CodeDepartement = d.CodeDepartement 
      LEFT JOIN REGION reg ON d.CodeRegion = reg.CodeRegion 
      WHERE c.codeRegion = @codeRegion AND c.codeDepartement = @codeDepartement AND c.codeCommune = @codeCommune 
      GROUP BY r.OsmID ORDER BY place, moy, r.OsmID;
      """,
      substitutionValues: {
        'codeRegion': codeRegion,
        'codeDepartement': codeDepartement,
        'codeCommune': codeCommune
      });

  for (var row in results) {
    if (sortie.length < 10) {
      List<String> cuisine = [];
      var cuisineResults = await conn.query(
          "SELECT * FROM RESTAURANT NATURAL JOIN PREPARER WHERE OsmID = @osmid",
          substitutionValues: {'osmid': row["osmid"]});

      for (var row2 in cuisineResults) {
        cuisine.add(row2["nomcuisine"] as String);
      }

      var restaurant = Restaurant(
        row["osmid"],
        row["nomrestaurant"],
        row["description"] ?? "",
        localisation[0],
        localisation[1],
        localisation[2],
        row["longitude"],
        row["latitude"],
        row["siteweb"] ?? "",
        row["facebook"] ?? "",
        row["telrestaurant"] ?? "",
        (row["moy"] as double?) ?? 0.0,
        row["capacite"] ?? 0,
        row["fumeur"] ?? 0,
        row["drive"] ?? 0,
        row["aemporter"] ?? 0,
        row["livraison"] ?? 0,
        row["vegetarien"] ?? 0,
        row["horrairesouverture"] ?? "",
        cuisine,
        await fetchNoteRestaurant(row["osmid"]),
      );

      sortie.add(restaurant);
    }
  }
  return sortie;
}



Future<void> chargementFichier(String chemin, PostgreSQLConnection conn) async {
  print("test");

  String content = await File(chemin).readAsString();
  List<dynamic> restaurants = jsonDecode(content);

  for (var restaurant in restaurants) {
    try {
      await conn.query(
        "INSERT INTO REGION(CodeRegion, NomRegion) VALUES (@codeRegion, @nomRegion) ON CONFLICT DO NOTHING",
        substitutionValues: {
          'codeRegion': restaurant["code_region"],
          'nomRegion': restaurant["region"]
        },
      );
    } catch (e) {}

    try {
      await conn.query(
        "INSERT INTO DEPARTEMENT(CodeDepartement, CodeRegion, NomDepartement) VALUES (@codeDepartement, @codeRegion, @nomDepartement) ON CONFLICT DO NOTHING",
        substitutionValues: {
          'codeDepartement': restaurant["code_departement"],
          'codeRegion': restaurant["code_region"],
          'nomDepartement': restaurant["departement"]
        },
      );
    } catch (e) {}

    try {
      await conn.query(
        "INSERT INTO COMMUNE(CodeCommune, CodeDepartement, CodeRegion, NomCommune) VALUES (@codeCommune, @codeDepartement, @codeRegion, @nomCommune) ON CONFLICT DO NOTHING",
        substitutionValues: {
          'codeCommune': restaurant["code_commune"],
          'codeDepartement': restaurant["code_departement"],
          'codeRegion': restaurant["code_region"],
          'nomCommune': restaurant["commune"]
        },
      );
    } catch (e) {}

    try {
      await conn.query(
        "INSERT INTO RESTAURANT(OsmID, Longitude, Latitude, CodeCommune, CodeDepartement, CodeRegion, NomRestaurant, SiteWeb, Facebook, TelRestaurant, NbEtoileMichelin, Capacite, Fumeur, AEmporter, Livraison, Vegetarien, Drive, HorrairesOuverture) VALUES (@osmID, @longitude, @latitude, @codeCommune, @codeDepartement, @codeRegion, @nomRestaurant, @siteWeb, @facebook, @telRestaurant, @nbEtoile, @capacite, @fumeur, @aEmporter, @livraison, @vegetarien, @drive, @horrairesOuverture) ON CONFLICT DO NOTHING",
        substitutionValues: {
          'osmID': restaurant["osm_id"].substring(5),
          'longitude': restaurant["geo_point_2d"]["lon"],
          'latitude': restaurant["geo_point_2d"]["lat"],
          'codeCommune': restaurant["code_commune"],
          'codeDepartement': restaurant["code_departement"],
          'codeRegion': restaurant["code_region"],
          'nomRestaurant': restaurant["name"],
          'siteWeb': restaurant["website"],
          'facebook': restaurant["facebook"],
          'telRestaurant': restaurant["phone"],
          'nbEtoile': restaurant["stars"],
          'capacite': restaurant["capacity"],
          'fumeur': restaurant["smoking"] == "yes" ? 1 : 0,
          'aEmporter': restaurant["takeaway"] == "yes" ? 1 : 0,
          'livraison': restaurant["delivery"] == "yes" ? 1 : 0,
          'vegetarien': restaurant["vegetarian"] == "yes" ? 1 : 0,
          'drive': restaurant["drive_through"] == "yes" ? 1 : 0,
          'horrairesOuverture': restaurant["opening_hours"]
        },
      );
    } catch (e) {}

    for (var nom in restaurant["cuisine"] ?? []) {
      try {
        await conn.query(
          "INSERT INTO CUISINE(NomCuisine) VALUES (@nomCuisine) ON CONFLICT DO NOTHING",
          substitutionValues: {'nomCuisine': nom},
        );
      } catch (e) {}

      try {
        await conn.query(
          "INSERT INTO PREPARER(NomCuisine, OsmID) VALUES (@nomCuisine, @osmID) ON CONFLICT DO NOTHING",
          substitutionValues: {
            'nomCuisine': nom,
            'osmID': restaurant["osm_id"].substring(5)
          },
        );
      } catch (e) {}
    }
  }
}






Future<bool> utilisateurExistant(String mail, String mdp, PostgreSQLConnection conn) async {
  var bytes = utf8.encode(mdp);
  var hash = sha256.convert(bytes).toString();

  var results = await conn.query(
    "SELECT * FROM PERSONNE WHERE EMailPersonne = @mail AND MotDePasse = @mdp",
    substitutionValues: {
      'mail': mail,
      'mdp': hash
    },
  );

  return results.isNotEmpty;
}


//utilisateurExistant("", "");





Future<List<Map<String, dynamic>>> getUtilisateur(String mail, PostgreSQLConnection conn) async {
  var results = await conn.mappedResultsQuery(
    "SELECT * FROM PERSONNE WHERE EMailPersonne = @mail",
    substitutionValues: {
      'mail': mail,
    },
  );

  return results.map((row) => row["personne"]!).toList();
}


// chargementFichier(__DIR__."./../../data/restaurants_orleans.json");





Future<void> insertClient(String nom, String prenom, String tel, String email, String codeRegion, String codeDepartement, String codeCommune, String mdp, bool handicap, PostgreSQLConnection conn) async {
  var bytes = utf8.encode(mdp);
  var hash = sha256.convert(bytes).toString();

  await conn.query(
    "INSERT INTO PERSONNE (EMailPersonne, PrenomPersonne, NomPersonne, TelPersonne, MotDePasse, Role, codeRegion, codeDepartement, codeCommune, Handicap) VALUES (@email, @prenom, @nom, @tel, @hash, 'Client', @codeRegion, @codeDepartement, @codeCommune, @handicap)",
    substitutionValues: {
      'email': email,
      'prenom': prenom,
      'nom': nom,
      'tel': tel,
      'hash': hash,
      'codeRegion': codeRegion,
      'codeDepartement': codeDepartement,
      'codeCommune': codeCommune,
      'handicap': handicap
    },
  );
}





Future<void> insertClient(String nom, String prenom, String tel, String email, String codeRegion, String codeDepartement, String codeCommune, String mdp, bool handicap, PostgreSQLConnection conn) async {
  var bytes = utf8.encode(mdp);
  var hash = sha256.convert(bytes).toString();

  await conn.query(
    "INSERT INTO PERSONNE (EMailPersonne, PrenomPersonne, NomPersonne, TelPersonne, MotDePasse, Role, codeRegion, codeDepartement, codeCommune, Handicap) VALUES (@email, @prenom, @nom, @tel, @hash, 'Client', @codeRegion, @codeDepartement, @codeCommune, @handicap)",
    substitutionValues: {
      'email': email,
      'prenom': prenom,
      'nom': nom,
      'tel': tel,
      'hash': hash,
      'codeRegion': codeRegion,
      'codeDepartement': codeDepartement,
      'codeCommune': codeCommune,
      'handicap': handicap
    },
  );
}





Future<void> insertClient(String nom, String prenom, String tel, String email, String codeRegion, String codeDepartement, String codeCommune, String mdp, bool handicap, PostgreSQLConnection conn) async {
  var bytes = utf8.encode(mdp);
  var hash = sha256.convert(bytes).toString();

  await conn.query(
    "INSERT INTO PERSONNE (EMailPersonne, PrenomPersonne, NomPersonne, TelPersonne, MotDePasse, Role, codeRegion, codeDepartement, codeCommune, Handicap) VALUES (@email, @prenom, @nom, @tel, @hash, 'Client', @codeRegion, @codeDepartement, @codeCommune, @handicap)",
    substitutionValues: {
      'email': email,
      'prenom': prenom,
      'nom': nom,
      'tel': tel,
      'hash': hash,
      'codeRegion': codeRegion,
      'codeDepartement': codeDepartement,
      'codeCommune': codeCommune,
      'handicap': handicap
    },
  );
}





Future<void> insertClient(String nom, String prenom, String tel, String email, String codeRegion, String codeDepartement, String codeCommune, String mdp, bool handicap, PostgreSQLConnection conn) async {
  var bytes = utf8.encode(mdp);
  var hash = sha256.convert(bytes).toString();

  await conn.query(
    "INSERT INTO PERSONNE (EMailPersonne, PrenomPersonne, NomPersonne, TelPersonne, MotDePasse, Role, codeRegion, codeDepartement, codeCommune, Handicap) VALUES (@email, @prenom, @nom, @tel, @hash, 'Client', @codeRegion, @codeDepartement, @codeCommune, @handicap)",
    substitutionValues: {
      'email': email,
      'prenom': prenom,
      'nom': nom,
      'tel': tel,
      'hash': hash,
      'codeRegion': codeRegion,
      'codeDepartement': codeDepartement,
      'codeCommune': codeCommune,
      'handicap': handicap
    },
  );
}


Future<void> modifNote(String email, String osmid, int note, String commentaire, PostgreSQLConnection conn) async {
  await conn.query(
    "UPDATE NOTER SET Note = @note, Commentaire = @commentaire WHERE EMailPersonne = @email AND OsmID = @osmid",
    substitutionValues: {
      'email': email,
      'osmid': osmid,
      'note': note,
      'commentaire': commentaire,
    },
  );
}

Future<List<Map<String, dynamic>>> getCommentaire(String mail, PostgreSQLConnection conn) async {
  var results = await conn.query(
    "SELECT * FROM NOTER WHERE EMailPersonne = @mail",
    substitutionValues: {
      'mail': mail,
    },
  );
  return results.toList();
}

Future<List<Note>> fetchNoteRestaurant(String osmid, PostgreSQLConnection conn) async {
  var results = await conn.query(
    "SELECT * FROM NOTER NATURAL JOIN PERSONNE WHERE OsmID = @osmid",
    substitutionValues: {
      'osmid': osmid,
    },
  );
  return results.map((row) => Note(
    row['emailpersonne'],
    row['note'],
    row['commentaire'],
    row['date'],
    row['nompersonne'],
    row['prenompersonne'],
  )).toList();
}

Future<List<Map<String, dynamic>>> getPrefCuisine(String email, PostgreSQLConnection conn) async {
  var results = await conn.query(
    "SELECT nomCuisine FROM PREFERER WHERE EMailPersonne = @email",
    substitutionValues: {
      'email': email,
    },
  );
  return results.toList();
}



Future<List<List<String>>> getRegion(String ville, PostgreSQLConnection conn) async {
  var results = await conn.query(
    "SELECT * FROM COMMUNE NATURAL JOIN DEPARTEMENT NATURAL JOIN REGION WHERE NomCommune = @ville",
    substitutionValues: {
      'ville': ville,
    },
  );
  return results.map((row) => [row['nomdepartement'], row['nomregion']]).toList();
}

Future<List<Restaurant>> getBestResto(PostgreSQLConnection conn) async {
  return await getMeilleurRestaurant(24, 45, 45234, conn);
}

Future<List<Restaurant>> getPopResto(PostgreSQLConnection conn) async {
  return await getRestaurantPopulaire(24, 45, 45234, conn);
}

Future<Restaurant> getRestoById(String osmid, PostgreSQLConnection conn) async {
  var result = await conn.query(
    "SELECT r.*, AVG(NULLIF(n.Note, 0)) AS moy FROM RESTAURANT r LEFT JOIN NOTER n ON r.OsmID = n.OsmID LEFT JOIN COMMUNE c ON r.CodeCommune = c.CodeCommune LEFT JOIN DEPARTEMENT d ON c.CodeDepartement = d.CodeDepartement LEFT JOIN REGION reg ON d.CodeRegion = reg.CodeRegion WHERE r.OsmID = @osmid GROUP BY r.OsmID",
    substitutionValues: {
      'osmid': osmid,
    },
  );

  var row = result.first;
  var cuisineResults = await conn.query(
    "SELECT * FROM RESTAURANT NATURAL JOIN PREPARER WHERE OsmID = @osmid",
    substitutionValues: {
      'osmid': osmid,
    },
  );
  List<String> cuisines = cuisineResults.map((row) => row['nomcuisine'] as String).toList();

  return Restaurant(
    row['osmid'],
    row['nomrestaurant'],
    row['description'] ?? '',
    row['nomregion'],
    row['nomdepartement'],
    row['nomcommune'],
    row['longitude'],
    row['latitude'],
    row['siteweb'] ?? '',
    row['facebook'] ?? '',
    row['telrestaurant'] ?? '',
    row['moy']?.toDouble() ?? 0.0,
    row['capacite'] ?? 0,
    row['fumeur'] ?? 0,
    row['drive'] ?? 0,
    row['aemporter'] ?? 0,
    row['livraison'] ?? 0,
    row['vegetarien'] ?? 0,
    row['horrairesouverture'] ?? '',
    cuisines,
    await fetchNoteRestaurant(row['osmid'], conn),
  );
}



Future<bool> estFavoris(String mail, String osmid, PostgreSQLConnection conn) async {
  var results = await conn.query(
    "SELECT * FROM FAVORI WHERE EmailPersonne = @mail AND OsmID = @osmid",
    substitutionValues: {
      'mail': mail,
      'osmid': osmid,
    },
  );
  return results.isNotEmpty;
}

Future<List<String>> lesNomsRegions(int codeRegion, int codeDepartement, int codeCommune, PostgreSQLConnection conn) async {
  var results = await conn.query(
    "SELECT * FROM REGION NATURAL JOIN DEPARTEMENT NATURAL JOIN COMMUNE WHERE codeRegion = @codeRegion AND codeDepartement = @codeDepartement AND codeCommune = @codeCommune",
    substitutionValues: {
      'codeRegion': codeRegion,
      'codeDepartement': codeDepartement,
      'codeCommune': codeCommune,
    },
  );
  var row = results.first;
  return [row['nomregion'], row['nomdepartement'], row['nomcommune']];
}

Future<void> ajouterSupprimerFavoris(String mail, String osmid, PostgreSQLConnection conn) async {
  try {
    await conn.query(
      "INSERT INTO FAVORI (EmailPersonne, OsmID) VALUES (@mail, @osmid)",
      substitutionValues: {
        'mail': mail,
        'osmid': osmid,
      },
    );
  } catch (e) {
    await conn.query(
      "DELETE FROM FAVORI WHERE EmailPersonne = @mail AND OsmID = @osmid",
      substitutionValues: {
        'mail': mail,
        'osmid': osmid,
      },
    );
  }
}

Future<List<Map<String, dynamic>>> fetchCuisine(PostgreSQLConnection conn) async {
  var results = await conn.query("SELECT * FROM CUISINE");
  return results.map((row) {
    return {
      'nomCuisine': row['nomCuisine'],
    };
  }).toList();
}


Future<List<Map<String, dynamic>>> getRestauAll(PostgreSQLConnection conn) async {
  var results = await conn.query(
    "SELECT r.*, AVG(NULLIF(n.Note, 0)) AS moy FROM RESTAURANT r LEFT JOIN NOTER n ON r.OsmID = n.OsmID LEFT JOIN COMMUNE c ON r.CodeCommune = c.CodeCommune LEFT JOIN DEPARTEMENT d ON c.CodeDepartement = d.CodeDepartement LEFT JOIN REGION reg ON d.CodeRegion = reg.CodeRegion GROUP BY r.OsmID;",
  );
  return results.map((row) {
    return {
      'OsmID': row['osmid'],
      'NomRestaurant': row['nomrestaurant'],
      'moy': row['moy'],
    };
  }).toList();
}

Future<List<Map<String, dynamic>>> getRestByName(String name, String ville, PostgreSQLConnection conn) async {
  String query = "SELECT r.*, AVG(NULLIF(n.Note, 0)) AS moy FROM RESTAURANT r LEFT JOIN NOTER n ON r.OsmID = n.OsmID LEFT JOIN COMMUNE c ON r.CodeCommune = c.CodeCommune LEFT JOIN DEPARTEMENT d ON c.CodeDepartement = d.CodeDepartement LEFT JOIN REGION reg ON d.CodeRegion = reg.CodeRegion GROUP BY r.OsmID;";

  if (name.isNotEmpty && ville.isNotEmpty) {
    query = '''
      SELECT r.*, AVG(NULLIF(n.Note, 0)) AS moy
      FROM RESTAURANT r
      LEFT JOIN NOTER n ON r.OsmID = n.OsmID
      LEFT JOIN COMMUNE c ON r.CodeCommune = c.CodeCommune
      LEFT JOIN DEPARTEMENT d ON c.CodeDepartement = d.CodeDepartement
      LEFT JOIN REGION reg ON d.CodeRegion = reg.CodeRegion
      WHERE nomrestaurant LIKE @name AND nomcommune = @ville
      GROUP BY r.OsmID;
    ''';
  }

  var results = await conn.query(query, substitutionValues: {
    'name': '$name%',
    'ville': ville,
  });

  return results.map((row) {
    return {
      'OsmID': row['osmid'],
      'NomRestaurant': row['nomrestaurant'],
      'moy': row['moy'],
    };
  }).toList();
}

Future<List<String>> getNomCuisine(PostgreSQLConnection conn) async {
  var results = await conn.query("SELECT nomcuisine FROM CUISINE");
  return results.map((row) => row['nomcuisine'] as String).toList();
}

Future<void> getImputeNomCuisine(PostgreSQLConnection conn) async {
  try {
    var results = await conn.query("SELECT nomcuisine FROM CUISINE");

    for (var row in results) {
      print('<input class="styled" type="submit" id=${row['nomcuisine']} name="nourriture" value="${row['nomcuisine']}" ${row['nomcuisine']} />');
    }
  } catch (e) {
    print('Exception received: ${e.toString()}');
    for (int i = 0; i < 5; i++) {
      print('<input class="styled" type="button" id="X" name="X" value="food" X />');
    }
  }
}





Future<List<String>> getPOSTNomCuisine(PostgreSQLConnection conn, Map<String, dynamic> postData) async {
  List<String> listeNomCuisineActif = [];

  try {
    // Fetch all cuisines from the database
    var results = await conn.query("SELECT nomcuisine FROM CUISINE");
    List<String> resultat = results.map((row) => row['nomcuisine'] as String).toList();

    // Loop through the POST data
    postData.forEach((key, value) {
      if (resultat.contains(value)) {
        listeNomCuisineActif.add(value);
        print(value);
      }
    });

    return listeNomCuisineActif;
  } catch (e) {
    print('Exception received: ${e.toString()}');
    return listeNomCuisineActif;
  }
}




Future<List<Restaurant>> getFavoris(PostgreSQLConnection conn, String email) async {
  List<Restaurant> sortie = [];

  try {
    // Query to fetch favorite restaurants
    var result = await conn.query("""
      SELECT r.*, AVG(NULLIF(n.Note, 0)) AS moy
      FROM RESTAURANT r
      LEFT JOIN NOTER n ON r.OsmID = n.OsmID
      LEFT JOIN COMMUNE c ON r.CodeCommune = c.CodeCommune
      LEFT JOIN DEPARTEMENT d ON c.CodeDepartement = d.CodeDepartement
      LEFT JOIN REGION reg ON d.CodeRegion = reg.CodeRegion
      LEFT JOIN FAVORI f ON f.OsmID = r.OsmID
      WHERE f.EMailPersonne = @email
      GROUP BY r.OsmID
      ORDER BY moy, r.OsmID;
    """, substitutionValues: {'email': email});

    for (var row in result) {
      if (sortie.length < 10) {
        // Get the region names
        List<String> localisation = await lesNomsRegions(conn, row['coderegion'], row['codedepartement'], row['codecommune']);

        // Fetch restaurant's cuisines
        List<String> cuisine = [];
        var cuisineResult = await conn.query("""
          SELECT * FROM RESTAURANT NATURAL JOIN PREPARER WHERE OsmID = @osmid;
        """, substitutionValues: {'osmid': row['osmid']});

        for (var row2 in cuisineResult) {
          cuisine.add(row2['nomcuisine']);
        }

        // Create a Restaurant object
        Restaurant restaurant = Restaurant(
          row['osmid'],
          row['nomrestaurant'],
          row['description'] ?? '',
          localisation[0],
          localisation[1],
          localisation[2],
          row['longitude'],
          row['latitude'],
          row['siteweb'] ?? '',
          row['facebook'] ?? '',
          row['telrestaurant'] ?? '',
          double.tryParse(row['moy'].toString()) ?? 0.0,
          row['capacite'] ?? 0,
          row['fumeur'] ?? 0,
          row['drive'] ?? 0,
          row['aemporter'] ?? 0,
          row['livraison'] ?? 0,
          row['vegetarien'] ?? 0,
          row['horrairesouverture'] ?? '',
          cuisine,
          await fetchNoteRestaurant(conn, row['osmid']),
        );

        sortie.add(restaurant);
      }
    }
  } catch (e) {
    print('Exception received: ${e.toString()}');
  }

  return sortie;
}

// Example helper function to fetch region names (can be adapted based on your needs)
Future<List<String>> lesNomsRegions(PostgreSQLConnection conn, String codeRegion, String codeDepartement, String codeCommune) async {
  var result = await conn.query("""
    SELECT nomregion, nomdepartement, nomcommune 
    FROM REGION NATURAL JOIN DEPARTEMENT NATURAL JOIN COMMUNE 
    WHERE codeRegion = @codeRegion AND codeDepartement = @codeDepartement AND codeCommune = @codeCommune;
  """, substitutionValues: {
    'codeRegion': codeRegion,
    'codeDepartement': codeDepartement,
    'codeCommune': codeCommune
  });

  List<String> localisation = [];
  for (var row in result) {
    localisation.add(row[0]);
    localisation.add(row[1]);
    localisation.add(row[2]);
  }

  return localisation;
}

// Example function to fetch restaurant notes (can be adapted as needed)
Future<List<Note>> fetchNoteRestaurant(PostgreSQLConnection conn, int osmid) async {
  var result = await conn.query("""
    SELECT * FROM NOTER WHERE OsmID = @osmid;
  """, substitutionValues: {'osmid': osmid});

  List<Note> notes = [];
  for (var row in result) {
    notes.add(Note(row['EmailPersonne'], row['Note'], row['Commentaire'], row['Date']));
  }

  return notes;
}

