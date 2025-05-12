import 'package:flutter/material.dart';

class ProductPosTile extends StatelessWidget {
  final String image;
  final String title;
  final String price;
  final String item;

  const ProductPosTile({
    Key? key,
    required this.image,
    required this.title,
    required this.price,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 20, bottom: 20),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: const Color(0xff1f2029),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(
              16,
            ), // Preserves the rounded corners
            child: Image.network(
              image,
              height: 130, // Preserves the height
              width:
                  double
                      .infinity, // Ensures the image takes available width for BoxFit.cover
              fit: BoxFit.cover, // Preserves the image fit
              errorBuilder: (context, error, stackTrace) {
                // A fallback widget to display when the image fails to load
                return Container(
                  height: 130,
                  width: double.infinity,
                  color: const Color(
                    0xff3a3b44,
                  ), // A background color for the error state
                  child: const Center(
                    child: Icon(
                      Icons.image_not_supported,
                      color:
                          Colors
                              .white70, // Icon color for better visibility on dark background
                      size: 40, // A reasonable icon size
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                price,
                style: const TextStyle(color: Colors.deepOrange, fontSize: 20),
              ),
              Text(
                item,
                style: const TextStyle(color: Colors.white60, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
