import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final imagesurl = [
    'https://images.unsplash.com/photo-1515310787031-25ac2d68610d?ixid=MnwxMjA3fDB8MHx0b3BpYy1mZWVkfDN8Ym84alFLVGFFMFl8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1000&q=60',
    'https://images.unsplash.com/photo-1518811829466-1372392d4544?ixid=MnwxMjA3fDB8MHx0b3BpYy1mZWVkfDF8Ym84alFLVGFFMFl8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1000&q=60',
    'https://images.unsplash.com/photo-1578763918454-d0deb5469071?ixid=MnwxMjA3fDB8MHx0b3BpYy1mZWVkfDV8Ym84alFLVGFFMFl8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1000&q=60',
    'https://images.unsplash.com/photo-1512188066-4f19f566a388?ixid=MnwxMjA3fDB8MHx0b3BpYy1mZWVkfDd8Ym84alFLVGFFMFl8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1000&q=60',
    'https://images.unsplash.com/photo-1578763918454-d0deb5469071?ixid=MnwxMjA3fDB8MHx0b3BpYy1mZWVkfDV8Ym84alFLVGFFMFl8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1000&q=60',
  ];
  int activeIndex = 0;
  final controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CarouselSlider.builder(
                  carouselController: controller,
                  itemCount: imagesurl.length,
                  itemBuilder: (context, index, realIndex) {
                    final imageUrl = imagesurl[index];
                    return imageBuild(imageUrl, index);
                  },
                  options: CarouselOptions(
                      height: 400,
                      // autoPlay: true,
                      enlargeStrategy: CenterPageEnlargeStrategy.height,
                      enlargeCenterPage: true,
                      onPageChanged: (index, reason) {
                        setState(() {
                          activeIndex = index;
                        });
                      }),
                ),
                const SizedBox(height: 30),
                buildIndicator(),
                const SizedBox(height: 30),
                buildButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget imageBuild(String imageUrl, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      color: Colors.grey,
      child: Image.network(imageUrl, fit: BoxFit.cover),
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: imagesurl.length,
        onDotClicked: animatToSlide,
        effect: WormEffect(
          activeDotColor: Colors.redAccent,
          dotColor: Colors.pink.shade100,
        ),
      );

  Widget buildButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.pink.shade100,
          ),
          child: IconButton(
              iconSize: 25,
              color: Colors.red,
              padding: const EdgeInsets.only(right: 4),
              onPressed: prev,
              icon: const Icon(Icons.arrow_back_ios_new_rounded)),
        ),
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.pink.shade100,
          ),
          child: IconButton(
              padding: const EdgeInsets.only(left: 4),
              iconSize: 25,
              color: Colors.red,
              onPressed: next,
              icon: const Icon(Icons.arrow_forward_ios_rounded)),
        ),
      ],
    );
  }

  void next() =>
      controller.nextPage(duration: const Duration(milliseconds: 300));

  void prev() =>
      controller.previousPage(duration: const Duration(milliseconds: 300));

  animatToSlide(int index) {
    return controller.animateToPage(index);
  }
}
