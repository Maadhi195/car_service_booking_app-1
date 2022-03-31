Future<void> delayFunction({int? miliseconds = 100}) async {
  await Future.delayed(Duration(milliseconds: miliseconds ?? 100), () {
    // Do something
  });
}
