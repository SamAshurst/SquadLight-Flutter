import 'package:flutter/material.dart';
import '/models/chat_model.dart';
import 'package:squadlight/inheritedSocket.dart';

class ChatScreenRed extends StatefulWidget {
  const ChatScreenRed({
    required Key key,
  }) : super(key: key);

  @override
  _ChatScreenRedState createState() => _ChatScreenRedState();
}

class _ChatScreenRedState extends State<ChatScreenRed> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<ChatModel> _messages = [];

  final bool _showSpinner = false;
  final bool _showVisibleWidget = false;
  final bool _showErrorIcon = false;

  void setStateIfMounted(f) {
    if (mounted) setState(f);
  }

  bool connectionActive = false;

  @override
  Widget build(BuildContext context) {
    if (connectionActive == false) {
      InheritedSocket.of(context).socket.on('eMessage', (message) {
        print("message received");
        print(message);
        Map<String, dynamic> convertedMessage =
            Map<String, dynamic>.from(message);
        setState(() {
          _messages.add(ChatModel(
              id: convertedMessage['username'],
              username: convertedMessage['username'],
              sentAt: convertedMessage['time'],
              message: convertedMessage['text']));
        });
        setState(() {
          connectionActive = true;
        });
      });
    }
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text('Emergency Chat'),
          backgroundColor: Color.fromARGB(255, 170, 0, 0)),
      body: SafeArea(
        child: Container(
          color: Color.fromARGB(255, 44, 44, 44),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Flexible(
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: ListView.builder(
                    controller: _scrollController,
                    physics: const BouncingScrollPhysics(),
                    reverse: _messages.isEmpty ? false : true,
                    itemCount: 1,
                    shrinkWrap: false,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            top: 10, left: 10, right: 10, bottom: 3),
                        child: Column(
                          mainAxisAlignment: _messages.isEmpty
                              ? MainAxisAlignment.center
                              : MainAxisAlignment.start,
                          children: <Widget>[
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: _messages.map((message) {
                                  return ChatBubble(
                                      username: message.username,
                                      date: message.sentAt,
                                      message: message.message,
                                      isMe: message.id == 'me',
                                      key: const Key("Test"));
                                }).toList()),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.only(
                    bottom: 10, left: 20, right: 10, top: 5),
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: Container(
                        child: TextField(
                          minLines: 1,
                          maxLines: 5,
                          controller: _messageController,
                          textCapitalization: TextCapitalization.sentences,
                          decoration: const InputDecoration.collapsed(
                            hintText: "Type a message",
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 43,
                      width: 42,
                      child: FloatingActionButton(
                        backgroundColor: const Color(0xFF271160),
                        onPressed: () async {
                          if (_messageController.text.trim().isNotEmpty) {
                            String message = _messageController.text.trim();
                            print(message);
                            InheritedSocket.of(context)
                                .socket
                                .emit("eMessage", message);
                            setState(() {
                              _messages.add(ChatModel(
                                  id: 'me',
                                  username: 'me',
                                  sentAt: DateTime.now().toString(),
                                  message: message));
                              _messageController.clear();
                              print(
                                  InheritedSocket.of(context).socket.connected);
                            });
                          }
                        },
                        mini: true,
                        child: Transform.rotate(
                            angle: 5.79449,
                            child: const Icon(Icons.send, size: 20)),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final bool isMe = true;
  final String message;
  final String date;
  final String username;

  ChatBubble({
    required Key key,
    required this.message,
    // required this.isMe = true,
    required this.date,
    required bool isMe,
    required this.username,
  });
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Column(
        mainAxisAlignment: username == "me"
            ? MainAxisAlignment.end
            : username == "System"
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
        crossAxisAlignment: username == "me"
            ? CrossAxisAlignment.end
            : username == "System"
                ? CrossAxisAlignment.center
                : CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            margin: const EdgeInsets.symmetric(vertical: 5.0),
            constraints: BoxConstraints(maxWidth: size.width * .5),
            decoration: BoxDecoration(
              color: username == "me"
                  ? Color.fromARGB(255, 254, 255, 193)
                  : Color.fromARGB(255, 255, 227, 227),
              border: username == "system"
                  ? Border.all(color: Colors.black, width: 8)
                  : Border.all(),
              borderRadius: username == "me"
                  ? const BorderRadius.only(
                      topRight: Radius.circular(11),
                      topLeft: Radius.circular(11),
                      bottomRight: Radius.circular(0),
                      bottomLeft: Radius.circular(11),
                    )
                  : const BorderRadius.only(
                      topRight: Radius.circular(11),
                      topLeft: Radius.circular(11),
                      bottomRight: Radius.circular(11),
                      bottomLeft: Radius.circular(0),
                    ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  username,
                  textAlign: TextAlign.end,
                  softWrap: true,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 211, 38, 15),
                      fontSize: 18,
                      fontStyle: FontStyle.italic),
                ),
                Text(
                  message,
                  textAlign: TextAlign.start,
                  softWrap: true,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 8, 2, 22), fontSize: 30),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 7),
                    child: Text(
                      date,
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                          color: Color(0xFF594097), fontSize: 12),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
