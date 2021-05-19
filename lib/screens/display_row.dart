import 'package:flutter/material.dart';

import '../manager/padding.dart';

class DialogRow extends StatelessWidget {
  final Function? callback;
  final String textLeft;
  final String textRight;

  const DialogRow({
    this.callback,
    required this.textLeft,
    required this.textRight,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final btnTextStyle = theme.textTheme.headline5;

    return Padding(
      padding: PaddingManager.minWidthPad(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            onPressed: callback as void Function()? ?? () {},
            child: Text(textRight),
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
            style: theme.textTheme.headline5,
          ),
        ],
      ),
    );
  }
}
