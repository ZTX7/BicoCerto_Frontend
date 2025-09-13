// lib/pages/home_page.dart

import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../main.dart'; // Importa a classe AuthWrapper.

// Widget para a página inicial, que só é acessível quando logado.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // Função que faz o logout e navega para a tela de autenticação.
  void _handleLogout(BuildContext context) async {
    final authService = AuthService();
    await authService.logout(); // Chama o método de logout da API.

    // Navega para a tela de login e remove todas as telas anteriores da pilha.
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const AuthWrapper()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Página Inicial"),
        actions: [
          // Botão de logout no canto superior direito.
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _handleLogout(context),
            tooltip: 'Sair',
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Qual serviço procura?!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Encontre profissionais em sua localidade',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 40),
            // Imagem do asset.
            Image.asset(
              'assets/images/bico_certo.jpg', 
              height: 200,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                // Lógica para o próximo passo
              },
              child: const Text('Próximo'),
            ),
          ],
        ),
      ),
    );
  }
}