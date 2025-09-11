Anotações sobre Dart/Flutter.

DART

1.	Instalação.





Flutter







# CÓDIGO


 Dart é uma linguagem orientada a objetos, muito bem semelhante a JAVA POO apenas se diferenciando em alguns fundamentos.

Acredito que pelo fato de haver em sua construção uma função "main(){}" que chama a execução global das outras classes, me 
fez acender a semelhança com a linguagem C.

Antes de tudo, a aplicação precisa ter um tema ao qual importamos:

~~~dart
import "package:flutter/material.dart;
~~~

Em seguida, chamamos a função main para a execução global:

~~~dart
main () {
    runApp(AppWidget());
}
~~~

Na construção da estrutura de flutter com classes, se segue o modelo de hierarquia, onde os widgets se acoplam uma nas outras, como uma boneca russa, proporcionando a herança de caracteristicas. 


~~~dart
return Container(
      child: Center(
        child: GestureDetector(
            child: Text("testando: $count", 
            style: TextStyle(fontSize: 30, color: Colors.red),
            ),
          onTap: () {
            setState(() {
              count++;
              TextStyle(color: Colors.amber);
            });
          },
        ),
      ),
    );
~~~

Um **"Container"** vazio contém um método **"Center"** que centraliza seu conteúdo, perceba que a construção e sempre um dentro do outro em forma de argumentos, a exemplo, o **"child"** cria um widget, e junto com ele há outros parametros de edição, como o **"style"** que chama o **"TextStyle"** como parâmetro de estilização de texto.

 Para os Widgets do flutter, existem 2 tipos de comportamento do objeto, são eles:

* **StatelessWidget:** Reserva os widgets que não sofrerão alteração de estado, são estáticos.
* **StatefulWidget:** Ao contrário do anterior, estes serão dinâmicos, reserva os widgets que sofrerão mudança de estado.

> ***Mas, como assim mudança de estado?***
> Digamos assim, uma folha de rosto que ficará no fundo de todas as páginas da aplicação, isso é estático, ou seja, não terá mudanças neste elemento. Agora, em contra partida, quando precisa navegar entre as páginas, fazer uma ação com o clique de um botão, precisa que o aplicativo mude seus parâmetros, neste caso a há mudança de estado.

#### Agora, qual a primeira coisa que devo fazer?



