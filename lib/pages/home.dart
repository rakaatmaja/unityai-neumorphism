import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> urls = [
    'https://chat.openai.com/',
    'https://bing.com/chat',
    'https://bard.google.com/',
    'https://perplexity.ai/',
    'https://www.deepl.com/translator',
  ];

  List<bool> isButtonPressedList = [false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          title: const Text('UnityAI'),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const SizedBox(
              height: 50,
            ),
            ListTile(
              title: const Text('About'),
              leading: const Icon(Icons.info),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const AlertDialog(
                      title: Text('UnityAI'),
                      content: Text('This app crafted by Raka'),
                    );
                  },
                );
              },
            ),
            ListTile(
              title: const Text('Licenses'),
              leading: const Icon(Icons.copyright),
              onTap: () {
                showAboutDialog(context: context);
              },
            ),
          ],
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(42),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 60.0,
          crossAxisSpacing: 60.0,
          children: [
            btnGrid(context, 0, 'assets/images/openai.png', 'Chat GPT'),
            btnGrid(context, 1, 'assets/images/bing.png', 'BingAI'),
            btnGrid(context, 2, 'assets/images/bard.png', 'Bard'),
            btnGrid(context, 3, 'assets/images/perplexity.png', 'Perplexity'),
            btnGrid(context, 4, 'assets/images/deppl.png', 'DeepL'),
          ],
        ),
      ),
    );
  }

  btnGrid(BuildContext context, int index, String imageUrl, String title) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          isButtonPressedList[index] = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          isButtonPressedList[index] = false;
          _navigateToWebView(urls[index]);
        });
      },
      onTapCancel: () {
        setState(() {
          isButtonPressedList[index] = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: MediaQuery.of(context).size.height + 1,
        width: MediaQuery.of(context).size.width + 1,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
          boxShadow: isButtonPressedList[index]
              ? []
              : [
                  const BoxShadow(
                    color: Colors.white,
                    offset: Offset(-6, -6),
                    blurRadius: 15,
                    spreadRadius: 1,
                  ),
                  BoxShadow(
                    color: Colors.grey.shade500,
                    offset: const Offset(6, 6),
                    blurRadius: 15,
                    spreadRadius: 1,
                  ),
                ],
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          child: Column(
            children: [
              Image.asset(
                imageUrl,
                width: MediaQuery.of(context).size.width / 8 + 2,
                height: MediaQuery.of(context).size.height / 8 + 2,
              ),
              Text(title),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToWebView(String url) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WebViewPage(url: url),
      ),
    );
  }
}

class WebViewPage extends StatelessWidget {
  final String url;

  const WebViewPage({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          title: const Text('UnityAI'),
        ),
      ),
      body: WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) async {
          await webViewController.clearCache();
        },
       initialCookies: [],
      ),
    );
  }
}
