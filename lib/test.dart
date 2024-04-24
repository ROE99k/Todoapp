class ToDo {
  String tittle;
  String description;
  ToDo(this.tittle, this.description);
}

void main() {
  List<ToDo> todos = [
    ToDo("Lunch", "At 10pm"),
    ToDo("Read", "Finish all the chapters"),
    ToDo("Dance ", "Practice time at around 4 pm")
  ];

  todos.removeAt(1);
  todos[1] = ToDo("Study", "Finish all the chapters");
  for (ToDo t in todos) {
    print(t.tittle);
  }
}
