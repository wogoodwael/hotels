import 'package:flights/features/Hotels/home/domain/slider_controller.dart';
import 'package:flights/features/Hotels/home/home_offers_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class HorizontalList extends StatelessWidget {
  HorizontalList({super.key});
  final sliderController = Get.find<SliderController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        height: 210,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => HorizontalListItem(index: index),
          separatorBuilder: (context, index) => const SizedBox(width: 16),
          itemCount: sliderController.sliders.value?.data?.length ?? 0,
        ),
      ),
    );
  }
}

class HorizontalListItem extends StatelessWidget {
  final int index;
  final sliderController = Get.find<SliderController>();

   HorizontalListItem({super.key, required this.index});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => HomeOffersDetails(
            img: sliderController.sliders.value?.data?[index].imageUrl ?? "",
            title: sliderController.sliders.value?.data?[index].title ?? "",
            description:
                sliderController.sliders.value?.data?[index].content ?? ""));
      },
      child: Container(
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.network(
                    sliderController.sliders.value?.data?[index].imageUrl ?? "",
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: const BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    child: const Icon(
                      Icons.favorite_border,
                      size: 20,
                      color: Colors.black,
                    ),
                  ),
                )
              ]),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        sliderController.sliders.value?.data?[index].title ??
                            "",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        )),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        ...List.generate(
                            5,
                            (index) => const Icon(
                                  Icons.star,
                                  color: Colors.orange,
                                  size: 16,
                                )),
                        const SizedBox(width: 4),
                        const Text(
                          '100 reviews',
                          style: TextStyle(fontSize: 12, color: Colors.black),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                        sliderController.sliders.value?.data?[index].content ??
                            "",
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
