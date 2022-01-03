import 'package:flutter/material.dart';
import 'package:flutter_nj_app/module/sample_data.dart';
import 'package:flutter_nj_app/screens/video_player_screen.dart';

class ListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TCE'),
      ),
      body: ListView.builder(
        itemCount: sampleList.length,
        itemBuilder: (context, index) {
          SampleData list = sampleList[index];
          return Card(
            child: ListTile(
              title: Text(list.title),
              subtitle: Text(list.description),
              trailing: Icon(Icons.arrow_forward_rounded),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VideoPlayerScreen()));
              },
            ),
          );
        },
      ),
    );
  }
}
