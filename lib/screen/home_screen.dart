
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class HomeScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }

}

class HomeScreenState extends State<HomeScreen>{
  InAppWebViewController? webViewController;
  PullToRefreshController? refreshController;
  var initialUrl = "https://www.google.com";
  bool isLoading = false;
  double progess = 0;

  @override
  void initState() {
    super.initState();

    refreshController = PullToRefreshController(
      onRefresh: (){
        webViewController!.reload();
      },
      options: PullToRefreshOptions(
        color: Color(0xFFe01559),
        size: AndroidPullToRefreshSize.LARGE,
        backgroundColor: Colors.white
      ),
    );
  }

  ////////======exit method

  _getOutOFApp(){
    if (Platform.isIOS){
      try{
        exit(0);
      } catch(e){
        print(e);
      }
    }else{
      try{SystemNavigator.pop();}catch(e){print(e);}
    }
  }


  exiDialogue(context){
    showDialog(context: context,
        builder: (context){
          return Dialog(
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20)
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 20,top: 30,bottom: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Are you sure to exit',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
                    Row(
                      children: [
                        ElevatedButton(
                            style:  ButtonStyle(backgroundColor:   MaterialStateProperty.all(Color(0xFFe01559),),),
                            onPressed: ()=>_getOutOFApp(), child: Text('Yes',style: TextStyle(color: Colors.white),)),
                        VerticalDivider(),
                        ElevatedButton(
                            style:  ButtonStyle(backgroundColor:   MaterialStateProperty.all(Color(0xFFe01559),),),
                            onPressed: ()=> Navigator.pop(context), child: Text('No',style: TextStyle(color: Colors.white))),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }
    );
  }

//====================exit



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        exiDialogue(context);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("WE ADS",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
          leading: IconButton(onPressed: () async{
            if(await webViewController!.canGoBack() ){
              webViewController!.goBack();
            }
          },icon: Icon(Icons.arrow_back_ios,color: Colors.white,),),
        ),



        body: Column(
          children: [
            Expanded(child: Stack(
              alignment: Alignment.center,
              children: [
                InAppWebView(
                  onLoadStart: (controller , initialUrl){
                    setState(() {
                      isLoading = true;
                    });
                  }
                  ,
                  onLoadStop: (controller, initialUrl){
                    refreshController!.endRefreshing();
                    setState(() {
                      isLoading = false;
                    });
                  },

                  pullToRefreshController: refreshController,
                  onWebViewCreated: (controller)=> webViewController = controller,
                  initialUrlRequest: URLRequest(url: Uri.parse(initialUrl),),

                ),
                Visibility(
                  visible: isLoading,
                    child: CircularProgressIndicator(

                  valueColor: AlwaysStoppedAnimation(Color(0xFFe01559)),
                )),
              ],
            ),),
          ],
        ),
      ),
    );
  }

}


