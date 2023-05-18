import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PageListTile extends StatefulWidget {
  const PageListTile({
    super.key,
    required this.length,
    required this.onTap,
  });

  final int length;
  final Function(int) onTap;

  @override
  State<PageListTile> createState() => _PageListTileState();
}

class _PageListTileState extends State<PageListTile> {
  int currentIndex = 1;
  int shift = 0;

  final int maxCount = 5;

  int get initialLength {
    if (widget.length < maxCount) {
      return widget.length;
    } else {
      return maxCount;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.length > maxCount && shift >= 1)
          IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                setState(() {
                  if (shift >= 1) {
                    shift--;
                  }
                  currentIndex--;
                });
              }),
        ...List.generate(initialLength, (index) => index + 1 + shift)
            .map<Widget>((e) {
          return pageItemTile(e);
        }),
        if (widget.length > maxCount)
          IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: () {
                setState(() {
                  if (currentIndex >= maxCount) {
                    shift++;
                  }
                  currentIndex++;
                });
              })
      ],
    );
  }

  Widget pageItemTile(int index) {
    return InkWell(
      onTap: () {
        setState(() {
          if (index <= maxCount) {
            shift = 0;
          }
          currentIndex = index;
          widget.onTap(index);
        });
      },
      child: Container(
        width: 8.w,
        height: 8.w,
        margin: EdgeInsets.symmetric(horizontal: 1.w),
        padding: EdgeInsets.all(1.w),
        color: currentIndex == index ? Colors.blue : Colors.grey,
        child: FittedBox(
          child: Text(
            "$index",
            style: TextStyle(
                color: currentIndex == index ? Colors.white : Colors.blue),
          ),
        ),
      ),
    );
  }
}
