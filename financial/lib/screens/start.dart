import 'package:financial/utils/app_routes.dart';
import 'package:flutter/material.dart';

class Start extends StatelessWidget {
  const Start({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'lib/assets/imgs/splash.png'), // Caminho da imagem
                fit: BoxFit.cover, // Faz a imagem preencher o espaço
              ),
            ),
          ),
          Center(
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                Image.asset('lib/assets/imgs/financial.png'),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Rapido & Seguro',
                  style: TextStyle(
                      color: Color.fromARGB(255, 2, 19, 119), fontSize: 30),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 300,
                  child: Text(
                    'a maniera mais rapida e facil de anotar seus gastos',
                    style: TextStyle(color: Colors.blueAccent, fontSize: 17),
                    textAlign: TextAlign.center,
                  ),
                ),
                Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(300, 50),
                    backgroundColor: const Color.fromARGB(255, 2, 19, 119),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () =>
                      Navigator.of(context).pushNamed(AppRoutes.HOME),
                  child: const Text('Iniciar',
                      style: TextStyle(color: Colors.white)),
                ),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
