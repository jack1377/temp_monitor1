import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TemperaturePage extends StatefulWidget {
  @override
  _TemperaturePageState createState() => _TemperaturePageState();
}

class _TemperaturePageState extends State<TemperaturePage> {
  final TextEditingController _tempController = TextEditingController();
  final CollectionReference _temps =
      FirebaseFirestore.instance.collection('temperatures');

  Future<void> _addTemperature() async {
    final tempText = _tempController.text;
    if (tempText.isEmpty) return;
    final tempValue = double.tryParse(tempText);
    if (tempValue == null) return;

    await _temps.add({
      'temperature': tempValue,
      'timestamp': FieldValue.serverTimestamp(),
    });

    _tempController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Temperature Monitor')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _tempController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Enter Temperature',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _addTemperature,
                  child: Text('Add'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _temps.orderBy('timestamp', descending: true).snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
                  final docs = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      final data = docs[index].data() as Map<String, dynamic>;
                      final temp = data['temperature'] ?? 0;
                      final ts = data['timestamp'] != null
                          ? (data['timestamp'] as Timestamp).toDate()
                          : DateTime.now();
                      return ListTile(
                        title: Text('Temperature: $temp °C'),
                        subtitle: Text('Time: $ts'),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
