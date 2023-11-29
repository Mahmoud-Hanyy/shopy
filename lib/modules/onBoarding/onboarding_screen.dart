import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopy/modules/shop_login/cubit/cubit.dart';
import 'package:shopy/modules/shop_login/login.dart';
import 'package:shopy/network/local/cache_helper.dart';
import 'package:shopy/shared/components/components.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel{
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}
//ignore: must_be_immutable
class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}
ShopingLoginCubit get (context) => BlocProvider.of(context);

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  List<BoardingModel> boarding= [
    BoardingModel(
      image: 'lib/images/market.png',
      title: 'Screen Title 1',
      body: 'Screen Body 1',
    ),
    BoardingModel(
      image: 'lib/images/online.png',
      title: 'Screen Title 2',
      body: 'Screen Body 2',
    ),
    BoardingModel(
      image: 'lib/images/retail.png',
      title: 'Screen Title 3',
      body: 'Screen Body 3',
    ),
  ];

  bool isLast = false;

  void submit(){
  CacheHelper.saveData(
      key: 'onBoarding',
      value: true,
    ).then((value){
      if(value){
        navigateAndFinish(context, ShopLogInScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: (){
              submit();
            },
            child: const Text('SKIP',
              style: TextStyle(
                  color: Colors.blue,
                  fontFamily: 'cairo',
                  fontWeight: FontWeight.bold),)
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context,index) => buildBoardingItem(boarding[index]),
              itemCount: boarding.length,
              controller: boardController,
                onPageChanged: (int index){
                if(index==boarding.length-1){
                  setState(() {
                    isLast = true;
                  });
                  }else{
                  setState(() {
                    isLast = false;
                  });
                  }
                },
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: boardController,
                    count: boarding.length,
                    effect: const ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      dotHeight: 10.0,
                      expansionFactor: 4,
                      dotWidth: 10.0,
                      spacing: 5.0,
                      activeDotColor: Colors.blue,
                    ) ,
                ),
                const Spacer(),
                FloatingActionButton(onPressed: (){
                  if(isLast){
                    submit();
                  }else{
                    boardController.nextPage(
                        duration: const Duration(
                          milliseconds: 750,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn
                    );
                  }
                },
                  child: const Icon(Icons.arrow_forward_ios,color: Colors.white,)
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child:Image(
            image: AssetImage(model.image),
      )),
        const SizedBox(
        height: 20.0,
        ),
      Text(model.title,
        style:const TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'cairo',
        ),
      ),
      Text(model.body,
        style:const TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'cairo',
        ),
      ),
    ],
  );
}
