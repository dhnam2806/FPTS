part of 'task_bloc.dart';

@immutable
abstract class TaskEvent {}

class TaskInitialEvent extends TaskEvent {}

class AddTaskButtonPressedEvent extends TaskEvent {}

class AddTaskEvent extends TaskEvent {
  final String taskName;

  AddTaskEvent({required this.taskName});
}

class ToggleTaskEvent extends TaskEvent {
  final int taskIndex;

  ToggleTaskEvent(this.taskIndex);
}



