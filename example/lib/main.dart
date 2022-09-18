import 'package:flutter/material.dart';
import 'package:flutter_anchorlable/flutter_anchorlable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Hiyoko's Portfolio",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Widget contactIcon(String url, Widget icon) {
      return Container(
        alignment: Alignment.centerRight,
        child: IconButton(
          iconSize: 50,
          icon: icon,
          onPressed: () async {
            await launchUrl(Uri.parse(url));
          },
        ),
      );
    }

    Widget jumpButton(String data, GlobalKey anchor) => TextButton(
          onPressed: () => anchorlableBodyController.jumpToAnchor(anchor),
          child: Text(
            data,
            style: const TextStyle(fontSize: 30, color: Colors.black),
          ),
        );

    Widget Footer() {
      return Container(
        height: 100,
        width: MediaQuery.of(context).size.width,
        key: contactKey,
        alignment: Alignment.bottomLeft,
        color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                    alignment: Alignment.centerLeft,
                    child: const Text('Contact Me',
                        style: TextStyle(color: Colors.white, fontSize: 32))),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                contactIcon('https://github.com/yama-yeah',
                    const Icon(FontAwesomeIcons.github, color: Colors.white)),
                contactIcon(
                    'https://zenn.dev/antman',
                    const Icon(
                      Icons.web,
                      color: Colors.white,
                    )),
                contactIcon(
                    'https://www.kaggle.com/askeeee',
                    const Icon(FontAwesomeIcons.kaggle,
                        color: Colors.lightBlue)),
              ],
            ),
          ],
        ),
      );
    }

    Widget Header() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: const [
              Text("Hiyoko's Portfolio", style: TextStyle(fontSize: 32))
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                jumpButton('works', worksKey),
                jumpButton('Intro', introKey),
                jumpButton('Contact', contactKey),
              ],
            ),
          ),
        ],
      );
    }

    Widget work(String data, String iamgeUrl, String url) => TextButton(
        onPressed: () async => await launchUrl(Uri.parse(url)),
        child: Column(
          children: [
            Text(data, style: TextStyle(fontSize: 48)),
            Image.network(
              iamgeUrl,
              width: 400,
            ),
          ],
        ));

    return Scaffold(
      body: AnchorlableScrollColumn(
        shrinkWrap: true,
        controller: anchorlableBodyController,
        key: bodyKey,
        children: [
          Header(),
          const SizedBox(
            height: 60,
          ),
          const Text(
            key: introKey,
            'Hello My name is Hiyoko!!!',
            style: TextStyle(fontSize: 32),
          ),
          const Text(
            'I like a Humbugger!!!',
            style: TextStyle(fontSize: 32),
          ),
          const Text(
            'Welcome to my site',
            style: TextStyle(fontSize: 32),
          ),
          const SizedBox(
            height: 60,
          ),
          SizedBox(
            height: 1100,
            child: Column(
              key: worksKey,
              children: [
                const Text(
                  'There are My Works',
                  style: TextStyle(fontSize: 32),
                ),
                Row(
                  children: [
                    work(
                      'Maho',
                      'https://user-images.githubusercontent.com/82094614/190878311-8049c43e-360f-449c-85d2-c3958aa5754f.png',
                      'https://github.com/yama-yeah/Maho',
                    ),
                    work(
                        'glassmorphism_widget',
                        'https://user-images.githubusercontent.com/82094614/147371522-76db6662-3945-4470-bad3-1dfec306ccd1.png',
                        'https://github.com/yama-yeah/glassmorphism_widgets'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          Footer(),
        ],
      ),
    );
  }
}

final anchorlableBodyController = AnchorlableController();
const bodyKey = GlobalObjectKey('body');
const introKey = GlobalObjectKey('intro');
const worksKey = GlobalObjectKey('works');
const contactKey = GlobalObjectKey('contact');
