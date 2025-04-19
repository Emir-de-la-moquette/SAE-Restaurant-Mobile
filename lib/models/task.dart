class Task {
  int id;
  String title;
  List<String> tags;
  int nbhours;
  int difficulty;
  String description;
  static int nb=0;

  Task({required this.id,required this.title,required this.tags,required this.nbhours,required this.difficulty,required this.description});

  factory Task.fromJson(Map<String,dynamic> json){
    final tags = <String>[];
    if (json["tags"]!=null){
      json["tags"].forEach((t){
        tags.add(t);
      });
    }
    return Task(id : json["id"],title : json["title"]??"not found",tags : tags,nbhours : json["nbhours"]??-1,difficulty : json["difficulty"]??-1,description : json["description"]??"not found");
  }

  factory Task.newTask(){
    nb++; //attribut static de la classe.
    return Task(id: nb, title: 'title $nb', tags: ['tags $nb'], nbhours: nb, difficulty: nb%5, description: 'description $nb');
  }

  factory Task.createTask(String ti, List<String> ta, int nbh, int d, String desc) {
    nb++;
    return Task(id: nb, title: ti, tags: ta, nbhours: nbh, difficulty: d, description: desc);
  }

  static List<Task> generateTask(int i){
    List<Task> tasks=[];
    for(int n=0;n<i;n++) {
      nb++;
      tasks.add(Task(id: n,
          title: "title $n",
          tags: ['tag $n', 'tag${n + 1}'],
          nbhours: n,
          difficulty: n,
          description: 'Description de la task $n'));
    }
    return tasks;
  }
}