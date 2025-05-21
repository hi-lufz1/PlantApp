import 'package:flutter/material.dart';
import '../../../constants.dart';

class FeaturedPlants extends StatelessWidget {
  const FeaturedPlants({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: const <Widget>[
          FeaturePlantCard(
            image: "assets/images/bottom_img_1.png",
            press: _dummyPress,
          ),
          FeaturePlantCard(
            image: "assets/images/bottom_img_2.png",
            press: _dummyPress,
          ),
        ],
      ),
    );
  }

  static void _dummyPress() {}
}

class FeaturePlantCard extends StatelessWidget {
  const FeaturePlantCard({
    super.key,
    required this.image,
    required this.press,
  });

  final String image;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: press,
      child: Container(
        margin: const EdgeInsets.only(
          left: kDefaultPadding,
          top: kDefaultPadding / 2,
          bottom: kDefaultPadding / 2,
        ),
        width: size.width * 0.8,
        height: 185,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(image),
          ),
        ),
      ),
    );
  }
}
