import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tu_agenda_ya/core/utils/colors_style.dart';
import 'package:tu_agenda_ya/core/utils/text_style.dart';
import 'package:tu_agenda_ya/routes/routes_names.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  final List<Widget> _pages = [
    OnbPage(
      title: "Encuentra salones cerca de ti",
      description:
          "Descubre los salones mejor valorados en tu zona con nuestro mapa interactivo.",
      imagePath: "assets/onb-1.png",
    ),
    OnbPage(
      title: "Reserva fácilmente",
      description:
          "Haz tu reserva en cualquier momento y lugar con solo unos clics.",
      imagePath: "assets/onb-2.png",
    ),
    OnbPage(
      title: "Disfruta del servicio",
      description: "Llega a tiempo y disfruta de un servicio personalizado.",
      imagePath: "assets/onb-3.png",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView.builder(
          controller: _controller,
          itemCount: _pages.length,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          itemBuilder: (_, index) => _pages[index],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: MyColors.primaryColor,
              minimumSize: const Size.fromHeight(50),
            ),
            onPressed: () {
              if (_currentIndex == _pages.length - 1) {
                Get.offAllNamed(Routes.login);
              } else {
                _controller.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease);
              }
            },
            child: Text(
              _currentIndex == _pages.length - 1 ? "Comenzar" : "Siguiente",
              style: MyTxtStyle.btnTextBase,
            ),
          ),
        ),
      ),
    );
  }
}

class OnbPage extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;

  const OnbPage({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(imagePath, height: 250),
        const SizedBox(height: 40),
        Text(title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
