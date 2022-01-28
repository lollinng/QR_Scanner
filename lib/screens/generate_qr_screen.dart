import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GenerateScreen extends StatefulWidget {
  @override
  _GenerateScreenState createState() => _GenerateScreenState();
}

class _GenerateScreenState extends State<GenerateScreen> {
  static const double _topSectionTopPadding = 50;
  static const double _topSectionBotPadding = 20;
  static const double _topSectionHeight = 50;

  GlobalKey globalKey = GlobalKey();
  String _dataString = 'Hello from this QR';
  String? _inputErrorText; // this indicateds variable can have null values
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QR Code Generator"),
      ),
      body: _contentWidget(),
    );
  }

  _contentWidget() {
    final bodyHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).viewInsets.bottom;
    return Container(
      color: const Color(0xFFFFFFFF),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
                top: _topSectionTopPadding,
                left: 20,
                right: 10,
                bottom: _topSectionBotPadding),
            child: Container(
              height: _topSectionTopPadding,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        hintText: "Enter a custom message",
                        errorText: _inputErrorText,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: FlatButton(
                      child: const Text("Submit"),
                      onPressed: () {
                        setState(() {
                          _dataString = _textController.text;
                          _inputErrorText = null;
                        });
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
              child: Center(
            child: RepaintBoundary(
              key: globalKey,
              child: QrImage(
                data: _dataString,
                size: 0.6 * bodyHeight,
                embeddedImage: AssetImage('assets/images/coys.jpg'),
                embeddedImageStyle: QrEmbeddedImageStyle(
                  size: const Size(80, 80),
                ),
                // if an error is encountered
                errorStateBuilder: (ctx, err) {
                  return const Center(
                    child: Text(
                      "Uh oh ! Somthing went wrong.. ",
                      textAlign: TextAlign.center,
                    ),
                  );
                },
              ),
            ),
          ))
        ],
      ),
    );
  }
}
