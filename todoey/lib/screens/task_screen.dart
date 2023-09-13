import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoey/models/task.dart';
import 'package:todoey/screens/add_task_screen.dart';

import '../widgets/task_list.dart';
import 'bloc/task_bloc.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final TaskBloc taskBloc = TaskBloc();

  @override
  void initState() {
    // TODO: implement initState
    taskBloc.add(TaskInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskBloc, TaskState>(
      bloc: taskBloc,
      listener: (context, state) {
        if (state is AddTaskPressedState) {
          showModalBottomSheet(
              context: context,
              builder: (context) => AddTaskScreen(
                    taskBloc: taskBloc,
                  ));
        }
      },
      listenWhen: (previous, current) => current is TaskActionState,
      buildWhen: (previous, current) => current is! TaskActionState,
      builder: (context, state) {
        if (state is TaskLoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is TaskLoadedState) {
          return Scaffold(
            backgroundColor: Colors.lightBlueAccent,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                taskBloc.add(AddTaskButtonPressedEvent());
              },
              backgroundColor: Colors.lightBlueAccent,
              child: Icon(Icons.add),
            ),
            body: SafeArea(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        padding: EdgeInsets.all(30.0),
                        child: Column(
                          children: [
                            CircleAvatar(
                              child: Icon(
                                Icons.list,
                                size: 40.0,
                                color: Colors.lightBlueAccent,
                              ),
                              backgroundColor: Colors.white,
                              radius: 30.0,
                            ),
                            SizedBox(height: 20.0),
                            Text(
                              'Todoey',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 48.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              '${state.tasks.length} Tasks',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                              ),
                            ),
                          ],
                        )),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(20),
                        height: 300,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0),
                          ),
                        ),
                        child: TaskList(tasks: state.tasks),
                      ),
                    )
                  ]),
            ),
          );
        }
        return Container();

      },
    );
  }
}
