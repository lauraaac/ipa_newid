import 'package:flutter/material.dart';

class TextFormFieldWithClearIcon extends StatefulWidget {

  final String hintText;

  const TextFormFieldWithClearIcon({super.key, 
    required this.hintText,
  });


  
  @override
  _TextFormFieldWithClearIconState createState() =>
      _TextFormFieldWithClearIconState();
}

class _TextFormFieldWithClearIconState
    extends State<TextFormFieldWithClearIcon> {
  final TextEditingController _controllerName = TextEditingController();
  bool _showClearIcon = false;

  @override
  void initState() {
    super.initState();
    _controllerName.addListener(() {
      setState(() {
        _showClearIcon = _controllerName.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _controllerName.dispose();
    super.dispose();
  }

  void _clearText() {
    setState(() {
      _controllerName.clear();
      _showClearIcon = false;
    });
  }

  String _get(){
    return _controllerName.text;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Ingresa un valor';
              }
              return null;
      },
      controller: _controllerName,
      decoration: InputDecoration(
        hintText: widget.hintText,
        suffixIcon: _showClearIcon
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: _clearText,
              )
            : null,
      ),
    );
  }
}