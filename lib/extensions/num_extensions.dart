import 'dart:math';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

extension NumExtension on num{

  SizedBox get height => SizedBox(height:toDouble());
  SizedBox get width => SizedBox(width:toDouble());

  Color get toColor =>Color.fromRGBO(toInt(), toInt(), toInt(), 1); // RGB değerleri aynı ise bunu kullanarak renk elde edebilirsiniz

  double get toRadian => (this * pi / 180).toDouble(); // verilen derecenin radyan dönüşümünü yapar.
  double get toDegree => (this * 180 / pi).toDouble(); // radyan değeri dereceye dönüştürür.

  BorderRadius get borderRadius => BorderRadius.circular(toDouble());





double get toVolts => this/1000;
  
   String get toDateTime{
      final format = DateFormat('dd.MM.yyyy HH:mm');
      return format.format(DateTime.fromMillisecondsSinceEpoch(this as int));
    
    }

    String get toDateTimeFromEpoch{

     if(this != 0){
       var epochTime = DateTime.fromMillisecondsSinceEpoch(this as int);

       if (epochTime != null) {
         var time = DateFormat('dd/MM/yyyy, HH:mm').format(epochTime);

         return time;
       }

       return "";
     }

      return "";

    }



// girilen sayıdan fontweight elde eder
 FontWeight get weight{
    switch (this){
      case 600:
      return FontWeight.w600;
      case 700:
      return FontWeight.w700;
      case 800:
      return FontWeight.w800;
      case 900:
      return FontWeight.w900;
      case 400:
      return FontWeight.w400;
      default:
      return FontWeight.w500;

    }
 }
}
