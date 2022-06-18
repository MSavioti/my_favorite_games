import 'package:flutter/material.dart';

class SearchTextField extends StatefulWidget {
  final String? initialValue;

  const SearchTextField({
    Key? key,
    this.initialValue,
  }) : super(key: key);

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.text = widget.initialValue ?? '';
  }

  @override
  Widget build(BuildContext context) {
    void _search(String searchTerm) {
      Navigator.of(context).pushReplacementNamed(
        '/search',
        arguments: searchTerm,
      );
    }

    return TextField(
      controller: controller,
      cursorColor: Colors.white70,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.zero),
          borderSide: BorderSide(color: Colors.grey[900]!),
        ),
        fillColor: Colors.grey[800],
        filled: true,
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.zero),
          borderSide: BorderSide(color: Colors.white70),
        ),
        prefixIcon: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.0),
          child: Icon(
            Icons.search,
            size: 19.0,
            color: Colors.white70,
          ),
        ),
      ),
      style: const TextStyle(color: Colors.white70),
      onSubmitted: _search,
    );
  }
}
