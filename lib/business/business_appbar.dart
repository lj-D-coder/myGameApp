import 'package:flutter/material.dart';

class BusinessAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget>? widgets;
  const BusinessAppBar({Key? key, this.widgets}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shape: const Border(bottom: BorderSide(color: Colors.grey)),
      leadingWidth: 40,
      title: Row(
        children: [
          const Icon(Icons.sports_soccer),
          const SizedBox(
            width: 10,
          ),
          Text(
            "myGame",
            style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 20),
          )
        ],
      ),
      actions: const [
        SizedBox(
          width: 15,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
