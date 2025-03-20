import 'package:dashed_line/dashed_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

//*need to refactor this
class TripSegment extends StatelessWidget {
  final String time,
      location,
      terminal,
      duration,
      flight,
      type,
      info,
      carrierLogo,
      carrierCode;
  final bool isCircle;
  final double height;

  const TripSegment({
    super.key,
    required this.time,
    required this.location,
    required this.terminal,
    required this.duration,
    required this.flight,
    required this.type,
    required this.info,
    required this.isCircle,
    required this.carrierLogo,
    required this.carrierCode,
    required this.height,
  });

  Widget _buildDotDivider({Color? color}) {
    return SizedBox(
      height: height,
      width: 20,
      child: DashedLine(
        path: Path()
          ..moveTo(0, 0)
          ..lineTo(0, height),
        color: color ?? Colors.grey.withOpacity(0.5),
        dashLength: 2,
        width: 2,
        dashSpace: 4,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: 10,
            children: [
              SizedBox(
                  width: .15 * MediaQuery.sizeOf(context).width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat('h:mm \n a')
                            .format(DateFormat.jm().parse(time)),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                    ],
                  )),
              const SizedBox(
                height: 5,
              ),
              Text(
                DateFormat('dd MMM').format(DateTime.tryParse(
                        Hive.box('flightData').get('departureDate') ?? "") ??
                    DateTime.now()),
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(
                height: 10,
              ),
              isCircle
                  ? SizedBox(
                      width: .14 * MediaQuery.sizeOf(context).width,
                      child: Text(duration,
                          style: const TextStyle(
                              color: Colors.grey, fontSize: 13)),
                    )
                  : Container(
                      width: 45,
                      height: 30,
                      decoration:
                          BoxDecoration(color: Colors.teal.withOpacity(.1)),
                      child: Center(
                        child: Text(duration,
                            style: const TextStyle(
                                color: Colors.green, fontSize: 11)),
                      ),
                    ),
            ]),
        _buildDotDivider(color: Colors.teal.withOpacity(0.5)),
        Column(
          spacing: 10,
          children: [
            Text(location),
            const SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(terminal),
                Text(
                  info,
                  style: const TextStyle(color: Colors.grey, fontSize: 13),
                )
              ],
            ),
            const SizedBox(
              height: 2,
            ),
            isCircle
                ? Row(
                    spacing: 10,
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage(carrierLogo),
                      ),
                      isCircle
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  carrierCode,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "First".tr,
                                  style: const TextStyle(color: Colors.grey),
                                )
                              ],
                            )
                          : const SizedBox()
                    ],
                  )
                : Container(
                    width: 215,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.teal.withOpacity(.1),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "waiting time between flights in ".tr,
                            style: const TextStyle(fontSize: 12),
                          ),
                          const Text(
                            "DOH , Doha",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                  ),
            isCircle ? const SizedBox(width: 10) : const SizedBox(),
          
          ],
        ),
      ],
    );
  }
}
