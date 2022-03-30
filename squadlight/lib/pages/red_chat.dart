// import 'package:flutter/material.dart';
// import 'package:socket_io_client/socket_io_client.dart';
// import 'package:squadlight/inheritedSocket.dart';
// import '/models/chat_model.dart';
// import '/socket.dart';
// import 'package:squadlight/inheritedSocket.dart';
//
// class ChatScreenRed extends StatefulWidget {
//   final String username;
//   const ChatScreenRed({
//     required Key key,
//     required this.username,
//   }) : super(key: key);
//
//   @override
//   _ChatScreenRedState createState() => _ChatScreenRedState();
// }
//
// class _ChatScreenRedState extends State<ChatScreenRed> {
//   final TextEditingController _messageController = TextEditingController();
//   final ScrollController _scrollController = ScrollController();
//   final List<ChatModel> _messages = [];
//
//   final bool _showSpinner = false;
//   final bool _showVisibleWidget = false;
//   final bool _showErrorIcon = false;
//
//   void setStateIfMounted(f) {
//     if (mounted) setState(f);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//           centerTitle: true,
//           title: const Text('Emergency Chat Screen'),
//           backgroundColor: Color.fromARGB(255, 234, 49, 43)),
//       body: SafeArea(
//         child: Container(
//           color: const Color(0xFFEAEFF2),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: <Widget>[
//               FloatingActionButton(
//                 backgroundColor: Color.fromARGB(255, 15, 138, 32),
//                 onPressed: () async {
//                   String message = "I've voted to end this problem.";
//                   InheritedSocket.of(context).socket.eMessage(message);
//                   _messageController.clear();
//                 },
//                 mini: true,
//                 child: Transform.rotate(
//                     angle: 5.79449,
//                     child: const Icon(Icons.check_circle, size: 20)),
//               ),
//               Flexible(
//                 child: MediaQuery.removePadding(
//                   context: context,
//                   removeTop: true,
//                   child: ListView.builder(
//                     controller: _scrollController,
//                     physics: const BouncingScrollPhysics(),
//                     reverse: _messages.isEmpty ? false : true,
//                     itemCount: 1,
//                     shrinkWrap: false,
//                     itemBuilder: (BuildContext context, int index) {
//                       return Padding(
//                         padding: const EdgeInsets.only(
//                             top: 10, left: 10, right: 10, bottom: 3),
//                         child: Column(
//                           mainAxisAlignment: _messages.isEmpty
//                               ? MainAxisAlignment.center
//                               : MainAxisAlignment.start,
//                           children: <Widget>[
//                             Column(
//                                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                                 children: _messages.map((message) {
//                                   print(message);
//                                   return ChatBubble(
//                                       date: message.sentAt,
//                                       message: message.message,
//                                       isMe: message.id == socket.id,
//                                       key: Key("Test"));
//                                 }).toList()),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//               Container(
//                 color: Colors.white,
//                 padding: const EdgeInsets.only(
//                     bottom: 10, left: 20, right: 10, top: 5),
//                 child: Row(
//                   children: <Widget>[
//                     Flexible(
//                       child: Container(
//                         child: TextField(
//                           minLines: 1,
//                           maxLines: 5,
//                           controller: _messageController,
//                           textCapitalization: TextCapitalization.sentences,
//                           decoration: const InputDecoration.collapsed(
//                             hintText: "Type a message",
//                             hintStyle: TextStyle(
//                               color: Colors.grey,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 43,
//                       width: 42,
//                       child: FloatingActionButton(
//                         backgroundColor: const Color(0xFF271160),
//                         onPressed: () async {
//                           if (_messageController.text.trim().isNotEmpty) {
//                             String message = _messageController.text.trim();
//                             InheritedSocket.of(context)
//                                 .socket
//                                 .eMessage(message);
//                             _messageController.clear();
//                           }
//                         },
//                         mini: true,
//                         child: Transform.rotate(
//                             angle: 5.79449,
//                             child: const Icon(Icons.send, size: 20)),
//                       ),
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class ChatBubble extends StatelessWidget {
//   final bool isMe = true;
//   final String message;
//   final String date;
//
//   ChatBubble({
//     required Key key,
//     required this.message,
//     // required this.isMe = true,
//     required this.date,
//     required bool isMe,
//   });
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//       child: Column(
//         mainAxisAlignment:
//             isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
//         crossAxisAlignment:
//             isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
//         children: <Widget>[
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//             margin: const EdgeInsets.symmetric(vertical: 5.0),
//             constraints: BoxConstraints(maxWidth: size.width * .5),
//             decoration: BoxDecoration(
//               color: isMe ? const Color(0xFFE3D8FF) : const Color(0xFFFFFFFF),
//               borderRadius: isMe
//                   ? const BorderRadius.only(
//                       topRight: Radius.circular(11),
//                       topLeft: Radius.circular(11),
//                       bottomRight: Radius.circular(0),
//                       bottomLeft: Radius.circular(11),
//                     )
//                   : const BorderRadius.only(
//                       topRight: Radius.circular(11),
//                       topLeft: Radius.circular(11),
//                       bottomRight: Radius.circular(11),
//                       bottomLeft: Radius.circular(0),
//                     ),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 Text(
//                   message,
//                   textAlign: TextAlign.start,
//                   softWrap: true,
//                   style:
//                       const TextStyle(color: Color(0xFF2E1963), fontSize: 14),
//                 ),
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: Padding(
//                     padding: const EdgeInsets.only(top: 7),
//                     child: Text(
//                       date,
//                       textAlign: TextAlign.end,
//                       style: const TextStyle(
//                           color: Color(0xFF594097), fontSize: 9),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
