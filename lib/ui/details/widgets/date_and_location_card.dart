import 'package:evently_c16/core/resources/ColorsManager.dart';
import 'package:flutter/material.dart';

class DateAndLocationCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subTitle;
  final bool trailingIcon;
  const DateAndLocationCard({super.key,
    required this.icon,
    required this.title,
    this.subTitle,
     this.trailingIcon= false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration:BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ColorsManager.primaryColor,width: 1),

      ) ,
      child: Row(
        children: [
          Container(
            padding:const EdgeInsets.all(12) ,
              decoration:BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: ColorsManager.primaryColor,
          ),
            child:Icon(icon,color: ColorsManager.lightBackgroundColor,) ,
              ),
          const SizedBox( width: 8,),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: ColorsManager.primaryColor
              ),),
              Visibility(
                visible: subTitle != null,
                  child: Text(subTitle??"",style:
                  Theme.of(context).textTheme.bodyMedium,))

            ],
          ),
          const Spacer(),
          Visibility(
            visible: trailingIcon,
              child: const Icon(Icons.arrow_forward_ios_rounded,color: ColorsManager.primaryColor,))
        ],
      )
    );
  }
}
