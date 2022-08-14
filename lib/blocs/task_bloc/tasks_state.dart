// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'tasks_bloc.dart';

class TasksState extends Equatable {
  List<Task> pendingTasks;
  List<Task> favoriteTasks;
  List<Task> completedTasks;
  List<Task> removedTask;
  TasksState(
      {this.pendingTasks = const <Task>[],
      this.favoriteTasks = const <Task>[],
      this.completedTasks = const <Task>[],
      this.removedTask = const <Task>[]});

  @override
  List<Object> get props =>
      [pendingTasks, favoriteTasks, completedTasks, removedTask];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pendingTasks': pendingTasks.map((x) => x.toMap()).toList(),
      'favoriteTasks': favoriteTasks.map((x) => x.toMap()).toList(),
      'completedTasks': completedTasks.map((x) => x.toMap()).toList(),
      'removedTask': removedTask.map((x) => x.toMap()).toList(),
    };
  }

  factory TasksState.fromMap(Map<String, dynamic> map) {
    return TasksState(
      pendingTasks: List<Task>.from(
        (map['pendingTasks'] as List<int>).map<Task>(
          (x) => Task.fromMap(x as Map<String, dynamic>),
        ),
      ),
      favoriteTasks: List<Task>.from(
        (map['favoriteTasks'] as List<int>).map<Task>(
          (x) => Task.fromMap(x as Map<String, dynamic>),
        ),
      ),
      completedTasks: List<Task>.from(
        (map['completedTasks'] as List<int>).map<Task>(
          (x) => Task.fromMap(x as Map<String, dynamic>),
        ),
      ),
      removedTask: List<Task>.from(
        (map['removedTask'] as List<int>).map<Task>(
          (x) => Task.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}
