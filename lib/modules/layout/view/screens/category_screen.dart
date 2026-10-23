import 'package:flutter/material.dart';

import 'package:provider/provider.dart';


import '../../../../core/app_categories/app_categories.dart';
import '../../../../core/theme/app_colors.dart';
import '../manager/layout_provider.dart';
import '../widgets/category_widget.dart';

class CategoryScreen extends StatelessWidget {
   CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LayoutProvider>(
      builder: (BuildContext context, LayoutProvider provider, Widget? child) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text("Good Morning\nHere is Some News For You",style: TextStyle(
                  color: AppColors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w500
              ),),
              SizedBox(height: 20,),
              Expanded(
                  child: ListView.separated(
                      itemBuilder: (context,index){
                        return InkWell(
                            onTap:(){
                             provider.onChangeCategory(AppCategories.categories[index]);
                            },
                            child: CategoryWidget(category: AppCategories.categories[index],isLeft: index%2==0,));
                      }
                      , separatorBuilder: (context,index){
                    return SizedBox(height: 20,);
                  },
                      itemCount: AppCategories.categories.length))


            ],
          ),
        );
      },
    );
  }
}
