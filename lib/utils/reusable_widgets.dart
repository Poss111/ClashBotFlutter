import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DisplayTextLarge extends StatelessWidget {
  const DisplayTextLarge({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Text(message, style: Theme.of(context).textTheme.displayLarge);
  }
}

class DisplayTextMedium extends StatelessWidget {
  const DisplayTextMedium({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Text(message, style: Theme.of(context).textTheme.displayMedium);
  }
}


class DisplayTextSmall extends StatelessWidget {
  const DisplayTextSmall({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Text(message, style: Theme.of(context).textTheme.displaySmall);
  }
}

class HeadlineTextLarge extends StatelessWidget {
  const HeadlineTextLarge({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Text(message, style: Theme.of(context).textTheme.headlineLarge);
  }
}

class HeadlineTextMedium extends StatelessWidget {
  const HeadlineTextMedium({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Text(message, style: Theme.of(context).textTheme.headlineMedium);
  }
}


class HeadlineTextSmall extends StatelessWidget {
  const HeadlineTextSmall({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Text(message, style: Theme.of(context).textTheme.headlineSmall);
  }
}

class TitleTextLarge extends StatelessWidget {
  const TitleTextLarge({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Text(message, style: Theme.of(context).textTheme.titleLarge);
  }
}

class TitleTextMedium extends StatelessWidget {
  const TitleTextMedium({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Text(message, style: Theme.of(context).textTheme.titleMedium);
  }
}

class TitleTextSmall extends StatelessWidget {
  const TitleTextSmall({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Text(message, style: Theme.of(context).textTheme.titleSmall);
  }
}

class LabelTextLarge extends StatelessWidget {
  const LabelTextLarge({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Text(message, style: Theme.of(context).textTheme.labelLarge);
  }
}

class LabelTextMedium extends StatelessWidget {
  const LabelTextMedium({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Text(message, style: Theme.of(context).textTheme.labelMedium);
  }
}


class LabelTextSmall extends StatelessWidget {
  const LabelTextSmall({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Text(message, style: Theme.of(context).textTheme.labelSmall);
  }
}

class BodyTextLarge extends StatelessWidget {
  const BodyTextLarge({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Text(message, style: Theme.of(context).textTheme.bodyLarge);
  }
}

class BodyTextMedium extends StatelessWidget {
  const BodyTextMedium({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Text(message, style: Theme.of(context).textTheme.bodyMedium);
  }
}

class BodyTextSmall extends StatelessWidget {
  const BodyTextSmall({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Text(message, style: Theme.of(context).textTheme.bodySmall);
  }
}


