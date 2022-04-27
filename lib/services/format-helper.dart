import 'package:intl/intl.dart';

class FormatHelper {
  var _dolarFormat =  NumberFormat("#,##0.00", "en_US");

  String toDolar(num money){
     return _dolarFormat.format(money);
  }

  String toTime(num runtime){
    String hour = (runtime ~/ 60).toString();
    String minutes = (runtime % 60).toString();
    return hour+'h '+ minutes + ' min';
  }

}