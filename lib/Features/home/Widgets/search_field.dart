import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key, this.controller, this.onChanged});

  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Material(
        elevation: 10,
        shadowColor: Colors.grey.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(15),
        child: TextField(
          controller: controller,
          onChanged: onChanged,
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            hintText: "Search for food",
            prefixIcon: Icon(Icons.search, color: Colors.grey),
            suffixIcon:
                controller == null
                    ? null
                    : ValueListenableBuilder<TextEditingValue>(
                      valueListenable: controller!,
                      builder:
                          (context, value, _) =>
                              value.text.isEmpty
                                  ? const SizedBox.shrink()
                                  : IconButton(
                                    icon: const Icon(
                                      Icons.clear,
                                      color: Colors.grey,
                                    ),
                                    onPressed: () {
                                      controller!.clear();
                                      onChanged?.call('');
                                    },
                                  ),
                    ),
            filled: true,
            fillColor: Colors.white,
            
          ),
        ),
      ),
    );
  }
}
