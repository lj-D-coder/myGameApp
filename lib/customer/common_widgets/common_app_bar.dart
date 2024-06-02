import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mygame/core/auth/login.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget>? widgets;
  const CommonAppBar({Key? key, this.widgets}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const Padding(
        padding: EdgeInsets.only(left: 15.0),
        child: Icon(Icons.sports_soccer),
      ),
      shape: const Border(bottom: BorderSide(color: Colors.grey)),
      leadingWidth: 40,
      title:
          Text("myGame", style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 20)),
      actions: [
        InkWell(
            onTap: () {
              var box = GetStorage();
              box.remove('UserData').then((value) {
                Get.offAll(() => const Login());
              });
            },
            child: const Icon(Icons.logout)),
        const SizedBox(
          width: 15,
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    return const SearchBar(
      trailing: [
        Icon(
          Icons.search,
          color: Colors.black,
          size: 25,
        )
      ],
      constraints: BoxConstraints(maxHeight: 30, maxWidth: 200, minHeight: 30, minWidth: 200),
    );
  }
}
