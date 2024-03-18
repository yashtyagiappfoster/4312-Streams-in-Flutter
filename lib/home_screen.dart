import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  StreamController<String> streamController = StreamController<String>();
  late Stream<String> dataStream;
  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    dataStream = streamController.stream.asBroadcastStream();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Streams'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder<String>(
              stream: dataStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    snapshot.data ?? 'Null Data Recieved',
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.w500),
                  );
                } else if (snapshot.hasError) {
                  throw Exception('Something went wrong');
                } else {
                  return const Text(
                    'No Data Recieved',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                  );
                }
              },
            ),
            StreamBuilder<String>(
              stream: dataStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    snapshot.data ?? 'Null Data Recieved',
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.w500),
                  );
                } else if (snapshot.hasError) {
                  throw Exception('Something went wrong');
                } else {
                  return const Text(
                    'No Data Recieved',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                  );
                }
              },
            ),
            const SizedBox(
              height: 25,
            ),
            SizedBox(
              width: 200,
              child: TextField(
                controller: textController,
                decoration: const InputDecoration(
                  hintText: 'Enter the Data',
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            ElevatedButton(
              onPressed: () {
                streamController.add(textController.text.toString());
              },
              child: const Text('Done'),
            ),
          ],
        ),
      ),
    );
  }
}
