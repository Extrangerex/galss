import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselWithIndicator extends StatefulWidget {
  final List<Widget> items;
  final CarouselOptions? options;

  const CarouselWithIndicator({Key? key, required this.items, this.options})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicator> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Flexible(
        child: CarouselSlider(
          items: widget.items,
          carouselController: _controller,
          options: CarouselOptions(
            height: widget.options?.height,
            aspectRatio: widget.options?.aspectRatio ?? 16 / 9,
            viewportFraction: widget.options?.viewportFraction ?? 0.8,
            initialPage: widget.options?.initialPage ?? 0,
            enableInfiniteScroll: widget.options?.enableInfiniteScroll ?? true,
            reverse: widget.options?.reverse ?? false,
            autoPlayInterval:
                widget.options?.autoPlayInterval ?? const Duration(seconds: 4),
            autoPlayAnimationDuration:
                widget.options?.autoPlayAnimationDuration ??
                    const Duration(milliseconds: 800),
            autoPlayCurve:
                widget.options?.autoPlayCurve ?? Curves.fastOutSlowIn,
            enlargeCenterPage: widget.options?.enlargeCenterPage ?? false,
            onScrolled: widget.options?.onScrolled,
            scrollPhysics: widget.options?.scrollPhysics,
            pageSnapping: widget.options?.pageSnapping ?? true,
            scrollDirection: widget.options?.scrollDirection ?? Axis.horizontal,
            pauseAutoPlayOnTouch: widget.options?.pauseAutoPlayOnTouch ?? true,
            pauseAutoPlayOnManualNavigate:
                widget.options?.pauseAutoPlayOnManualNavigate ?? true,
            pauseAutoPlayInFiniteScroll:
                widget.options?.pauseAutoPlayInFiniteScroll ?? true,
            pageViewKey: widget.options?.pageViewKey,
            enlargeStrategy: widget.options?.enlargeStrategy ??
                CenterPageEnlargeStrategy.scale,
            disableCenter: widget.options?.disableCenter ?? false,
            autoPlay: widget.options?.autoPlay ?? true,
            onPageChanged: widget.options?.onPageChanged ??
                (index, reason) {
                  setState(() {
                    _current = index;
                  });
                },
          ),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: widget.items.asMap().entries.map((entry) {
          return GestureDetector(
            onTap: () => _controller.animateToPage(entry.key),
            child: Container(
              width: 12.0,
              height: 12.0,
              margin:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 4.0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black)
                      .withOpacity(_current == entry.key ? 0.9 : 0.4)),
            ),
          );
        }).toList(),
      ),
    ]);
  }
}
