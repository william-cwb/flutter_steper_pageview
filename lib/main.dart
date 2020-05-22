import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF230903),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Steper'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 70,
            width: double.infinity,
            color: Theme.of(context).primaryColor,
            child: AnimatedBuilder(
              animation: _pageController,
              builder: (_, __) {
                int index = 0;
                if (_pageController.positions.isNotEmpty) {
                  index = _pageController?.page?.round() ?? 0;
                }
                return _buildSteper(index);
              },
            ),
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              children: <Widget>[
                _buildContainer(1),
                _buildContainer(2),
                _buildContainer(3),
                _buildContainer(4),
                _buildContainer(5),
                _buildContainer(6),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildContainer(int indexPage) {
    return Container(
      child: Center(
        child: Text('Page $indexPage'),
      ),
    );
  }

  Widget _buildSteper(int currentPage) {
    return ListView.builder(
      itemCount: 6,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        int otherIndex = index + 1;
        return GestureDetector(
          onTap: () {
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeIn,
            );
          },
          child: Container(
            width: 50,
            height: 50,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color:
                  currentPage == index ? Colors.white.withOpacity(0.2) : null,
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
              child: Text(
                otherIndex.toString(),
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
