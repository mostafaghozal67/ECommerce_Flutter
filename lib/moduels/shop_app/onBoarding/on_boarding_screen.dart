import 'package:first_project/moduels/shop_app/login/shop_login_screen.dart';
import 'package:first_project/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel{ 
  late final String image;
  late final String title;
  late final String body;
  BoardingModel({required this.image, required this.title, required this.body});
}

class OnBoardingScreen extends StatefulWidget {

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var BoardController = PageController();
  bool isLast = false;
  List<BoardingModel> boarding =[
    BoardingModel(image: 'assets/images/onboard_1.jpg', title: "On Board 1 Title", body: "On Board 1 Body"),
    BoardingModel(image: 'assets/images/onboard_1.jpg', title: "On Board 2 Title", body: "On Board 2 Body"),
    BoardingModel(image: 'assets/images/onboard_1.jpg', title: "On Board 3 Title", body: "On Board 3 Body"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(onPressed: (){
            CacheHelper.saveData(key: 'OnBoarding', value: true).then((value) {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ShopLoginScreen()));
            });

          }, child: const Text("SKIP",style: TextStyle(color: Colors.blue),))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(children: [
          Expanded(
            child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                onPageChanged: (index) {
                  if(index == boarding.length-1){
                    setState(() {
                      isLast = true;
                      //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ShopLoginScreen()));
                    });
                  }
                  else{
                    setState(() {
                      isLast = false;
                    });
                  }

                },
                controller: BoardController,
                itemBuilder: (context,index) => BuildBoardingItem(boarding[index]),
                itemCount: boarding.length,
            ),
          ),
          const SizedBox(height: 40.0,),
          Row(children: [
            //Text("Indicator"),
            SmoothPageIndicator(
                controller: BoardController, 
                effect: const ExpandingDotsEffect(
                  dotColor: Colors.grey,
                  activeDotColor: Colors.blue,
                  dotHeight: 10.0,
                  dotWidth: 10.0,
                  expansionFactor: 4, 
                  spacing: 5.0 
                ),
                count: boarding.length),
            const Spacer(),
            FloatingActionButton(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              onPressed: (){
                CacheHelper.saveData(key: 'OnBoarding', value: true).then((value) {
                  if(isLast){
                    //Navigator.push(context, MaterialPageRoute(builder: (context) => ShopLoginScreen()));
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ShopLoginScreen())); 
         
                  }
                  else{
                    BoardController.nextPage(
                        duration: const Duration(
                            microseconds: 750
                        ),
                        curve: Curves.fastLinearToSlowEaseIn); 
                  }
                });



              },
              child: const Icon(Icons.arrow_forward_ios),)
          ],)
            ],),
      )
    );
  }

  Widget BuildBoardingItem(BoardingModel model) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(child: Image(image: AssetImage(model.image))),
      const SizedBox(height: 30.0,),
      Text(model.title,style: const TextStyle(fontSize: 24.0,),),
      const SizedBox(height: 15.0,),
      Text(model.body,style: const TextStyle(fontSize: 14.0,),),
      const SizedBox(height: 30.0,)
    ],
  );
}
