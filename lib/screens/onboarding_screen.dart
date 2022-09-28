import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _pageController;

  int _pageIndex = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                  child: PageView.builder(
                      itemCount: demoData.length,
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() {
                          _pageIndex = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        return OnboardingContent(
                            title: demoData[index].title,
                            subtitle: demoData[index].subtitle,
                            img: demoData[index].img);
                      })),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      _pageController.previousPage(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.ease);
                    },
                    icon:const Icon(Icons.arrow_back_ios),
                  ),
                  const Spacer(),
                  _pageIndex != 2 ?
                  IconButton(
                    onPressed: () {
                      _pageController.nextPage(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.ease);
                    },
                    icon:const Icon(Icons.arrow_forward_ios),
                  ) : TextButton(onPressed: (){}, child: Text("Let's Go")),
                  // SizedBox(
                  //   width: 60,
                  //   height: 60,
                  //   child: ElevatedButton(
                  //     onPressed: () {
                  //       _pageController.nextPage(
                  //           duration: const Duration(milliseconds: 400),
                  //           curve: Curves.ease);
                  //     },
                  //     style: ElevatedButton.styleFrom(shape: const CircleBorder()),
                  //     child: const Icon(Icons.arrow_forward_ios),
                  //   ),
                  // ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...List.generate(
                      demoData.length,
                      (index) => Padding(
                            padding: const EdgeInsets.only(right: 4),
                            child: DotIndicator(
                              isActive: index == _pageIndex,
                            ),
                          )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DotIndicator extends StatelessWidget {
  final bool isActive;

  const DotIndicator({
    Key? key,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      height: isActive ? 12 : 4,
      width: 4,
      decoration: BoxDecoration(
          color: isActive ? Colors.black : Colors.grey,
          borderRadius: const BorderRadius.all(Radius.circular(12))),
    );
  }
}

class OnBoard {
  final String img, title, subtitle;

  const OnBoard({
    required this.img,
    required this.title,
    required this.subtitle,
  });
}

final List<OnBoard> demoData = [
  const OnBoard(
      img:
          "https://i.pinimg.com/originals/50/ec/1c/50ec1c1355222367c732b3c0c39720d2.jpg",
      subtitle:
          "Kakkoiikara sukina n janai Sukidakara kakkoii ndayoDare ka ni baka ni sarete mo nantomo nai",
      title: "Datte watashi no hiiroo"),
  const OnBoard(
      img:
          "https://ik.imagekit.io/v3rxhgrfa6i/wp-content/uploads/2022/07/e29c94efb88f19-info-tentang-gambar-pemandangan-alam-jepang-terbaik-660x330.jpg",
      subtitle:
          "Kakkoiikara sukina n janai Sukidakara kakkoii ndayoDare ka ni baka ni sarete mo nantomo nai",
      title: "Matane tte hitorigoto"),
  const OnBoard(
      img:
          "https://i.pinimg.com/originals/d0/2d/34/d02d34efe66693da6e66970af175e929.jpg",
      subtitle:
          "Aa, hontouni aishite yamanai anata no koto Watashi dake no Hiiroo ni natteyo",
      title: "LINE datte shiteitaishi"),
];

class OnboardingContent extends StatelessWidget {
  final String title;
  final String subtitle;
  final String img;

  const OnboardingContent({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.img,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Image.network(
          img,
          height: 205,
        ),
        const Spacer(),
        Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          subtitle,
          textAlign: TextAlign.center,
        ),
        const Spacer(),
      ],
    );
  }
}
