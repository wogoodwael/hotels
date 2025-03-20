import 'package:flights/gen/assets.gen.dart';
import 'package:flights/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
    required this.pagesButton,
    required this.icons,
    required this.categories,
  });

  final List<Widget> pagesButton;
  final List<IconData> icons;
  final List<String> categories;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          Assets.images.cover,
          width: double.infinity,
          height: 200,
          fit: BoxFit.cover,
        ),
        Container(
          height: .4 * height(context),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black.withOpacity(0.6),
                Colors.transparent,
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ),
        Positioned(
          top: 100,
          left: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Explore the world today'.tr,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Discover where to travel next!'.tr,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 170,
          left: 20,
          right: 20,
          child: TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              suffixIcon: const Icon(Icons.search),
              hintText: 'Search destination'.tr,
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
          ),
        ),
        Positioned(
            bottom: 20,
            child: Row(
              children: List.generate(
                  3,
                  (index) => GestureDetector(
                        onTap: () {
                          Get.to(() => pagesButton[index]);
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          width: 100,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 5,
                            children: [
                              Icon(
                                icons[index],
                                color: Colors.red,
                                size: 20,
                              ),
                              Text(
                                categories[index],
                                style: const TextStyle(color: Colors.black),
                              )
                            ],
                          ),
                        ),
                      )),
            ))
      ],
    );
  }
}
