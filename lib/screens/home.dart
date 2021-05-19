import 'package:flutter/material.dart';

import '../manager/padding.dart';
import '../manager/size.dart';
import '../models/enums.dart';
import 'dialog_option.dart';

class Homepage extends StatelessWidget {
  ///Returns [List] of [TimeLimit] as dialog options
  List<Widget> options(BuildContext context) {
    final options = <Widget>[];

    for (final timeLimit in TimeLimit.values) {
      options.add(
        TimerDialogOption(
          dialogContext: context,
          timeLimit: timeLimit,
        ),
      );
    }

    return options;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final padding = PaddingManager.home(context);
    final size = MediaQuery
        .of(context)
        .size;
    final styleText = theme.textTheme.headline5;
    final sizeHome = SizeManager.home(size);
    final sizeLogo = SizeManager.logo(size);

    return Scaffold(
      backgroundColor: theme.accentColor,
      body: Padding(
        padding: padding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: FractionallySizedBox(
                heightFactor: .1,
              ),
            ),
            Flexible(
              child: Column(
                children: <Widget>[
                  Image.asset(
                    "assets/images/logo.png",
                    height: sizeLogo,
                    width: size.width,
                  ),
                  Text(
                    "Truword",
                    style: theme.textTheme.headline3,
                  ),
                ],
              ),
            ),
            Flexible(
              child: ElevatedButton(
                style: ButtonStyle(
                  textStyle: MaterialStateProperty.all<TextStyle>(styleText!),
                  minimumSize: MaterialStateProperty.all<Size>(sizeHome),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (context) {
                      return SimpleDialog(
                        children: options(context),
                        title: Text(
                          "Select Timer",
                          style: styleText.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      );
                    },
                  );
                },
                child: Text("START"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
