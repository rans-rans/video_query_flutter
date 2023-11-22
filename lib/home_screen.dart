import 'package:flutter/material.dart';
import 'package:video_player/main.dart';
import 'package:video_player/video_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String formatTime(int milliseconds) {
    Duration duration = Duration(milliseconds: milliseconds);
    String hours = duration.inHours.toString().padLeft(2, "0");
    String minutes = (duration.inMinutes % 60).toString().padLeft(2, "0");
    String seconds = (duration.inSeconds % 60).toString().padLeft(2, "0");

    return ('$hours:$minutes:$seconds');
  }

  Future<List> getData() async {
    methodChannel.invokeMethod("initialize_permissions");
    final files = await methodChannel.invokeMethod("query_videos") as List;
    return files;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Player'),
        actions: [
          IconButton(
            icon: const Icon(Icons.replay),
            onPressed: () {
              setState(() {});
            },
          )
        ],
      ),
      body: FutureBuilder<List>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final data = snapshot.data ?? [];
          final videoItems = data.map((e) => VideoItem.fromMap(e)).toList();

          return ListView.builder(
            itemCount: videoItems.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  videoItems[index].name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "path: ${videoItems[index].path}",
                  maxLines: 20,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: Text(formatTime(videoItems[index].duration)),
              );
            },
          );
        },
      ),
    );
  }
}
