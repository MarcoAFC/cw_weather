import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {

  final TextEditingController controller = TextEditingController();
  final Function(String) onSubmitted;
  SearchField({super.key, required this.onSubmitted});

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