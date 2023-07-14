import 'package:easy_puzzle_game/src/dashatar/bloc/dashatar_puzzle_bloc.dart';
import 'package:easy_puzzle_game/src/dashatar/layout/responsive_gap.dart';
import 'package:easy_puzzle_game/src/dashatar/layout/responsive_layout_builder.dart';
import 'package:easy_puzzle_game/src/dashatar/puzzle/bloc/puzzle_bloc.dart';
import 'package:easy_puzzle_game/src/dashatar/widgets/colors.dart';
import 'package:easy_puzzle_game/src/dashatar/widgets/dashatar_timer.dart';
import 'package:easy_puzzle_game/src/dashatar/widgets/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../timer/timer.dart';

/// {@template dashatar_start_section}
/// Displays the start section of the puzzle based on [state].
/// {@endtemplate}
class MyDashatarStartSection extends StatefulWidget {
  /// {@macro dashatar_start_section}
  MyDashatarStartSection({Key? key, required this.state}) : super(key: key);

  /// The state of the puzzle.
  final MyPuzzleState state;

  @override
  State<MyDashatarStartSection> createState() => _MyDashatarStartSectionState();
}

class _MyDashatarStartSectionState extends State<MyDashatarStartSection> {
  bool started = false;
  @override
  Widget build(BuildContext context) {
    // Reset the timer and the countdown.
    if (!started) {
      context.read<MyTimerBloc>().add(const MyTimerReset());
      started = true;
      context.read<MyDashatarPuzzleBloc>().add(
            const MyDashatarCountdownReset(
              secondsToBegin: 3,
            ),
          );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ResponsiveGap(
          small: 10,
          medium: 10,
          large: 10,
        ),
        Text(
          'Solve the puzzle in least amount of time to win the contest.',
          style: headingText(size: 25, color: AppColors.textGrey),
        ),
        const ResponsiveGap(
          small: 18,
          medium: 16,
          large: 32,
        ),
        const ResponsiveGap(
          small: 8,
          medium: 18,
          large: 32,
        ),
        ResponsiveLayoutBuilder(
          small: (_, __) => const MyDashatarTimer(),
          medium: (_, __) => const MyDashatarTimer(),
          large: (_, __) => const SizedBox(),
        ),
        const ResponsiveGap(small: 12),
      ],
    );
  }
}
