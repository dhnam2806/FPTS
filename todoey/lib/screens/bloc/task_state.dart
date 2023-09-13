part of 'task_bloc.dart';

@immutable
abstract class TaskState {}

class TaskActionState extends TaskState {
}

class TaskInitial extends TaskState {
}

class TaskLoadedState extends TaskState {
  final List<Task> tasks;

  TaskLoadedState({required this.tasks});
}

class TaskErrorState extends TaskState {
  final String message;

  TaskErrorState(this.message);
}   

class TaskLoadingState extends TaskState {}

class AddTaskPressedState extends TaskActionState {}

