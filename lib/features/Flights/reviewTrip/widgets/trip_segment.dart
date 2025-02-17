import 'package:flutter/material.dart';
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
  });

  Widget _buildDotDivider({double height = 60, Color? color}) {
    return SizedBox(
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          10,
          (_) => Container(
            width: 2,
            height: 2,
            decoration: BoxDecoration(
              color: color ?? Colors.grey.withOpacity(0.5),
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            Padding(
              padding: const EdgeInsets.only(left: 11),
              child: Column(
                children: [
                  const Icon(
                    Icons.circle,
                    color: Colors.teal,
                    size: 10,
                  ),
                  _buildDotDivider(
                      height: 50, color: Colors.teal.withOpacity(0.5))
                ],
              ),
            ),
            const SizedBox(width: 10),
            Text(location),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat('dd MMM').format(DateTime.tryParse(
                      Hive.box('flightData').get('departureDate') ?? "") ??
                  DateTime.now()),
              style: const TextStyle(color: Colors.grey),
            ),
            SizedBox(
              width: .067 * MediaQuery.sizeOf(context).width,
            ),
            _buildDotDivider(height: 60, color: Colors.teal.withOpacity(0.5)),
            SizedBox(
              width: .07 * MediaQuery.sizeOf(context).width,
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
            )
          ],
        ),
        Row(
          children: [
            isCircle
                ? SizedBox(
                    width: .14 * MediaQuery.sizeOf(context).width,
                    child: Text(duration,
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 13)),
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
            SizedBox(
              width: isCircle ? .05 * MediaQuery.sizeOf(context).width : 6,
            ),
            _buildDotDivider(height: 60, color: Colors.teal.withOpacity(0.5)),
            const SizedBox(
              width: 15,
            ),
            isCircle
                ? CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(carrierLogo),
                  )
                : Container(
                    width: 215,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.teal.withOpacity(.1),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "waiting time between flights in ",
                            style: TextStyle(fontSize: 12),
                          ),
                          Text(
                            "DOH , Doha",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                  ),
            isCircle ? const SizedBox(width: 10) : const SizedBox(),
            isCircle
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        carrierCode,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const Text(
                        "First",
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  )
                : const SizedBox()
          ],
        ),
      ],
    );
  }
}
