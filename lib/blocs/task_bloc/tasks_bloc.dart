import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:noteb/screens/pending_screen.dart';

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
    on<MarkFavoriteorUnFavoriteTask>(_onMarkFavoriteorUnFavoriteTask);
    on<EditTask>(_onEditTask);
    on<RestoreTask>(_onRestoreTaskEvent);
    on<DeleteAllTask>(_onDeleteAllTaskEvent);
  }

  void _onAddTask(AddTask event, Emitter<TasksState> emit) {
    final state = this.state;

    emit(TasksState(
      pendingTasks: List.from(state.pendingTasks)..add(event.task),
      completedTasks: state.completedTasks,
      favoriteTasks: state.favoriteTasks,
      removedTask: state.removedTask,
    ));
  }

  void _onUpdateTask(UpdateTask event, Emitter<TasksState> emit) {
    final state = this.state;
    final task = event.task;

    List<Task> pendingTasks = state.pendingTasks;
    List<Task> completedTasks = state.completedTasks;
    List<Task> favoriteTasks = state.favoriteTasks;
    if (task.isDone == false) {
      if (task.isFavorite == false) {
        pendingTasks = List.from(pendingTasks)..remove(task);
        completedTasks = List.from(completedTasks)
          ..insert(0, task.copyWith(isDone: true));
      } else {
        int taskIndex = state.favoriteTasks.indexOf(task);
        pendingTasks = List.from(pendingTasks)..remove(task);
        completedTasks.insert(0, task.copyWith(isDone: true));
        favoriteTasks = List.from(favoriteTasks)
          ..remove(task)
          ..insert(taskIndex, task.copyWith(isDone: true));
      }
    } else {
      if (task.isFavorite == false) {
        completedTasks = List.from(completedTasks)..remove(task);
        pendingTasks = List.from(pendingTasks)
          ..insert(0, task.copyWith(isDone: false));
      } else {
        int taskIndex = state.favoriteTasks.indexOf(task);
        completedTasks = List.from(completedTasks)..remove(task);
        pendingTasks = List.from(pendingTasks)
          ..insert(0, task.copyWith(isDone: false));
        favoriteTasks = List.from(favoriteTasks)
          ..remove(task)
          ..insert(taskIndex, task.copyWith(isDone: false));
      }
    }

    emit(TasksState(
        pendingTasks: pendingTasks,
        completedTasks: completedTasks,
        favoriteTasks: state.favoriteTasks,
        removedTask: state.removedTask));
  }

  void _onDeleteTask(DeleteTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(
      TasksState(
          pendingTasks: state.pendingTasks,
          completedTasks: state.completedTasks,
          favoriteTasks: state.favoriteTasks,
          removedTask: List.from(state.removedTask)..remove(event.task)),
    );
  }

  void _onRemoveTask(RemoveTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(TasksState(
        pendingTasks: List.from(state.pendingTasks)..remove(event.task),
        completedTasks: List.from(state.completedTasks)..remove(event.task),
        favoriteTasks: List.from(state.favoriteTasks)..remove(event.task),
        removedTask: List.from(state.removedTask)
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

  void _onMarkFavoriteorUnFavoriteTask(
      MarkFavoriteorUnFavoriteTask event, Emitter<TasksState> emit) {
    final state = this.state;
    List<Task> pendingTasks = state.pendingTasks;
    List<Task> completedTasks = state.completedTasks;
    List<Task> favoriteTasks = state.favoriteTasks;
    if (event.task.isDone == false) {
      if (event.task.isFavorite == false) {
        int index = pendingTasks.indexOf(event.task);
        pendingTasks = List.from(state.pendingTasks)
          ..removeAt(index)
          ..add(event.task.copyWith(isFavorite: true));
        favoriteTasks.insert(index, event.task.copyWith(isFavorite: true));
      } else {
        int index = pendingTasks.indexOf(event.task);
        pendingTasks = List.from(state.pendingTasks)
          ..removeAt(index)
          ..add(event.task.copyWith(isFavorite: false));
        favoriteTasks.remove(event.task);
      }
    } else {
      if (event.task.isFavorite == false) {
        int index = completedTasks.indexOf(event.task);
        completedTasks = List.from(state.completedTasks)
          ..removeAt(index)
          ..add(event.task.copyWith(isFavorite: true));
        favoriteTasks.insert(index, event.task.copyWith(isFavorite: true));
      } else {
        int index = completedTasks.indexOf(event.task);
        completedTasks = List.from(state.completedTasks)
          ..removeAt(index)
          ..add(event.task.copyWith(isFavorite: false));
        favoriteTasks.remove(event.task);
      }
    }
    emit(TasksState(
        completedTasks: state.completedTasks,
        pendingTasks: pendingTasks,
        favoriteTasks: favoriteTasks,
        removedTask: state.removedTask));
  }

  void _onEditTask(EditTask event, Emitter<TasksState> emit) {
    final state = this.state;
    List<Task> favoriteTasks = state.favoriteTasks;
    if (event.oldTask.isFavorite == true) {
      favoriteTasks
        ..remove(event.oldTask)
        ..insert(0, event.newTask);
    }
    emit(TasksState(
        pendingTasks: List.from(state.pendingTasks)
          ..remove(event.oldTask)
          ..insert(0, event.newTask),
        completedTasks: state.completedTasks,
        favoriteTasks: favoriteTasks,
        removedTask: state.removedTask));
  }

  void _onRestoreTaskEvent(RestoreTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(
      TasksState(
          removedTask: List.from(state.removedTask)..remove(event.task),
          pendingTasks: List.from(state.pendingTasks)
            ..insert(
                0,
                event.task.copyWith(
                    isDeleted: false, isDone: false, isFavorite: false)),
          completedTasks: state.completedTasks,
          favoriteTasks: state.favoriteTasks),
    );
  }

  void _onDeleteAllTaskEvent(DeleteAllTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(TasksState(
      removedTask: List.from(state.removedTask)..clear(),
      pendingTasks: state.pendingTasks,
      completedTasks: state.completedTasks,
      favoriteTasks: state.favoriteTasks,
    ));
  }
}
