import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talentogram/models/contest_model.dart';
import 'package:talentogram/utils/app_colors.dart';
import 'package:talentogram/utils/text_styles.dart';

import '../../controllers/contest_controller/contest_Manager_controller.dart';

class CountdownBuilder extends StatefulWidget {
  final DateTime start;
  final DateTime now;
  final ContestModel contest;
  const CountdownBuilder(
      {required this.start, required this.now, required this.contest});
  @override
  _CountdownBuilderState createState() => _CountdownBuilderState();
}

class _CountdownBuilderState extends State<CountdownBuilder> {
  late CountdownTimer countdownTimer = CountdownTimer(
      startTime: widget.start, // Replace with your start time
      nowTime: widget.now);

  final controller = Get.find<ContestManagerController>();

  @override
  void initState() {
    super.initState();
    countdownTimer.start();
    countdownTimer.remainingTimeStream.listen((remainingTime) {
      if (remainingTime > 0) {
      } else {
        countdownTimer.stop();
        controller.calculateTime(widget.contest);
        print('Countdown finished!');
      }
    });
  }

  @override
  void dispose() {
    countdownTimer.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: countdownTimer.remainingTimeStream,
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        if (snapshot.hasData) {
          int seconds = snapshot.data!;
          int days = (seconds / (24 * 3600)).floor();
          seconds = seconds % (24 * 3600);
          int hours = (seconds / 3600).floor();
          seconds = seconds % 3600;
          int minutes = (seconds / 60).floor();
          int remainingSeconds = seconds % 60;
          return Row(
            children: [
              timeContainer(days, 'Days'),
              timeContainer(hours, 'Hours'),
              timeContainer(minutes, 'Minutes'),
              timeContainer(remainingSeconds, 'Seconds'),
            ],
          );
        } else {
          return Row(
            children: [
              timeContainer(0, 'Days'),
              timeContainer(0, 'Hours'),
              timeContainer(0, 'Minutes'),
              timeContainer(0, 'Seconds'),
            ],
          );
        }
      },
    );
  }

  Expanded timeContainer(int number, String text) {
    return Expanded(
      child: Align(
        alignment: Alignment.center,
        child: Container(
          height: 60,
          width: 57,
          decoration: BoxDecoration(
              color: AppColors.lightPurple,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(3),
              boxShadow: [
                BoxShadow(
                  color: Colors.purple.withOpacity(0.15),
                  offset: const Offset(0, 4),
                  blurRadius: 3,
                ),
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                number.toString().padLeft(2, '0'),
                style: regularText(size: 24, color: Colors.black),
              ),
              Text(
                text,
                style: regularText(size: 11, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CountdownTimer {
  DateTime startTime;
  DateTime nowTime;
  StreamController<int>? _streamController;
  Stream<int>? _remainingTimeStream;
  Timer? _timer;

  CountdownTimer({required this.startTime, required this.nowTime});
  Stream<int> get remainingTimeStream {
    if (_streamController == null) {
      _streamController = StreamController<int>();
      _remainingTimeStream = _streamController!.stream.asBroadcastStream();
    }
    return _remainingTimeStream!;
  }

  void start() {
    Duration difference = startTime.difference(nowTime);
    int initialRemainingTime =
        difference.inSeconds > 0 ? difference.inSeconds : 0;

    _streamController?.sink.add(initialRemainingTime);

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      nowTime = nowTime.add(Duration(seconds: 1));
      Duration remainingTime = startTime.difference(nowTime);
      int remainingSeconds =
          remainingTime.inSeconds > 0 ? remainingTime.inSeconds : 0;
      _streamController?.sink.add(remainingSeconds);
    });
  }

  void stop() {
    _timer?.cancel();
    _streamController?.close();
    _streamController = null;
    _remainingTimeStream = null;
  }
}
