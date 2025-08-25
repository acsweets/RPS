import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(RPSApp());
}

class RPSApp extends StatelessWidget {
  const RPSApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '石头剪子布',
      home: RPSGame(),
    );
  }
}

class RPSGame extends StatefulWidget {
  const RPSGame({super.key});

  @override
  createState() => _RPSGameState();
}

class _RPSGameState extends State<RPSGame> {
  final List<String> choices = ['rock', 'paper', 'scissors'];
  String? computerChoice;
  late String? currentRollingImage = choices[0];
  Timer? animationTimer;

  void playGame() {
    // 开始滚动动画
    int index = 0;
    animationTimer?.cancel();
    animationTimer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() {
        currentRollingImage = choices[index % 3];
        index++;
      });
    });

    // 动画持续 1 秒后停止并决定结果
    Future.delayed(Duration(seconds: 1), () {
      animationTimer?.cancel();
      final random = Random();
      computerChoice = choices[random.nextInt(3)];
      setState(() {
        currentRollingImage = null; // 停止动画
      });
    });
  }

  @override
  void dispose() {
    animationTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final displayComputerImage = currentRollingImage ?? computerChoice;
    return SafeArea(
      child: Scaffold(
          body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/$displayComputerImage.jpg'),
            // 你的背景图路径
            fit: BoxFit.cover, // 让图片填满容器，可以换成 contain / fill 等
          ),
        ),
        child: GestureDetector(
          onTap: () => playGame(),
        ),
      )),
    );
  }
}
