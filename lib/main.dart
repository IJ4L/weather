import 'package:flutter/material.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final Color _selectedColor = Colors.blue;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    if (_counter == 0) {
      return;
    }

    setState(() {
      _counter--;
    });
  }

  void _resetCounter() {
    if (_counter > 0) {
      debugPrint("Kita berhasil mereset $_counter menjadi 0");
      setState(() {
        _counter = 0;
      });
    } else {
      debugPrint("Kita tidak mereset karena keadaan masih kosong");
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SegmentedButton(
              segments: const [
                ButtonSegment<Color>(
                  value: Colors.blue,
                  label: Text('Red'),
                  enabled: true,
                ),
                ButtonSegment<Color>(
                  value: Colors.green,
                  label: Text('Green'),
                ),
              ],
              selected: <Color>{_selectedColor},
            ),
            Badge(
              child: OutlinedButton(
                onPressed: () => {},
                child: const Text('Button'),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () => _incrementCounter(),
                  child: const Text('Tambah'),
                ),
                Text(
                  '$_counter',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                ElevatedButton(
                  onPressed: () => _decrementCounter(),
                  child: const Text('Kurang'),
                ),
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            TextButton(
              onPressed: () => _resetCounter(),
              style: TextButton.styleFrom(
                backgroundColor:
                    ThemeData.from(colorScheme: Theme.of(context).colorScheme)
                        .colorScheme
                        .primary,
              ),
              child: const Text(
                'Reset',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
