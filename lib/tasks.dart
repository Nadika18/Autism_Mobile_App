  List<String> todoName = [];
  List<String> todoDesp = [];
  List<DateTime> dateTime = [];
  List<bool> completed = [];

  void addTodo(String taskname,String taskdesp,DateTime dtime,bool comp){
    todoName.add(taskname);
    todoDesp.add(taskdesp);
    dateTime.add(dtime);
    completed.add(comp);
    //TODO:server side
  }

  void removeTodo(int index){
    todoName.removeAt(index);
    todoDesp.removeAt(index);
    //TODO:server side
  }
