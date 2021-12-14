import 'package:flutter/material.dart';

import '../manager/padding.dart';
import '../manager/size.dart';
import '../models/enums.dart';
import 'dialog_option.dart';

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

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
    final size = MediaQuery.of(context).size;

    final padding = PaddingManager.home(size);
    final sizeHome = SizeManager.home(size);
    final sizeLogo = SizeManager.logo(size);

    final styleText = theme.textTheme.headline5;

    return Scaffold(
      backgroundColor: theme.colorScheme.secondary,
      body: Padding(
        padding: padding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Flexible(
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
                child: const Text("START"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
