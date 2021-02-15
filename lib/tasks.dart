List<String> todoName = ["krishbin", "Make your Nadika"];
List<String> todoDesp = ["fjkdj", "Be sure to be tucked in tightly"];
List<DateTime> dateTime = [DateTime.parse("2020-12-01")];
List<bool> completed = [false];

void addTodo(String taskname, String taskdesp, DateTime dtime, bool comp) {
  todoName.add(taskname);
  todoDesp.add(taskdesp);
  dateTime.add(dtime);
  completed.add(comp);
  //TODO:server side
}

void removeTodo(int index) {
  todoName.removeAt(index);
  todoDesp.removeAt(index);
  //TODO:server side
}
