import 'package:flutter/material.dart';

import 'cricket.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SeriesListScreen(),
    );
  }
}

class SeriesListScreen extends StatefulWidget {
  @override
  _SeriesListScreenState createState() => _SeriesListScreenState();
}

class _SeriesListScreenState extends State<SeriesListScreen> {
  final CricketApiService apiService = CricketApiService();
  Future<Map<String, dynamic>>? seriesList;

  @override
  void initState() {
    super.initState();
    seriesList = apiService.fetchSeriesList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cricket Series List')),
      body: FutureBuilder<Map<String, dynamic>>(
        future: seriesList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData ||
              snapshot.data == null ||
              !snapshot.data!.containsKey('seriesMapProto') ||
              snapshot.data!['seriesMapProto'] == null) {
            return Center(child: Text('No data available'));
          } else {
            final data = snapshot.data!;
            final seriesMapProto = data['seriesMapProto'] as List<dynamic>;
            return ListView.builder(
              itemCount: seriesMapProto.length,
              itemBuilder: (context, index) {
                final seriesDateEntry = seriesMapProto[index];
                final seriesList = seriesDateEntry['series'] as List<dynamic>;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: seriesList.map((series) {
                    final seriesName = series['name'] ?? 'Unknown Series';
                    final seriesId = series['id']?.toString() ?? 'Unknown ID';
                    return ListTile(
                      title: Text(seriesName),
                      subtitle: Text('ID: $seriesId'),
                    );
                  }).toList(),
                );
              },
            );
          }
        },
      ),
    );
  }
}
