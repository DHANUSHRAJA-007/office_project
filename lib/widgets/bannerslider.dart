import 'package:flutter/material.dart';

class BannerSlider extends StatefulWidget {
  const BannerSlider({super.key});

  @override
  State<BannerSlider> createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  PageController controller = PageController();
  int currentIndex = 0;

  List<Color> colors = [
    Colors.green,
    Colors.orange,
    Colors.blue,
    Colors.purple,
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180, // total height for banner + dots
      child: Column(
        children: [

          /// BANNER
          Expanded(
            child: PageView.builder(
              controller: controller,
              itemCount: colors.length,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    color: colors[index],
                    borderRadius: BorderRadius.circular(15),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 8),

          /// DOT INDICATOR
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(colors.length, (index) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: currentIndex == index ? 10 : 8,
                height: currentIndex == index ? 10 : 8,
                decoration: BoxDecoration(
                  color: currentIndex == index
                      ? Colors.green
                      : Colors.grey,
                  shape: BoxShape.circle,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}