import 'package:intl/intl.dart';

String calendarFormat(String date) {
  // String isoDate = data!.releaseDate ?? "2023-08-22T14:28:35.000Z";
  DateTime dateTime = DateTime.parse(date);

  return DateFormat('MMM dd, yyyy').format(dateTime);
}
