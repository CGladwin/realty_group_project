import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TempPage extends StatefulWidget {
  @override
  _TempPageState createState() => _TempPageState();
}

class _TempPageState extends State<TempPage> {
  List<String> searches = [];

  @override
  void initState() {
    super.initState();
    _loadSearchHistory();
  }

  Future<void> _loadSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      searches = prefs.getStringList('searchHistory') ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        title: const Text("Previous Searches"),
      ),
      body: searches.isEmpty
          ? const Center(child: Text("No searches yet."))
          : ListView.builder(
              itemCount: searches.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.history),
                  title: Text(searches[index]),
                );
              },
            ),
    );
  }
}