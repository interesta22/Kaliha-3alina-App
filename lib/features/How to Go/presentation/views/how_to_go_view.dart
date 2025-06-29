import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HowToGoView extends StatefulWidget {
  @override
  _MwasalatChatState createState() => _MwasalatChatState();
}

class _MwasalatChatState extends State<HowToGoView> {
  final TextEditingController _controller = TextEditingController();
  String response = '';

  Future<void> askQuestion(String question) async {
    final url = Uri.parse('http://<YOUR_IP>:5000/ask'); // غير <YOUR_IP>

    try {
      final res = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"question": question}),
      );

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        setState(() {
          response = data['answer'];
        });
      } else {
        setState(() {
          response = "حصل خطأ من السيرفر.";
        });
      }
    } catch (e) {
      setState(() {
        response = "مش قادر أوصل للسيرفر. تأكد إن السيرفر شغال.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('مواصلات مصر')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'اسأل منين لفين'),
            ),
            ElevatedButton(
              onPressed: () {
                askQuestion(_controller.text);
              },
              child: Text('اسأل'),
            ),
            SizedBox(height: 20),
            Text(
              response,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
