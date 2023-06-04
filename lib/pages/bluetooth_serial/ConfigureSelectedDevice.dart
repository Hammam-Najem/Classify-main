import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import '../../user.dart';
import '../../widgets/utils.dart';

class ConfigureSelectedDevice extends StatefulWidget {
  final BluetoothDevice server;

  const ConfigureSelectedDevice({required this.server});

  @override
  _ConfigureSelectedDevice createState() => new _ConfigureSelectedDevice();
}

class _Message {
  int whom;
  String text;

  _Message(this.whom, this.text);
}

class _ConfigureSelectedDevice extends State<ConfigureSelectedDevice> {
  static final clientID = 0;
  BluetoothConnection? connection;

  List<_Message> messages = List<_Message>.empty(growable: true);
  String _messageBuffer = '';
  final ScrollController listScrollController = new ScrollController();

  bool isConnecting = true;
  bool get isConnected => (connection?.isConnected ?? false);

  bool isDisconnecting = false;
  var themeid = 4;

  @override
  void initState() {
    super.initState();

    BluetoothConnection.toAddress(widget.server.address).then((_connection) {
      print('Connected to the device');
      connection = _connection;
      setState(() {
        isConnecting = false;
        isDisconnecting = false;
      });
      _sendStartConfigurationMessage();
      connection!.input!.listen(_onDataReceived).onDone(() {
        // Example: Detect which side closed the connection
        // There should be `isDisconnecting` flag to show are we are (locally)
        // in middle of disconnecting process, should be set before calling
        // `dispose`, `finish` or `close`, which all causes to disconnect.
        // If we except the disconnection, `onDone` should be fired as result.
        // If we didn't except this (no flag set), it means closing by remote.
        if (isDisconnecting) {
          print('Disconnecting locally!');
        } else {
          print('Disconnected remotely!');
        }
        if (this.mounted) {
          setState(() {});
        }
      });
    }).catchError((error) {
      print('Cannot connect, exception occured');
      print(error);
    });
  }

