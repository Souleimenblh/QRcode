import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class QrCodeGeneratorScreen extends StatefulWidget {
  final Map<String, String>? initialValues;

  QrCodeGeneratorScreen({this.initialValues});

  @override
  _QrCodeGeneratorScreenState createState() => _QrCodeGeneratorScreenState();
}

class _QrCodeGeneratorScreenState extends State<QrCodeGeneratorScreen> {
  final List<Map<String, String>> _fields = [
    {'key': '', 'value': ''}
  ];

  @override
  void initState() {
    super.initState();
    if (widget.initialValues != null) {
      widget.initialValues!.forEach((key, value) {
        _fields.add({'key': key, 'value': value});
      });
    }
  }

  void _addField() {
    setState(() {
      _fields.add({'key': '', 'value': ''});
    });
  }

  void _generateQrCode() {
    Map<String, String> data = {};
    for (var field in _fields) {
      if (field['key']!.isNotEmpty && field['value']!.isNotEmpty) {
        data[field['key']!] = field['value']!;
      }
    }

    String tlvData = encodeTLV(data);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.green[50],
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PrettyQr(
              data: tlvData,
              size: 200,
              errorCorrectLevel: QrErrorCorrectLevel.Q,
              elementColor: Colors.green,
              roundEdges: true,
            ),
            SizedBox(height: 20),
            Text(
              'Your QR Code',
              style: TextStyle(
                color: Colors.green[800],
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Generate QR Code'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _fields.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(labelText: 'Key'),
                          onChanged: (value) {
                            _fields[index]['key'] = value;
                          },
                          controller: TextEditingController(
                            text: _fields[index]['key'],
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(labelText: 'Value'),
                          onChanged: (value) {
                            _fields[index]['value'] = value;
                          },
                          controller: TextEditingController(
                            text: _fields[index]['value'],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: _generateQrCode,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text('Generate QR Code'),
            ),
            ElevatedButton(
              onPressed: _addField,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text('Add Field'),
            ),
          ],
        ),
      ),
    );
  }
}

String encodeTLV(Map<String, String> data) {
  StringBuffer tlv = StringBuffer();

  data.forEach((key, value) {
    String keyType = 'LB';
    String valueType = 'VL';
    int keyLength = key.length;
    int valueLength = value.length;

    tlv.write('$keyType$keyLength$key$valueType$valueLength$value');
  });

  return tlv.toString();
}
