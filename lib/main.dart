// lib/main.dart

import 'package:flutter/material.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'services/auth_service.dart';
import 'pages/home_page.dart';
// importações de uni_links removidas

void main() {
  runApp(const MyApp());
}

// Widget principal do aplicativo, responsável por definir o tema.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App de Autenticação',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AuthChecker(), // O ponto de entrada que verifica o status de login.
    );
  }
}

// Widget que verifica o status de autenticação no início do app.
class AuthChecker extends StatefulWidget {
  const AuthChecker({super.key});

  @override
  State<AuthChecker> createState() => _AuthCheckerState();
}

class _AuthCheckerState extends State<AuthChecker> {
  final AuthService _authService = AuthService();
  bool _isLoggedIn = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  // Função que checa o status de login e atualiza a tela.
  void _checkAuthStatus() async {
    bool status = await _authService.getAuthStatus();
    if (mounted) {
      setState(() {
        _isLoading = false;
        _isLoggedIn = status;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // Se estiver logado, mostra a HomePage. Caso contrário, mostra a tela de login.
    if (_isLoggedIn) {
      return const HomePage();
    } else {
      return const AuthWrapper();
    }
  }
}

// Widget que gerencia a transição entre as páginas de Login e Cadastro.
class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  bool _isRegistering = false;

  void _togglePage() {
    setState(() {
      _isRegistering = !_isRegistering;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gradiente de fundo.
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 173, 221, 237),
                  Color.fromARGB(255, 239, 248, 252),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // Onda na parte inferior da tela.
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ClipPath(
              clipper: BottomWaveClipper(),
              child: Container(
                color: const Color.fromARGB(255, 25, 116, 172),
                height: 200,
              ),
            ),
          ),
          // Exibe a página de Login ou Cadastro, com base na variável de estado.
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32.0),
              child: _isRegistering
                  ? RegisterPage(onLoginPressed: _togglePage)
                  : LoginPage(onRegisterPressed: _togglePage),
            ),
          ),
        ],
      ),
    );
  }
}

// Clipper personalizado para criar a forma de onda.
class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height * 0.75);
    var firstControlPoint = Offset(size.width * 0.25, size.height);
    var firstEndPoint = Offset(size.width * 0.5, size.height * 0.75);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);
    var secondControlPoint = Offset(size.width * 0.75, size.height * 0.5);
    var secondEndPoint = Offset(size.width, size.height * 0.75);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}