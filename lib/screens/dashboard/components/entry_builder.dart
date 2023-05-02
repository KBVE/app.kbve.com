import 'package:admin/constants.dart';
import 'package:flutter/material.dart';
import 'package:admin/models/Entry.dart';
import 'package:http/http.dart' as http;

//! BUILDER

class EntryBuilder extends StatefulWidget {
  //final Asset? asset;
  final String assetClass;
  final String assetName;

  EntryBuilder({Key? key, required this.assetClass, required this.assetName})
      : super(key: key);

  @override
  _EntryBuilder createState() => _EntryBuilder();
}

class _EntryBuilder extends State<EntryBuilder> {
  Future? _future;
  Future<String?> loadList() async => await fetchEntry(
        http.Client(),
        widget.assetClass.toString(),
        widget.assetName.toString(),
      );
  Size get screenSize => MediaQuery.of(context).size;

  @override
  void initState() {
    _future = loadList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: _future,
        builder: (ctx, AsyncSnapshot snapshot) {
          // Checking if future is resolved or not
          // If we got an error
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Errors: ' + '${snapshot.error} occurred',
                style: TextStyle(fontSize: 18),
              ),
            );

            // if we got our data
          } else if (snapshot.hasData) {
            final data = snapshot.data;
            final title = data;

            return Container(
              padding: EdgeInsets.all(defaultPadding),
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://kbve.com/assets/img/letter_logo.png'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(width: 2, color: secondaryColor)),
              // Start Container

              child: Center(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(height: defaultPadding),
                      SizedBox(height: defaultPadding),
                      Container(
                        padding: EdgeInsets.all(defaultPadding * 0.75),
                        decoration: BoxDecoration(
                          color: secondaryColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      SizedBox(height: defaultPadding),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                              child: Container(
                            padding: EdgeInsets.all(defaultPadding * 0.75),
                            decoration: BoxDecoration(
                              color: secondaryColor,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                            ),
                            child: new Text(title),
                          )),
                        ],
                      ),
                      SizedBox(height: defaultPadding * 2),
                      //  Container(
                      //     child: WebViewXPage(),
                      //   )
                    ]),
              ),

              // End Container
            );
          } else {
            // Displaying LoadingSpinner to indicate waiting state
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
