import 'package:expathy/Providers/Question%20Provider/question_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'Auth Provider/auth_provider.dart';

class AppProvider {
  static final List<SingleChildWidget> appProviders = [
    ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
    ChangeNotifierProvider<QuestionProvider>(create: (_) => QuestionProvider()),
  ];
}
