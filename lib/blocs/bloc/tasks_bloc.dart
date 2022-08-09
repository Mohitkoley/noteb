import 'package:equatable/equatable.dart';

import '../../model/task.dart';
import '../bloc_export.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends HydratedBloc<TasksEvent, TasksState> {
  TasksBloc() : super(TasksState()) {
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
    on<RemoveTask>(_onRemoveTask);
  }

  void _onAddTask(AddTask event, Emitter<TasksState> emit) {
    final state = this.state;

    emit(TasksState(
      allTasks: List.from(state.allTasks)..add(event.task),
      removedTask: state.removedTask,
    ));
  }

  void _onUpdateTask(UpdateTask event, Emitter<TasksState> emit) {
    final state = this.state;
    final task = event.task;
    int index = state.allTasks.indexOf(event.task);

    List<Task> allTask = List.from(state.allTasks)..remove(task);
    task.isDone == false
        ? allTask.insert(index, task.copyWith(isDone: true))
        : allTask.insert(index, task.copyWith(isDone: false));

    emit(TasksState(allTasks: allTask, removedTask: state.removedTask));
  }

  void _onDeleteTask(DeleteTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(
      TasksState(
          allTasks: List.from(state.allTasks)..remove(event.task),
          removedTask: List.from(state.allTasks)..remove(event.task)),
    );
  }

  void _onRemoveTask(RemoveTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(TasksState(
        allTasks: List.from(state.removedTask)
          ..add(event.task.copyWith(isDeleted: true))));
  }

  @override
  TasksState? fromJson(Map<String, dynamic> json) {
    return TasksState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(TasksState state) {
    return state.toMap();
  }
}
