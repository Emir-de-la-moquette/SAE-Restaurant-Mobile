import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:td2/models/class/note.dart';

void main() {
  late Note note;

  setUp(() {
    note = Note(
      mail: "test@example.com",
      note: 5,
      commentaire: "Excellent restaurant !",
      date: DateFormat("yyyy-MM-dd").format(DateTime.now().subtract(Duration(days: 400))),
      nomAuteur: "Dupont",
      prenomAuteur: "Jean",
    );
  });

  test("Les initiales sont correctes", () {
    expect(note.getInitiale(), "J D");
  });

  test("Le calcul de l'ancienneté du commentaire est correct", () {
    String dateDiff = note.getDateDiff();
    expect(dateDiff, "1 ans");
  });

  test("Le commentaire et la note sont bien assignés", () {
    expect(note.commentaire, "Excellent restaurant !");
    expect(note.note, 5);
  });
}
