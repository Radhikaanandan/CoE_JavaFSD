import 'package:flutter/material.dart';
import 'quotes_service.dart';

class QuotesScreen extends StatefulWidget {
  @override
  _QuotesScreenState createState() => _QuotesScreenState();
}

class _QuotesScreenState extends State<QuotesScreen> {
  String _quote = "Loading...";

  @override
  void initState() {
    super.initState();
    _getQuote();
  }

  Future<void> _getQuote() async {
    try {
      String quote = await QuotesService().fetchQuote();
      setState(() {
        _quote = quote;
      });
    } catch (e) {
      setState(() {
        _quote = "Failed to fetch quote!";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Motivational Quotes")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_quote, 
                  textAlign: TextAlign.center, 
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _getQuote,
                child: Text("Get New Quote"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
