//*     [IMPORT]
import 'package:flutter/material.dart';
//*     [LIB]
import 'package:admin/constants.dart';
import 'package:admin/responsive.dart';

class ToolsScreen extends StatelessWidget {
  const ToolsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      Text("Tools"),
                    ],
                  ),
                ),
                if (!Responsive.isMobile(context))
                  SizedBox(width: defaultPadding),
                // On Mobile means if the screen is less than 850 we dont want to show it
                if (!Responsive.isMobile(context))
                  Expanded(
                    flex: 2,
                    child: Text("Sup"),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
