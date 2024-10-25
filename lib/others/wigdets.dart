import 'package:flutter/material.dart';
import 'package:task/others/extensions.dart';

Widget productContainer(
  BuildContext context, {
  required String title,
  required String image,
  required String price,
  required String views,
  required String colors,
}) {
  return Container(
    color: Colors.black38,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 202, 198, 198),
            border: Border.all(color: Colors.black12),
          ),
          height: 0.2.sh(context),
          width: 0.35.sw(context),
          child: Image.network(image),
        ),
        SizedBox(width: 0.04.sw(context)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 0.02.sh(context),
            ),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 0.018.toRes(context),
              ),
            ),
            Text(
              colors,
              style: TextStyle(
                fontSize: 0.014.toRes(context),
              ),
            ),
            Row(
              children: [
                Text(
                  "Price:",
                  style: TextStyle(
                    fontSize: 0.014.toRes(context),
                  ),
                ),
                SizedBox(width: 0.04.sw(context)),
                Text(
                  "NRs. $price",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 0.014.toRes(context),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 0.02.sh(context),
            ),
            Row(
              children: [
                Icon(
                  Icons.visibility,
                  color: Colors.black38,
                  size: 0.018.toRes(context),
                ),
                SizedBox(width: 0.02.sw(context)),
                Text(
                  views,
                  style: TextStyle(
                    fontSize: 0.016.toRes(context),
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}