  @override
  void dispose() {
    // Avoid memory leak (`setState` after dispose) and disconnect
    if (isConnected) {
      isDisconnecting = true;
      connection?.dispose();
      connection = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<InkWell> list = messages.map((_message) {
      return InkWell(
        child: ListTile(
          title: Container(
            child: Text(
                _message.text.trim(),
                style: TextStyle(color: Colors.black)
            ),
            padding: EdgeInsets.all(12.0),
            margin: EdgeInsets.all(8.0),
          ),
          trailing: Icon(Icons.wifi),
        ),
        onTap: () async {
          TextEditingController passwordController = TextEditingController();
          showMyInputDialog(context, "كلمة السر", "كلمة سر الواي فاي", passwordController, () async {
              await _sendWIFIPasswordMessage(_message.text.trim(), passwordController.text);
              var nav = Navigator.of(context);
              nav.pop();
              nav.pop();
              nav.pop();
          });
        },
      );
    }).toList();

    final serverName = widget.server.name ?? "Unknown";
    return Scaffold(
      appBar: AppBar(
          backgroundColor: myColors[themeid]![3],
          centerTitle: true,
          title: (isConnecting
              ? Text( '...' + serverName + ' محاولة الإاصال مع ')
              : isConnected
                  ? Text('تم الإتصال مع  ' + serverName)
                  : Text('Chat log with ' + serverName)
          ),
          actions: <Widget>[
            isConnecting
                ? FittedBox(
                  child: Container(
                    margin: new EdgeInsets.all(16.0),
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                )
                : IconButton(
                    icon: Icon(Icons.replay),
                    onPressed: _sendStartConfigurationMessage,
                ),
          ],
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'شبكات الواي فاي المجاورة',
                textScaleFactor: 1.3,
                style: const TextStyle(
                    // fontSize: 20.0,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            Divider(),
            list.length !=0 ?
              Flexible(
                child:  ListView(
                    padding: const EdgeInsets.all(12.0),
                    controller: listScrollController,
                    children: list
                )

              )
            :
              Expanded(
                  child: Center(
                    child: Column(
                      children: [
                        CircularProgressIndicator(),
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Expanded(child: SizedBox()),
                              Text('إضغط على'),
                              Icon(Icons.replay),
                              Text(' للبحث من جديد'),
                              Expanded(child: SizedBox()),
                            ],
                          ),
                        )
                      ],
                    )
                  )
              ),
            Row(
              children: <Widget>[
                Flexible(
                  child: Container(
                    margin: const EdgeInsets.all(16.0),
                    child: Text(
                      isConnecting
                          ? 'بإنتظار الإتصال ...'
                          : isConnected
                          ? 'تم الإتصال'
                          : 'تم فصل البلوتوث',
                      textScaleFactor: 1.0,
                      style: const TextStyle(
                          fontSize: 15.0,
                          color: Colors.grey
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _onDataReceived(Uint8List data) {
    // Allocate buffer for parsed data
    int backspacesCounter = 0;
    data.forEach((byte) {
      if (byte == 8 || byte == 127) {
        backspacesCounter++;
      }
    });
    Uint8List buffer = Uint8List(data.length - backspacesCounter);
    int bufferIndex = buffer.length;

    // Apply backspace control character
    backspacesCounter = 0;
    for (int i = data.length - 1; i >= 0; i--) {
      if (data[i] == 8 || data[i] == 127) {
        backspacesCounter++;
      } else {
        if (backspacesCounter > 0) {
          backspacesCounter--;
        } else {
          buffer[--bufferIndex] = data[i];
        }
      }
    }

    // Create message if there is new line character
    String dataString = String.fromCharCodes(buffer);
    int index = buffer.indexOf(13);
    if (~index != 0) {
      setState(() {
        messages.add(
          _Message(
            1,
            backspacesCounter > 0
                ? _messageBuffer.substring(0, _messageBuffer.length - backspacesCounter)
                : _messageBuffer + dataString.substring(0, index),
          ),
        );
        _messageBuffer = dataString.substring(index);
      });
    } else {
      _messageBuffer = (backspacesCounter > 0
          ? _messageBuffer.substring(0, _messageBuffer.length - backspacesCounter)
          : _messageBuffer + dataString);
    }
  }

  void _sendMessage(String text) async {
    text = text.trim();

    if (text.length > 0) {
      try {
        connection!.output.add(Uint8List.fromList(utf8.encode(text + "\r\n")));
        await connection!.output.allSent;

        setState(() {
          messages.add(_Message(clientID, text));
        });

        Future.delayed(Duration(milliseconds: 333)).then((_) {
          listScrollController.animateTo(
              listScrollController.position.maxScrollExtent,
              duration: Duration(milliseconds: 333),
              curve: Curves.easeOut);
        });
      } catch (e) {
        // Ignore error, but notify state
        setState(() {});
      }
    }
  }

  void _sendStartConfigurationMessage() async {
    debugPrint('_sendStartConfigurationMessage');
    String text = 'connect';
    text = text.trim();

    if (text.length > 0) {
      try {
        setState(() {
          messages.clear();
        });
        connection!.output.add(Uint8List.fromList(utf8.encode(text + "\r\n")));
        await connection!.output.allSent;
      } catch (e) {
        // Ignore error, but notify state
        setState(() {});
      }
    }
  }

  Future<void> _sendWIFIPasswordMessage(String wifiId, String password) async {
    User user = User();
    String text = wifiId.trim() + '&' + password.trim() + '&' + user.phone;

    if (text.length > 0) {
      try {
        connection!.output.add(Uint8List.fromList(utf8.encode(text + "\r\n")));
        await connection!.output.allSent;
      } catch (e) {
        // Ignore error, but notify state
        setState(() {});
      }
    }
  }
}
