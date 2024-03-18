import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen2 extends StatefulWidget {
  const HomeScreen2({super.key});

  @override
  State<HomeScreen2> createState() => _HomeScreen2State();
}

class _HomeScreen2State extends State<HomeScreen2> {
  final textController = TextEditingController();
  StreamSocket streamSocket = StreamSocket();
  List<String> list = [];
  // Stream<int> generateNumber() async* {
  //   while (true) {
  //     await Future.delayed(const Duration(seconds: 1));
  //     yield DateTime.now().second;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Stream'),
        centerTitle: true,
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // StreamBuilder(
            //   stream: generateNumber(),
            //   builder: ((context, snapshot) {
            //     return Text(snapshot.data.toString());
            //   }),
            // ),
            StreamBuilder(
              stream: streamSocket.getResponse,
              initialData: const [
                'No Message',
              ],
              builder: (context, AsyncSnapshot<List<String>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error : ${snapshot.hasError}'),
                  );
                } else if (snapshot.connectionState == ConnectionState.active ||
                    snapshot.connectionState == ConnectionState.done) {
                  return Expanded(
                      child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Text(snapshot.data![index].toString());
                    },
                  ));
                } else {
                  return const Center(
                    child: Text('Something went wrong'),
                  );
                }
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textController,
                    decoration: const InputDecoration(
                      hintText: 'Enter the message',
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                IconButton(
                  onPressed: () {
                    list.add(textController.text.toString());
                    streamSocket.addResponse(list);
                    textController.clear();
                  },
                  icon: const Icon(Icons.send),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class StreamSocket {
  final _streamController = StreamController<List<String>>();

  void Function(List<String>) get addResponse => _streamController.sink.add;

  Stream<List<String>> get getResponse =>
      _streamController.stream.asBroadcastStream();
}
