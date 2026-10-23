import 'package:flutter/material.dart';

import 'package:news/core/theme/app_colors.dart';
import 'package:news/modules/layout/view/screens/search_screen.dart';

import 'package:provider/provider.dart';

import '../manager/layout_provider.dart';
import 'articles_screen.dart';
import 'category_screen.dart';

class Layout extends StatelessWidget {
  const Layout({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) =>LayoutProvider(),
      child: Consumer<LayoutProvider>(builder:(context,provider,child){
        return Scaffold(
          backgroundColor: AppColors.black,
          appBar: AppBar(
            scrolledUnderElevation: 0,
            iconTheme: IconThemeData(
                color: AppColors.white
            ),
            backgroundColor: AppColors.black,
            centerTitle: true,
            title: Text(provider.selectedCategory?.name??"Home" ,style: TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.w500,
                fontSize: 20
            ),),
            actions: [
              IconButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen()));
              }, icon: Icon(Icons.search)),
            ],
          ),
          drawer: Drawer(
            backgroundColor: AppColors.black,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DrawerHeader(
                    decoration: BoxDecoration(
                        color: AppColors.white
                    ),
                    child: Center(
                      child: Text("News App",style: TextStyle(
                          color: AppColors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold
                      ),),
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: (){
                      provider.goHome();
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.home,color: AppColors.white,size: 30,),
                        SizedBox(width: 16,),
                        Text("Go To Home",style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24
                        ),)
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          body:provider.selectedCategory!=null?
          ArticlesScreen()
              :CategoryScreen() ,
        );
      }),
    );
  }
}
