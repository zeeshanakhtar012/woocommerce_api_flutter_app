

String formatDate(String isoDate) {
String dateStringWithTimeZone = '2002-02-27T14:00:00-08:00';
DateTime dateTimeWithTimeZone = DateTime.parse(dateStringWithTimeZone);
return dateTimeWithTimeZone.toString();
}
