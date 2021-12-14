import 'package:flutter/material.dart';

import '../manager/padding.dart';

class DialogRow extends StatelessWidget {
  final Function? callback;
  final String textLeft;
  final String textRight;

  const DialogRow({
    Key? key,
    this.callback,
    required this.textLeft,
    required this.textRight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: PaddingManager.minWidthPad(size),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            onPressed: callback as void Function()? ?? () {},
            child: Text(textRight),
            style: ButtonStyle(
              textStyle: MaterialStateProperty.all<TextStyle>(
                  theme.textTheme.headline5!),
              foregroundColor:
                  MaterialStateProperty.all<Color>(theme.colorScheme.secondary),
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
