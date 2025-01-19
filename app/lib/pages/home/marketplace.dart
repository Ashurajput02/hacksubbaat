import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Marketplace extends StatefulWidget {
  final String name;
  const Marketplace({super.key, required this.name});

  @override
  State<Marketplace> createState() => _MarketplaceState();
}

class _MarketplaceState extends State<Marketplace> {
  Map<dynamic, dynamic>? products;

  @override
  void initState() {
    super.initState();
    products = Hive.box('appBox').get(widget.name);
  }

  void urlLauncher(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
    ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(widget.name, style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: [
          if (products != null && products!.isNotEmpty)
            Expanded(
              child: ListView.builder(
                itemCount: products!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        urlLauncher(products!.values.elementAt(index)[2]);
                      },
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://i.pinimg.com/originals/01/ca/da/01cada77a0a7d326d85b7969fe26a728.jpg'),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        tileColor:
                            Theme.of(context).colorScheme.surfaceContainer,
                        title: Text(
                          products!.keys.elementAt(index),
                          maxLines: 2,
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        subtitle: Text(
                          'Price: ₹' + products!.values.elementAt(index)[1],
                          maxLines: 2,
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
