import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget defaultButton({
  required double width,
  required Color background,
  required Function function,
  required String text,
})=> Container(
  width: width,
  color: background,
  child: MaterialButton(
    onPressed: function(),
    child: Text(
      text.toUpperCase(),
      style: const TextStyle(
        color: Colors.white,
      ),
    ),
  ),
);


Widget defaultFormField({
  Function? onSubmit,
  Function? onChange,
  Function? validate,
  required TextEditingController controller,
  required TextInputType type,
  required String label,
  required IconData prefix,
})=>TextFormField(
  controller: controller,
  keyboardType: type,
  onFieldSubmitted: onSubmit!(),
  onChanged: onChange!(),
  validator: validate!(),
  decoration: InputDecoration(
    labelText: label,
    border: const OutlineInputBorder(),
  ),
);


Widget buildArticleItem(article,context)=> InkWell(
  child: Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Container(
          width: 120.0,
          height: 120.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              10.0,
            ),
            image: DecorationImage(
              image: NetworkImage(
                '${article['urlToImage']}',),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: SizedBox(
            height: 120.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    '${article['title']}',
                    style: const TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '${article['publishedAt']}',
                  style: const TextStyle(
                    fontSize: 18.0,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  ),
  onTap: (){
  },
);

Widget articleBuilder(list,context)=>ConditionalBuilder(
  condition: list.length > 0,
  builder: (context)=>ListView.separated(
    itemBuilder:(context,index)=>buildArticleItem(list[index],context),
    separatorBuilder: (context,index)=>const SizedBox(
      height: 10.0,
    ),
    itemCount: 10,
    physics: const BouncingScrollPhysics(),
  ),
  fallback: (context)=>const Center(child: CircularProgressIndicator(),
  ),
);

void navigateTo(context,widget)=>Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context)=>widget,
  ),
);

void navigateAndFinish(
    context,
    widget,
    )=>Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(
    builder: (context)=>widget,
  ),(route) => false,
);

void showToast({
  required String text,
  required ToastStates state,
})=>Fluttertoast.showToast(
msg: text,
toastLength: Toast.LENGTH_LONG,
gravity: ToastGravity.BOTTOM,
timeInSecForIosWeb: 5,
backgroundColor: chooseToastColor(state),
textColor: Colors.white,
fontSize: 16.0,
);

enum ToastStates{
  SUCCESS,
  ERROR,
  WARNING,
}

Color chooseToastColor(ToastStates state){
Color color;
  switch(state){
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}