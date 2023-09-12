import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/auth_main.dart';
import 'package:flash_chat/widgets/message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatScreen extends StatefulWidget {
  static const String id = "chat_screen";
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _messageController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  String? messageText;

  void getMessage() async {
    await _firestore.collection('messages').snapshots().listen((event) {
      event.docs.forEach((element) {
        print(element.data());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                //Implement logout functionality
                _auth.signOut();
                Navigator.pushNamedAndRemoveUntil(
                    context, AuthMain.id, (route) => false);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('messages').orderBy("time", descending: true).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final messages = snapshot.data;
                  List<MessageBubble> messageBubble = [];
                  for (var message in messages!.docs) {
                    final messageText = message.get('text');
                    final messageSender = message.get('sender');
                    final messageWidget = MessageBubble(
                      sender: messageSender,
                      text: messageText,
                      isMe: _auth.currentUser!.email == messageSender,
                    );

                    messageBubble.add(messageWidget);
                  }
                  return Expanded(
                    child: ListView(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      reverse: true,
                      children: messageBubble,
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: kMessageTextFieldDecoration,
                      onChanged: (value) {
                        //Do something with the user input.
                        messageText = value;
                      },
                      onEditingComplete: () {
                        _messageController.clear();
                        _firestore.collection('messages').add({
                          'text': messageText,
                          'sender': _auth.currentUser!.email,
                          'time': DateTime.now().millisecondsSinceEpoch,
                        });
                      }
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      //Implement send functionality.
                      _messageController.clear();
                      _firestore.collection('messages').add({
                        'text': messageText,
                        'sender': _auth.currentUser!.email,
                        'time': DateTime.now().millisecondsSinceEpoch,
                      });
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
