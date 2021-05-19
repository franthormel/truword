import 'package:flutter/material.dart';

import '../models/enums.dart';
import '../models/game_settings.dart';
import '../models/game_state.dart';
import 'contents.dart';
import 'display_row.dart';

class TimerDialogOption extends StatelessWidget {
  final TimeLimit timeLimit;
  final BuildContext dialogContext;

  TimerDialogOption({
    Key? key,
    required this.dialogContext,
    required this.timeLimit,
  });

  @override
  Widget build(BuildContext context) {
    final settings = GameSettings(
      timeLimit: timeLimit,
    );
    final action = () {
      Navigator.of(dialogContext, rootNavigator: true).pop();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Contents(GameState(settings: settings)),
        ),
      );
    };

    return SimpleDialogOption(
      onPressed: action,
      child: DialogRow(
        callback: action,
        textLeft: settings.timeLimitText(),
        textRight: settings.timeLimitFormat(),
      ),
    );
  }
}
