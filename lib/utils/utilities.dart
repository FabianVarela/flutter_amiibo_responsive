import 'package:intl/intl.dart';

class Utilities {
  static DateTime stringToDate(String date) =>
      DateFormat('yyyy-MM-dd').parse(date);

  static String setLoremText() =>
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus vitae '
      'arcu ac erat consectetur imperdiet rutrum sed ex. Morbi orci justo, '
      'tincidunt ac vehicula a, sagittis sit amet sapien. '
      'Cras consectetur nisi quis ligula molestie, vel ullamcorper massa '
      'sollicitudin. In molestie a nulla ut malesuada. Quisque rhoncus '
      'suscipit justo, in auctor metus interdum quis. Duis sodales cursus '
      'tortor, eu mattis eros rhoncus ut. Donec sagittis ex non pulvinar '
      'auctor. Pellentesque et sollicitudin mi. Quisque eget efficitur '
      'libero, porta vestibulum leo. Phasellus justo risus, commodo '
      'non viverra eget, mattis ac lacus. Etiam eget finibus erat. '
      'Sed et placerat ipsum.';
}
