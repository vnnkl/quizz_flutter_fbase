import 'services.dart';

class Global {
  // App Data
  static final String title = "vnnkl";

  // Data models
  static final Map models = {
    Topic: (data) => Topic.fromMap(data),
    Quiz: (data) => Quiz.fromMap(data),
    Report: (data) => Report.fromMap(data),
  };
}
