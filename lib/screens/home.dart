import 'package:flutter/material.dart';

import '../constants/enums.dart';
import '../theme.dart';
import 'dialog_option.dart';

const _kImgHeightFactor = .17;

const _kBtnWidthFactor = .71;
const _kBtnHeightFactor = .08;

class Homepage extends StatelessWidget {
  final assetImg = "assets/images/logo_light.png";

  ///Returns [List] of time limit options
  List<Widget> timeOptions(BuildContext context) {
    final options = <Widget>[];

    for (TimeLimit timeLimit in TimeLimit.values) {
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
    final btnTextStyle = theme.textTheme.headline4;
    final btnWidth = size.width * _kBtnWidthFactor;
    final btnHeight = size.height * _kBtnHeightFactor;
    final imgHeight = size.height * _kImgHeightFactor;

    return Scaffold(
      backgroundColor: theme.accentColor,
      body: Padding(
        padding: PaddingManager.home(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Divider(
              color: Colors.transparent,
            ),
            Column(
              children: [
                Image.asset(
                  assetImg,
                  width: size.width,
                  height: imgHeight,
                ),
                Text(
                  "Truword",
                  style: theme.textTheme.headline3,
                ),
              ],
            ),
            ElevatedButton(
              style: ButtonStyle(
                textStyle: MaterialStateProperty.all<TextStyle>(btnTextStyle!),
                minimumSize: MaterialStateProperty.all<Size>(
                  Size(btnWidth, btnHeight),
                ),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (context) {
                    return SimpleDialog(
                      title: Text(
                        "Select Timer",
                        textAlign: TextAlign.center,
                        style: btnTextStyle.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      children: timeOptions(context),
                    );
                  },
                );
              },
              child: Text("START"),
            ),
          ],
        ),
      ),
    );
  }
}
