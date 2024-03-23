import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyPostTile extends StatelessWidget {
  final String title;
  final String subTitle;
  final String timestamp;

  const MyPostTile({
    super.key,
    required this.title,
    required this.subTitle,
    required this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: 75,
            maxHeight: 200,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListTile(
                  title: Text(
                    title,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                        fontSize: 15),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    subTitle,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Text(
              //     timestamp,
              //     style: TextStyle(
              //       color: Theme.of(context).colorScheme.inversePrimary,
              //       fontSize: 12, // Adjust the font size as needed
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
