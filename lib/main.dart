import 'package:flutter/material.dart';
import 'package:spotify_player_clone/song.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Best of Hindi',
          ),
        ),
        body: SpotifyPlayer(),
      )
  ));
}

class SpotifyPlayer extends StatefulWidget {
  @override
  _SpotifyPlayerState createState() => _SpotifyPlayerState();
}

class _SpotifyPlayerState extends State<SpotifyPlayer> {

  Song dummySong = Song(
      'Duniyaa',
      'https://p.scdn.co/mp3-preview/4efd033217aa13f4625d37f95efa676fb02d4778?cid=774b29d4f13844c495f206cafdad9c86',
      'https://i.scdn.co/image/f218335b215402cc2fb3b8d92652ebad48458805',
      'Luka Chuppi');
  List<Song> allSongs = SongData().songs;// You are given a list of songs here for Stretch
  IconData buttonState = Icons.play_circle_filled;
  AudioPlayer audioPlayer = AudioPlayer();
  int i = 0;
  playPrev(){
    setState(() {
      if(i!=0){
        i--;
        if(buttonState != Icons.play_circle_filled){
          audioPlayer.play(allSongs[i].playUrl);
        }
      }
    });
  }
  playNext(){
    setState(() {
      if(i!=allSongs.length){
        i++;
        if(buttonState != Icons.play_circle_filled){
          audioPlayer.play(allSongs[i].playUrl);
        }
      }
    });
  }

  changeButton() {
    setState(() {
      if (buttonState == Icons.play_circle_filled) {
        audioPlayer.play(allSongs[i].playUrl);
        buttonState = Icons.pause_circle_filled;
      } else if (buttonState == Icons.pause_circle_filled) {
        audioPlayer.pause();
        buttonState = Icons.play_circle_filled;
      }

      return buttonState;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Image.network(
              '${allSongs[i].imageUrl}',
            ),
            SizedBox(height: 20),
            Text('${allSongs[i].name}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black,
                )),
            Text('${allSongs[i].artistName}',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 10,
                  color: Colors.black,
                )),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                    onPressed: () {}, iconSize: 36, icon: Icon(Icons.thumb_up)),
                IconButton(
                    onPressed: playPrev,
                    color: Colors.black,
                    iconSize: 36,
                    icon: Icon(Icons.skip_previous)),
                IconButton(
                  iconSize: 64,
                  icon: Icon(buttonState),
                  onPressed: changeButton,
                ),
                IconButton(
                    onPressed: playNext,
                    iconSize: 36,
                    icon: Icon(Icons.skip_next)),
                IconButton(
                    onPressed: () {},
                    iconSize: 36,
                    icon: Icon(Icons.thumb_down)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
