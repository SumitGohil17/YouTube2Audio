import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Youtube 2 Audio',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AudioDownloader(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AudioDownloader extends StatefulWidget {
  @override
  _AudioDownloaderState createState() => _AudioDownloaderState();
}

class _AudioDownloaderState extends State<AudioDownloader> {
  final TextEditingController _controller = TextEditingController();
  String _buttonText = "Download Audio";

  Future<String?> fetchAudioUrl(String videoUrl) async {
    final apiUrl =
        'http://ENTER_YOUR_IPV4_LOCAL_MACHINE_ADDRESS:5000/api/data?URL=$videoUrl'; //Enter the Ipv4 address of your Computer and the mobile also connect with same router.
    try {
      final response = await http.get(
        Uri.parse(apiUrl),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('API Response: $data');
        print(data['result']['dlink']);
        return data['result']['dlink'];
      } else {
        print('Failed to fetch audio URL: ${response.statusCode}');
        print('Response body: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error fetching audio URL: $e');
      return null;
    }
  }

  Future<void> downloadAudio(String audioUrl) async {
    try {
      final dio = Dio();
      final directory = await getExternalStorageDirectory();
      final uuid = Uuid();
      final filePath = '${directory!.path}/audio_${uuid.v4()}.mp3';

      setState(() {
        _buttonText = "Downloading.....";
      });

      print('Downloading audio from: $audioUrl');
      await dio.download(audioUrl, filePath);
      print('Audio downloaded to $filePath');

      Fluttertoast.showToast(
        msg: 'downloaded to $filePath',
        toastLength: Toast.LENGTH_LONG,
        timeInSecForIosWeb: 4,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Color(0xF5EFFF),
        textColor: Colors.black,
        fontSize: 16.0,
      );

      setState(() {
        _buttonText = "Download Complete";
      });
    } catch (e) {
      print('Error downloading audio: $e');
      setState(() {
        _buttonText = "Failed To Download";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Youtube 2 Audio')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              onChanged: (text) {
                if (text.isEmpty) {
                  setState(() {
                    _buttonText = "Download Audio";
                  });
                }
              },
              decoration: InputDecoration(
                labelText: 'Enter YouTube Video URL',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  _buttonText = "Wait a Second";
                });
                final videoUrl = _controller.text;
                if (videoUrl.isNotEmpty) {
                  final audioUrl = await fetchAudioUrl(videoUrl);
                  if (audioUrl != null) {
                    print('Download URL: $audioUrl');
                    await downloadAudio(audioUrl);
                  } else {
                    print('Failed to get audio URL');
                    setState(() {
                      _buttonText = 'Download Failed';
                    });
                  }
                } else {
                  print('Please enter a valid URL');
                }
              },
              child: Text(_buttonText),
            ),
          ],
        ),
      ),
    );
  }
}
