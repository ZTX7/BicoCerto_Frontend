import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage>{
  int count = 0;
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage'),
        backgroundColor: const Color.fromARGB(255, 12, 118, 189)
        
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/img/macaco.png'), // caminho da imagem
              fit: BoxFit.cover, // preenche toda a área
            ),
          ) 
        )
      );
  }
}