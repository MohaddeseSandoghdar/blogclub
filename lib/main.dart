import 'package:blogclub/data.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static const defaultFontFamily = 'Avenir';

  @override
  Widget build(BuildContext context) {
    const primaryTextColor = Color(0xff0D253C);
    const secondaryTextColor = Color(0xff2D4379);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          textTheme: const TextTheme(
              titleMedium: TextStyle(
                  fontFamily: defaultFontFamily,
                  fontSize: 14,
                  color: secondaryTextColor),
              titleLarge: TextStyle(
                  fontFamily: defaultFontFamily,
                  fontWeight: FontWeight.bold,
                  color: primaryTextColor))),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final stories = AppDatabase.stories;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 16, 32, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Hi, Jonathan',
                      style: themeData.textTheme.titleMedium,
                    ),
                    Image.asset(
                      'assets/img/icons/notification.png',
                      width: 24,
                      height: 24,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
                child: Text(
                  'Explore Today’s',
                  style: themeData.textTheme.titleLarge,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 90,
                margin: const EdgeInsets.fromLTRB(32, 10, 0, 0),
                child: ListView.builder(
                    itemCount: AppDatabase.stories.length,
                    scrollDirection: Axis.horizontal,
                    // padding:
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                width: 68,
                                height: 68,
                                margin: const EdgeInsets.only(right: 8),
                                padding: const EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                      colors: [
                                        Color(0xff376AED),
                                        Color(0xff49B0E2),
                                        Color(0xff9CECFB),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight),
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding: const EdgeInsets.all(4),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.asset(
                                        'assets/img/stories/${AppDatabase.stories[index].imageFileName}'),
                                  ),
                                ),
                              ),
                              Positioned(
                                  right: 0,
                                  bottom: 0,
                                  child: Image.asset(
                                    'assets/img/icons/${stories[index].iconFileName}',
                                    width: 24,
                                    height: 24,
                                  ))
                            ],
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(AppDatabase.stories[index].name)
                        ],
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
