class DateUtilities {
  static String compareIsoStringWithCurrentDateInMinutes(
      {String isoDateString}) {
    final providedDate = DateTime.parse(isoDateString);
    final differenceInMinute =
        DateTime.now().difference(providedDate).inMinutes;
    return differenceInMinute.toString();
  }
}
