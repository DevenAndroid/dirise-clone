import 'package:flutter/material.dart';

import 'common_colour.dart';

class LikeButton extends StatefulWidget {
  const LikeButton({Key? key, required this.isLiked, required this.onPressed}) : super(key: key);
  final bool isLiked;
  final VoidCallback onPressed;

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
      return IconButton(
          onPressed: widget.onPressed,
          icon: Icon(
            widget.isLiked ? Icons.favorite : Icons.favorite_border_rounded,
            color: widget.isLiked ? Colors.red : Colors.grey.shade700,
            size: 20,
          )
      );
  }
}

class LikeButtonCat extends StatefulWidget {
  const LikeButtonCat({Key? key, required this.isLiked, required this.onPressed}) : super(key: key);
  final bool isLiked;
  final VoidCallback onPressed;

  @override
  State<LikeButtonCat> createState() => _LikeButtonCatState();
}

class _LikeButtonCatState extends State<LikeButtonCat> with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
      return GestureDetector(
          onTap: widget.onPressed,
          child: Icon(
            widget.isLiked ? Icons.favorite : Icons.favorite_border_rounded,
            // color: widget.isLiked ? Colors.red : Colors.grey.shade700,
            color: widget.isLiked ? Colors.red : Colors.red,
            size: 20,
          )
      );
  }
}
