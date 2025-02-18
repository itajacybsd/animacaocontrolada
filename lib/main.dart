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

  late final Animation<double> _widthAnimation; //largura do botão

  late final Animation<double> _radiusAnimation;

  late final Animation<double> _textOpacityAnimation;

  late final Animation<double> _loadingOpacityAnimation;

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

    // _widthAnimation = Tween<double>(
    //   begin: 300,
    //   end: 50,
    // ).animate(_animationController);
    _widthAnimation = Tween<double>(begin: 300, end: 50).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.bounceOut,
        reverseCurve: Curves.easeIn,
      ),
    );

    _radiusAnimation = Tween<double>(
      begin: 10,
      end: 25,
    ).animate(_animationController);

    _textOpacityAnimation = Tween<double>(
      begin: 1, //totalmente visível
      end: 0, // fica invisível
    ).animate(_animationController);

    _loadingOpacityAnimation = Tween<double>(
      begin: 0, //começa invisível
      end: 1, //totalmente visível
    ).animate(_animationController);
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
          Container(
            height: 50,
            width: _widthAnimation.value,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(_radiusAnimation.value),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Opacity(
                  //adicionando opacidade ao texto
                  opacity: _textOpacityAnimation.value,
                  child: Text(
                    'ENTRAR',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Opacity(
                  //adicionando opacidade ao loading
                  opacity: _loadingOpacityAnimation.value,
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
