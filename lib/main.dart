import 'package:flutter/material.dart';

void main() => runApp(const JogoDaVelhaApp());

class JogoDaVelhaApp extends StatelessWidget {
  const JogoDaVelhaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jogo da Velha',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const JogoDaVelha(),
    );
  }
}

class JogoDaVelha extends StatefulWidget {
  const JogoDaVelha({Key? key}) : super(key: key);

  @override
  _JogoDaVelhaState createState() => _JogoDaVelhaState();
}

class _JogoDaVelhaState extends State<JogoDaVelha> {
  // Variáveis para o jogo
  List<String> board = List.generate(9, (_) => '');
  String currentPlayer = 'X';
  bool gameOver = false;
  String message = '';

  // Função para alternar jogadores
  void playMove(int index) {
    if (board[index] == '' && !gameOver) {
      setState(() {
        board[index] = currentPlayer;
        if (checkWinner()) {
          message = '$currentPlayer Venceu!';
          gameOver = true;
        } else if (!board.contains('')) {
          message = 'Empate!';
          gameOver = true;
        } else {
          currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
        }
      });
    }
  }

  // Função para verificar vencedor
  bool checkWinner() {
    final winningCombinations = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6]
    ];
    
    for (var combination in winningCombinations) {
      final a = combination[0];
      final b = combination[1];
      final c = combination[2];
      if (board[a] == board[b] && board[b] == board[c] && board[a] != '') {
        return true;
      }
    }
    return false;
  }

  // Função para reiniciar o jogo
  void resetGame() {
    setState(() {
      board = List.generate(9, (_) => '');
      currentPlayer = 'X';
      gameOver = false;
      message = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jogo da Velha'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Mensagem do vencedor ou empate
            Text(
              message,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            
            // Tabuleiro
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // 3 colunas
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 1.0,
              ),
              itemCount: 9,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => playMove(index),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black),
                    ),
                    child: Center(
                      child: Text(
                        board[index],
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            
            // Botão para reiniciar o jogo
            ElevatedButton(
              onPressed: resetGame,
              child: const Text('Reiniciar Jogo'),
            ),
          ],
        ),
      ),
    );
  }
}
