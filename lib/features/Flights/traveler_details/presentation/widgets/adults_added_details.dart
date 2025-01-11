import 'package:flutter/material.dart';

import '../../../../../utils/constants/lists.dart';

class AdultAddedDetails extends StatelessWidget {
  const AdultAddedDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (int index) {
        return Column(
          children: [
            SizedBox(
              height: 50,
              width: 400,
              child: ListTile(
                title: Text(titles[index]),
                titleTextStyle:
                    const TextStyle(fontSize: 14, color: Colors.black),
                subtitle:
                    Text(index == 2 ? "choose meal/ special assistance " : ""),
                subtitleTextStyle:
                    const TextStyle(color: Colors.grey, fontSize: 10),
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 15,
                  color: Colors.teal,
                ),
                leading: Icon(
                  icons[index],
                  size: 15,
                ),
              ),
            ),
            index == 0 || index == 1
                ? Divider(
                    height: 1,
                    color: Colors.grey.withOpacity(.2),
                    indent: 10,
                    endIndent: 20,
                  )
                : const SizedBox()
          ],
        );
      }),
    );
  }
}
