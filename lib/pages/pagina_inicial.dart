import 'package:flutter/material.dart';
import 'package:simulatech/pages/ausculta_abdominal.dart';

import '../pages/ausculta_cardiaca.dart';
import '../pages/ausculta_pulmonar.dart';
import '../pages/ausculta_simultanea.dart';

class PaginaInicial extends StatelessWidget {
  const PaginaInicial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(23, 118, 88, 1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo da aplicação
            Image.asset(
              'assets/app/logo.png',
              width: 250,
              height: 250,
            ),
            const SizedBox(height: 20),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 40.0,
              children: [
                // Botão para a página de ausculta pulmonar
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AuscultaPulmonar(),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(5.0),
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child:
                                Image.asset('assets/ausc-pulmonar/pulmao.png'),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            'Ausculta Pulmonar',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Espaçamento entre widgets
                    const SizedBox(width: 50.0),
                    // Botão para a página de ausculta cardíaca
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AuscultaCardiaca(),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(5.0),
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child:
                                Image.asset('assets/ausc-cardiaca/coracao.png'),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            'Ausculta Cardíaca',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // Espaçamento entre linha de widgets
                const SizedBox(height: 15.0),
                // Botão para a página de ausculta simultânea
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AuscultaSimultanea(),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(5.0),
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Stack(
                              children: [
                                Image.asset(
                                  'assets/ausc-pulmonar/pulmao.png',
                                  width: 60,
                                  height: 60,
                                ),
                                Positioned(
                                  bottom: 1,
                                  right: -5,
                                  child: Image.asset(
                                    'assets/ausc-cardiaca/coracao.png',
                                    width: 60,
                                    height: 60,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            'Ausculta Simultânea',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Espaçamento entre widgets
                    const SizedBox(width: 50.0),
                    // Botão para a página de outros sons
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AuscultaAbdominal(),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10.0),
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Image.asset(
                              'assets/ausc-abdominal/abdomen.png',
                              width: 60,
                              height: 60,
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            'Ausculta Abdominal',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
