import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: const HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  // O controller depende de ações externas
  // e as açoes externas se assemelham a um player de audio/video

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    _animationController.addListener(listener);
  }

  void listener() {
    // se não tiver esse setState ele não atualiza
    setState(() {});
    // print('Value: ${_animationController.value}');
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.removeListener(listener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Animation Controller')),
      body: Column(
        children: [
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  _animationController.forward();
                },
                child: Text('Forward'),
              ),
              ElevatedButton(
                onPressed: () {
                  _animationController.reverse();
                },
                child: Text('Reverse'),
              ),
              ElevatedButton(
                onPressed: () {
                  _animationController.stop();
                },
                child: Text('Stop'),
              ),
              ElevatedButton(
                onPressed: () {
                  _animationController.repeat(reverse: true);
                },
                child: Text('Repeat'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            'Value: ${_animationController.value.toStringAsFixed(1)}',
            style: TextStyle(fontSize: 24),
          ),
        ],
      ),
    );
  }
}
