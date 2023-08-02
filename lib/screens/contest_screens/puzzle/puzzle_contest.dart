import 'package:easy_puzzle_game/easy_puzzle_game.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talentogram/controllers/contest_controller/game_contest.dart';
import 'package:talentogram/globals/app_views.dart';
import 'package:talentogram/models/contest_model.dart';

class PuzzleGame extends StatefulWidget {
  const PuzzleGame({super.key, required this.contestModel});

  final ContestModel contestModel;

  @override
  State<PuzzleGame> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<PuzzleGame> {
  var controller = Get.put(GameContestController());

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      controller.check(widget.contestModel);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          EasyPuzzleGameApp(
            title: 'Puzzle Contest',
            onCompletePuzzle: () {
              controller.addResponse(widget.contestModel.contestId);
            },
            puzzleFullImg:
                'https://res.cloudinary.com/dog87xrmc/profiles/${widget.contestModel.contestId}.png',
            puzzleBlockFolderPath:
                'https://res.cloudinary.com/dog87xrmc/profiles/${widget.contestModel.contestId}_',
            puzzleRowColumn: 4,
          ),
          GetBuilder<GameContestController>(builder: (controller) {
            return AppViews.loadingScreen(controller.isLoading, opacity: 1);
          }),
          GetBuilder<GameContestController>(builder: (controller) {
            return AppViews.showGif(controller.participated, 'api',
                text: 'Your response was submitted successfully');
          })
        ],
      ),
    );
  }
}
