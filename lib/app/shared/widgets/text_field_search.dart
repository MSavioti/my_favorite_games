import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _search(String searchTerm) {
      Navigator.of(context).pushNamed('/search', arguments: searchTerm);
    }

    return TextField(
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
