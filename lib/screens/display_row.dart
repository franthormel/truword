import 'package:flutter/material.dart';

import '../theme.dart';

class DialogRow extends StatelessWidget {
  final String textLeft;
  final String textRight;
  final Function? callback;

  const DialogRow({
    required this.textLeft,
    required this.textRight,
    this.callback,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final btnTextStyle = theme.textTheme.headline4;

    return Padding(
      padding: PaddingManager.minWidthPad(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            onPressed: callback as void Function()? ?? () {},
            child: Text(
              textRight,
            ),
            style: ButtonStyle(
              textStyle: MaterialStateProperty.all<TextStyle>(btnTextStyle!),
              foregroundColor:
                  MaterialStateProperty.all<Color>(theme.accentColor),
              backgroundColor:
                  MaterialStateProperty.all<Color>(theme.primaryColor),
            ),
          ),
          Text(
            textLeft,
            style: theme.textTheme.headline4!.copyWith(
              color: theme.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
