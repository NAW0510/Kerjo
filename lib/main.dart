import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MessagingScreen());
  }
}

class MessagingScreen extends StatefulWidget {
  @override
  _MessagingScreenState createState() => _MessagingScreenState();
}

class _MessagingScreenState extends State<MessagingScreen> {
  // List to hold messages
  List<Map<String, String>> messages = [
    {
      'sender': 'You',
      'text': 'Describe the strategy for the business, the basic steps.',
      'time': '14:21 PM',
    },
    {
      'sender': 'Asisten Kerjo',
      'text':
          'Okay, one minute. Determine the goals and objectives of the business...',
      'time': '14:24 PM',
    },
  ];

  // Controller for the input field
  TextEditingController messageController = TextEditingController();

  // Function to handle sending a new message
  void sendMessage() {
    if (messageController.text.isNotEmpty) {
      setState(() {
        // Add new message to the list
        messages.add({
          'sender': 'You',
          'text': messageController.text,
          'time':
              '14:25 PM', // You can change this to use current time if you like
        });
      });

      // Clear the input field after sending the message
      messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Marketing"), backgroundColor: Colors.blue),
      body: Column(
        children: [
          // Display list of messages
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return _buildMessage(
                  message['sender']!,
                  message['text']!,
                  time: message['time']!,
                  isUser: message['sender'] == 'You',
                );
              },
            ),
          ),
          // Input field for sending a message
          _buildInputField(),
        ],
      ),
    );
  }

  Widget _buildMessage(
    String sender,
    String text, {
    bool isUser = false,
    String time = '',
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: isUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start, // Align the whole Row based on user
        children: [
          if (!isUser) // Show the assistant's avatar on the left
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.grey,
              child: Icon(Icons.headset_mic, color: Colors.white),
            ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: isUser
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Text(sender, style: TextStyle(fontWeight: FontWeight.bold)),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isUser ? Colors.blue[100] : Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(text),
                ),
                if (time.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text(
                      time,
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ),
              ],
            ),
          ),
          if (isUser) // Show the user's avatar on the right
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.blue,
              child: Icon(Icons.person, color: Colors.white),
            ),
        ],
      ),
    );
  }

  Widget _buildInputField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: messageController,
              decoration: InputDecoration(
                hintText: "Ask anything...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.blue),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: sendMessage, // Send message when tapped
          ),
        ],
      ),
    );
  }
}
