import 'package:flutter/material.dart';
import 'package:smart_home/room/feature.dart';

class FeatureWidget extends StatelessWidget {
  const FeatureWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
          itemCount: feature.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) => Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Coming soon"),
                          backgroundColor: Colors.green,
                        ),
                      ),
                      child: Card(
                        elevation: 20,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: SizedBox(
                            height: 40,
                            child: Image.asset(feature[index]["imageURL"],
                                fit: BoxFit.cover),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(feature[index]["name"],
                        style: const TextStyle(fontWeight: FontWeight.bold))
                  ],
                ),
              )),
    );
  }
}
