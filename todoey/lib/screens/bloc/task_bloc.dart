import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todoey/data/task_item.dart';

import '../../models/task.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskInitial()) {
    on<TaskInitialEvent>(taskInitialEvent);
    on<AddTaskButtonPressedEvent>(addTaskButtonPressedEvent);
    on<AddTaskEvent>(addTaskEvent);
  }

  FutureOr<void> addTaskEvent(AddTaskEvent event, Emitter<TaskState> emit) {
    emit(TaskLoadingState());
    tasksItem.add(Task(name: event.taskName));
    try {
      emit(TaskLoadedState(tasks: tasksItem));
    } catch (e) {
      emit(TaskErrorState(e.toString()));
    }
  }

  FutureOr<void> taskInitialEvent(
      TaskInitialEvent event, Emitter<TaskState> emit) {
    emit(TaskLoadingState());
    try {
      emit(TaskLoadedState(tasks: tasksItem));
    } catch (e) {
      emit(TaskErrorState(e.toString()));
    }
  }

  FutureOr<void> addTaskButtonPressedEvent(AddTaskButtonPressedEvent event, Emitter<TaskState> emit) {
  emit (AddTaskPressedState());
  
  emit (TaskLoadedState(tasks: tasksItem));
  }
}
