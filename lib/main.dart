import 'package:blogclub/carousel/carousel_slider.dart';
import 'package:blogclub/data.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
                color: primaryTextColor),
            headlineMedium: TextStyle(
                fontFamily: defaultFontFamily,
                fontWeight: FontWeight.w700,
                fontSize: 24,
                color: primaryTextColor),
            headlineLarge: TextStyle(
                fontFamily: defaultFontFamily,
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: primaryTextColor),
          )),
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
                padding: const EdgeInsets.fromLTRB(32, 0, 0, 0),
                child: Text(
                  'Explore Today’s',
                  style: themeData.textTheme.headlineMedium,
                ),
              ),
              _StoryList(stories: stories),
              const SizedBox(
                height: 16,
              ),
              _CategoryList()
            ],
          ),
        ),
      ),
    );
  }
}

class _StoryList extends StatelessWidget {
  const _StoryList({
    required this.stories,
  });

  final List<Story> stories;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 90,
      margin: const EdgeInsets.fromLTRB(32, 16, 0, 0),
      child: ListView.builder(
          itemCount: AppDatabase.stories.length,
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return _Story(story: stories[index]);
          }),
    );
  }
}

class _Story extends StatelessWidget {
  const _Story({
    required this.story,
  });

  final Story story;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            story.isViewed ? viewedStrory() : normalStory(),
            Positioned(
                right: 0,
                bottom: 0,
                child: Image.asset(
                  'assets/img/icons/${story.iconFileName}',
                  width: 24,
                  height: 24,
                ))
          ],
        ),
        const SizedBox(
          height: 2,
        ),
        Text(story.name)
      ],
    );
  }

  Widget normalStory() {
    return Container(
      width: 68,
      height: 68,
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [
          Color(0xff376AED),
          Color(0xff49B0E2),
          Color(0xff9CECFB),
        ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
        ),
        padding: const EdgeInsets.all(4),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(17),
          child: Image.asset('assets/img/stories/${story.imageFileName}'),
        ),
      ),
    );
  }

  Widget viewedStrory() {
    return Container(
      width: 68,
      height: 68,
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
      ),
      child: DottedBorder(
        padding: EdgeInsets.zero,
        radius: const Radius.circular(22),
        color: const Color(0xff7B8BB2),
        strokeWidth: 2,
        dashPattern: const [8, 3],
        borderType: BorderType.RRect,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
          ),
          padding: const EdgeInsets.all(4),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(17),
            child: Image.asset('assets/img/stories/${story.imageFileName}'),
          ),
        ),
      ),
    );
  }
}

class _CategoryList extends StatelessWidget {
  final List<Category> categoryList = AppDatabase.categories;
  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: categoryList.length,
      itemBuilder: (BuildContext context, int index, int realIndex) {
        return _CategoryItem(
          category: categoryList[index],
          left: index == 0 ? 32 : 8,
          right: index == categoryList.length - 1 ? 32 : 8,
        );
      },
      options: CarouselOptions(
          aspectRatio: 1.2,
          viewportFraction: 0.8,
          disableCenter: true,
          initialPage: 0,
          autoPlay: false,
          scrollPhysics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          padEnds: false,
          enableInfiniteScroll: false,
          enlargeCenterPage: true,
          enlargeStrategy: CenterPageEnlargeStrategy.height),
    );
  }
}

class _CategoryItem extends StatelessWidget {
  const _CategoryItem(
      {super.key,
      required this.category,
      required this.left,
      required this.right});

  final Category category;
  final double left;
  final double right;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(left, 0, right, 0),
      child: Stack(
        children: [
          Positioned.fill(
            top: 100,
            right: 65,
            left: 65,
            bottom: 48,
            child: Container(
              decoration: const BoxDecoration(boxShadow: [
                BoxShadow(blurRadius: 32, color: Color(0xaa0D253C))
              ]),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
              ),
              foregroundDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  gradient: const LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.center,
                      colors: [
                        Color(0xff0D253C),
                        Colors.transparent,
                      ])),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: Image.asset(
                  'assets/img/posts/large/${category.imageFileName}',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            left: 32,
            bottom: 48,
            child: Text(category.title,
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge!
                    .apply(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
