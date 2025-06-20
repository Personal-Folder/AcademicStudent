import 'package:flutter/material.dart';

import '../../../../core/models/about_us.dart';

class AboutUsWidget extends StatelessWidget {
  final AboutUsInfo aboutUs;
  const AboutUsWidget({
    super.key,
    required this.aboutUs,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(aboutUs.title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface)),
          Text(
            aboutUs.body,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: Theme.of(context).colorScheme.primary),
          )
        ],
      ),
    );
  }
}
