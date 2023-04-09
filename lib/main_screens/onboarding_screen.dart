import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:multi_store/main_screens/customer_home.dart';
import 'package:multi_store/main_screens/welcome_screen.dart';

class Onboardingscreen extends StatefulWidget {
  const Onboardingscreen({Key? key}) : super(key: key);

  @override
  State<Onboardingscreen> createState() => _OnboardingscreenState();
}

class _OnboardingscreenState extends State<Onboardingscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        showSkipButton: true,
        showDoneButton: true,
        showNextButton: true,
        done: const Text('Done'),
        skip: const Text('Skip'),
        next: const Icon(Icons.navigate_next_rounded),
        baseBtnStyle: TextButton.styleFrom(
          backgroundColor: Colors.transparent,
        ),
        pages: introPages(context),
        isBottomSafeArea: true,
        isTopSafeArea: true,
        onDone: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const WelcomeScreen(),
            ),
          );
        },
        onSkip: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const WelcomeScreen(),
            ),
          );
        },
      ),
    );
  }
}

List<PageViewModel> introPages(BuildContext context) => [
      PageViewModel(
        title: '',
        bodyWidget: Column(
          children: [
            // Image.asset(
            //   'assets/icon/logo.png',
            //   width: 350,
            // ),
            Lottie.asset('animations/sell.json', width: 350, repeat: true),
            const SizedBox(
              height: 40,
            ),
            const Text(
              'Sell Online',
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Local shopkeepers can sell their products in online dukan and track their income.',
              style: TextStyle(fontSize: 15),
              textAlign: TextAlign.center,
            )
          ],
        ),
        // body: 'Let our chatbot assist you with all your needs',
        // image: buildImage('assets/icon/chatbot.png'),
        decoration: getPageDecoration(),
      ),
      PageViewModel(
        // title: 'Modern balance sheet',
        title: '',
        bodyWidget: Column(
          children: [
            // Image.asset(
            //   'assets/icon/logo.png',
            //   width: 350,
            // ),
            Lottie.asset('animations/buy.json', repeat: true, width: 350),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Buy',
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Shop online with our app with ease and find products you need to buy daily.',
              style: TextStyle(fontSize: 15),
              textAlign: TextAlign.center,
            )
          ],
        ),
        // body:
        //     'Get your old traditional balance sheet in a more interactive and simple form',
        // image: Center(child: buildImage('assets/icon/intropage1.jpg')),
        //getPageDecoration, a method to customise the page style
        decoration: getPageDecoration(),
      ),
      PageViewModel(
        title: '',
        bodyWidget: Column(
          children: [
            // Image.asset(
            //   'assets/icon/logo.png',
            //   width: 350,
            // ),
            Lottie.asset('animations/discover.json', width: 350, repeat: true),
            const SizedBox(
              height: 50,
            ),
            const Text(
              'Discover new local products',
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Find your favourite products from multiple local stores.',
              style: TextStyle(fontSize: 15),
              textAlign: TextAlign.center,
            )
          ],
        ),
        // body: 'Let our chatbot assist you with all your needs',
        // image: buildImage('assets/icon/chatbot.png'),
        decoration: getPageDecoration(),
      ),
      PageViewModel(
        title: '',
        bodyWidget: Column(
          children: [
            // Image.asset(
            //   'assets/icon/logo.png',
            //   width: 350,
            // ),
            Lottie.asset('animations/payment.json',
                repeat: true, width: 350, alignment: Alignment.center),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Easy & Safe Payment',
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Pay for the products you buy safely & easily.',
              style: TextStyle(fontSize: 15),
              textAlign: TextAlign.center,
            )
          ],
        ),
        // body: 'Planning your financial goals are now made easier with our app',
        // image: buildImage('assets/icon/goalplan.png'),
        decoration: getPageDecoration(),
      ),
    ];

Widget buildImage(String imagePath) {
  return Align(
    alignment: Alignment.center,
    child: Image.asset(
      imagePath,
      width: 200,
      height: 400,
      // fit: BoxFit.cover,
      alignment: Alignment.center,
    ),
  );
}

PageDecoration getPageDecoration() {
  return const PageDecoration(
      // imageAlignment: Alignment.center,
      bodyAlignment: Alignment.center,
      imagePadding: EdgeInsets.only(top: 150),
      bodyPadding: EdgeInsets.only(left: 20, right: 20),
      // titlePadding: EdgeInsets.only(top: 50),
      bodyTextStyle: TextStyle(fontSize: 15),
      titleTextStyle: TextStyle(fontSize: 23, fontWeight: FontWeight.bold));
}
