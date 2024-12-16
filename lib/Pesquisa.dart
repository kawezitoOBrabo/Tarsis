import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ReCycle',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
 
  final List<String> images = [
    'https://a-static.mlcdn.com.br/1500x1500/espelho-redondo-jateado-iluminado-com-led-e-botao-touch-screen-decora-loja/decoraloja/16015992437/3e061a1a126ddd86107fea90df4d44a0.jpeg',
    'https://a-static.mlcdn.com.br/1500x1500/espelho-redondo-jateado-iluminado-com-led-e-botao-touch-screen-decora-loja/decoraloja/16015992437/3e061a1a126ddd86107fea90df4d44a0.jpeg',
    'https://a-static.mlcdn.com.br/1500x1500/espelho-redondo-jateado-iluminado-com-led-e-botao-touch-screen-decora-loja/decoraloja/16015992437/3e061a1a126ddd86107fea90df4d44a0.jpeg',
    'https://a-static.mlcdn.com.br/1500x1500/espelho-redondo-jateado-iluminado-com-led-e-botao-touch-screen-decora-loja/decoraloja/16015992437/3e061a1a126ddd86107fea90df4d44a0.jpeg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 200, 230, 201),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(0, 165, 214, 167),
        elevation: 0,
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Pesquisar...',
            prefixIcon: Icon(Icons.search),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           
            Text('Recomendado', style: TextStyle(fontSize: 18)),
            Text('Recomendado', style: TextStyle(fontSize: 18)),
            Text('Recomendado', style: TextStyle(fontSize: 18)),
            Text('Recomendado', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
           
            Expanded(
              child: ListView.builder(
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () { 
                      print('Imagem ${index + 1} clicada');
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              images[index],
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 150,
                              loadingBuilder: (context, child, progress) {
                                if (progress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: progress.expectedTotalBytes != null
                                        ? progress.cumulativeBytesLoaded /
                                            progress.expectedTotalBytes!
                                        : null,
                                    color: Colors.greenAccent,
                                  ),
                                );
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return Center(
                                  child: Text(
                                    'Erro ao carregar imagem',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                );
                              },
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            left: 10,
                            child: Text(
                              'Novidade!',
                              style: TextStyle(
                                color: Colors.greenAccent,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),


     
 bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.green.shade100,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home, color: const Color.fromARGB(255, 60, 127, 62),), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.add, color: const Color.fromARGB(255, 60, 127, 62),), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.play_circle_rounded, color: const Color.fromARGB(255, 60, 127, 62),), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.message, color: const Color.fromARGB(255, 60, 127, 62),), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle, color: const Color.fromARGB(255, 60, 127, 62),), label: ''),
       
        ],
      ),
    );
  }
}


 

