import 'package:flutter/material.dart';

class SearchFieldWidget extends StatelessWidget {

  final TextEditingController controller = TextEditingController();
  final Function(String) onSubmitted;
  SearchFieldWidget({super.key, required this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    return  TextField(
          controller: controller,
          style: const TextStyle(color: Colors.white),
          cursorColor: Colors.white,
          decoration: const InputDecoration(
            hintText: 'Search',
            hintStyle: TextStyle(color: Colors.white)
          ),
          onChanged: onSubmitted,
        );
  }
}