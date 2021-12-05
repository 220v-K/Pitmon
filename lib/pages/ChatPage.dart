import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:pitmon_test/pages/exercisepage.dart';
import 'package:pitmon_test/pages/heartbeat.dart';
import 'package:pitmon_test/providers/userdata.dart';
import 'package:pitmon_test/util/helper.dart';
import 'package:pitmon_test/util/colors.dart';
import 'package:provider/provider.dart';
import 'package:pitmon_test/providers/userdata.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class ChatPage extends StatefulWidget {
  final BluetoothDevice server;

  const ChatPage({required this.server});

  @override
  _ChatPage createState() => new _ChatPage();
}

class _Message {
  int whom;
  String text;

  _Message(this.whom, this.text);
}

class _ChatPage extends State<ChatPage> {
  static final clientID = 0;
  BluetoothConnection? connection;

  List<_Message> messages = List<_Message>.empty(growable: true);
  String _messageBuffer = '';

  final TextEditingController textEditingController =
      new TextEditingController();
  final ScrollController listScrollController = new ScrollController();

  bool isConnecting = true;
  bool get isConnected => (connection?.isConnected ?? false);

  bool isDisconnecting = false;
  Stopwatch stopwatch = new Stopwatch();

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
    //사이즈 조정용 변수
    final Size size = MediaQuery.of(context).size;
    Size centerButtonSize = Size(size.width * 0.82, 30);
    final List<Row> list = messages.map((_message) {
      return Row(
        children: <Widget>[
          Container(
            child: Text(
                (text) {
                  return text == '/shrug' ? '¯\\_(ツ)_/¯' : text;
                }(_message.text.trim()),
                style: TextStyle(color: Colors.white)),
            padding: EdgeInsets.all(12.0),
            margin: EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
            width: 222.0,
            decoration: BoxDecoration(
                color:
                    _message.whom == clientID ? Colors.blueAccent : Colors.grey,
                borderRadius: BorderRadius.circular(7.0)),
          ),
        ],
        mainAxisAlignment: _message.whom == clientID
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
      );
    }).toList();

    final serverName = widget.server.name ?? "Unknown";
    return Scaffold(
      appBar: AppBar(
          title: (isConnecting
              ? Text('블루투스명 : ' + serverName + '에 연결중입니다...')
              : isConnected
                  ? Text(serverName + '에 연결되어 있음')
                  : Text('Chat log with ' + serverName))),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(
              height: 100,
            ),
            Container(
              child: Center(
                child: TextButton(
                  onPressed: () {
                    stopwatch.start();
                    if (Provider.of<userData>(context, listen: false).flag ==
                        'a') {
                      //운동 시작
                      int age =
                          Provider.of<userData>(context, listen: false).userAge;
                      double weight =
                          Provider.of<userData>(context, listen: false)
                              .userWeight;
                      String ageS = age.toString();
                      String weightS = weight.toString();
                      _sendMessage(ageS);
                      _sendMessage(weightS);
                      _sendMessage(
                          Provider.of<userData>(context, listen: false).flag);
                    } else {
                      //심박수측정 시작
                      _sendMessage(
                          Provider.of<userData>(context, listen: false).flag);
                    }
                  },
                  style: buildDoubleButtonStyle(lightBlue, centerButtonSize),
                  //삼항 연산자로 flag에 따라 뜨는 글자 다르게 처리
                  child: Text(
                    (Provider.of<userData>(context, listen: false).flag == 'a')
                        ? '운동 측정 시작'
                        : '심박수 측정 시작',
                    style: TextStyle(fontSize: 25, color: Colors.black),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 100,
            ),

            Container(
              child: Center(
                child: TextButton(
                  onPressed: () {
                    Provider.of<userData>(context, listen: false)
                        .editTime(stopwatch.elapsedMilliseconds);
                    print(stopwatch.elapsedMilliseconds);
                    stopwatch.stop();
                    if (Provider.of<userData>(context, listen: false).flag ==
                        'a') {
                      _sendMessage('b'); // 운동 끝내면서 이전 화면으로 돌아가고, count 저장.
                      _sendMessage('b');
                      _sendMessage('b');
                      _sendMessage('b');
                      _sendMessage('b');
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => exercisePage()));
                    } else {
                      _sendMessage('d'); // 운동 끝내면서 이전 화면으로 돌아가고, count 저장.
                      _sendMessage('d');
                      _sendMessage('d');
                      _sendMessage('d');
                      _sendMessage('d');

                      Navigator.pop(context);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => heartbeat()));
                    }
                  },
                  style: buildDoubleButtonStyle(lightBlue, centerButtonSize),
                  child: Text(
                    '측정 종료',
                    style: TextStyle(fontSize: 25, color: Colors.black),
                  ),
                ),
              ),
            ),
            Flexible(
              child: ListView(
                  padding: const EdgeInsets.all(12.0),
                  controller: listScrollController,
                  children: list),
            ),
            // Row(
            //   children: <Widget>[
            //     Flexible(
            //       child: Container(
            //         margin: const EdgeInsets.only(left: 16.0),
            //         child: TextField(
            //           style: const TextStyle(fontSize: 15.0),
            //           controller: textEditingController,
            //           decoration: InputDecoration.collapsed(
            //             hintText: isConnecting
            //                 ? 'Wait until connected...'
            //                 : isConnected
            //                     ? 'Type your message...'
            //                     : 'Chat got disconnected',
            //             hintStyle: const TextStyle(color: Colors.grey),
            //           ),
            //           enabled: isConnected,
            //         ),
            //       ),
            //     ),
            //     Container(
            //       margin: const EdgeInsets.all(8.0),
            //       child: IconButton(
            //           icon: const Icon(Icons.send),
            //           onPressed: isConnected
            //               ? () => _sendMessage(textEditingController.text)
            //               : null),
            //     ),
            //   ],
            // )
          ],
        ),
      ),
    );
  }

  void _onDataReceived(Uint8List data) {
    //setState(() {});
    int countData = data[0];
    print(countData);
    Provider.of<userData>(context, listen: false).editCount(countData);
    // double beatdata = data[1] as double;
    // Provider.of<userData>(context, listen: false).editBeat(beatdata);
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
        // messages.add(
        //   _Message(
        //     1,
        //     backspacesCounter > 0
        //         ? _messageBuffer.substring(
        //             0, _messageBuffer.length - backspacesCounter)
        //         : _messageBuffer + dataString.substring(0, index),
        //   ),
        // );
        _messageBuffer = dataString.substring(index);
      });
    } else {
      _messageBuffer = (backspacesCounter > 0
          ? _messageBuffer.substring(
              0, _messageBuffer.length - backspacesCounter)
          : _messageBuffer + dataString);
    }
  }

  void _sendMessage(String text) async {
    text = text.trim();
    textEditingController.clear();

    if (text.length > 0) {
      try {
        connection!.output.add(Uint8List.fromList(utf8.encode(text + "\r\n")));
        await connection!.output.allSent;

        setState(() {
          //messages.add(_Message(clientID, text)); //메시지 안나오게 수정
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
}
