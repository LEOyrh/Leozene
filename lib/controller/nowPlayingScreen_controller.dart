import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import '../view/nowPlayingScreen.dart';

class NowPlayingScreenController {
  NowPlayingScreenState state;
  //SearchScreenState state1;
  //ProfileScreenState state2;
  NowPlayingScreenController(this.state);

  void play() async {
    state.onComplete = false;
    state.result = await state.audioPlayer.setUrl(state.songCopy.songURL);
    state.result = await state.audioPlayer.setReleaseMode(ReleaseMode.STOP);
    if (state.result == 1 && state.play == true && state.exitNBack == true) {
      state.result = await state.audioPlayer.stop();
      state.result = await state.audioPlayer.resume();
    } else {
      state.result = await state.audioPlayer.play(state.songCopy.songURL);
    }
    // } else {
    //   state.result = await state.audioPlayer.play(state.songCopy.songURL);
    // }
    // try {
    //   if (state.result != null) {
    //     return;
    //   } else {
    //     state.result = await state.audioPlayer.play(state.songCopy.songURL);
    //   }
    // } catch (e) {
    //   print("There was an issue trying to play the song");
    // }

    state.stateChanged(() {
      state.play = true;
      state.pause = false;
      state.exitNBack = false;
    });
  }

  void pauseSong() async {
    state.result = await state.audioPlayer.pause();

    state.stateChanged(() {
      state.play = false;
      state.pause = true;
    });
  }

  void getDuration() async {
    state.audioPlayer.onDurationChanged.listen((Duration d) {
      //print('Current position: $p');

      state.stateChanged(() {
        state.duration = d;
        if (state.position != null) {
          state.value = state.position.inSeconds / state.duration.inSeconds;
        }
      });
    });
  }

  void getPosition() async {
    state.audioPlayer.onAudioPositionChanged.listen((Duration p) {
      //print('Current position: $p');
      state.stateChanged(() {
        state.position = p;
        // if (state.duration != null) {
        //   state.value = state.position.inSeconds / state.duration.inSeconds;
        // }
      });
    });
  }

  void getCompleted() async {
    state.audioPlayer.onPlayerCompletion.listen((event) {
      //print('Current position: $p');
      state.stateChanged(() {
        state.onComplete = true;
      });
    });
  }
  // void getRemainDur() {
  //   state.stateChanged(() {
  //     state.remainDur = state.duration - state.position;
  //   });
  // }
}
