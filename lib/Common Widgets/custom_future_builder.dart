import 'package:expathy/Common%20Widgets/elevated_button_widget.dart';
import 'package:expathy/Utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';
import '../Remote/app_exceptions.dart';
import '../Utils/app_images.dart';

class CustomFutureBuilder<T> extends StatelessWidget {
  final Widget Function(T data) data;
  final Widget loaderWidget;
  final Future<T>? future;
  final Function()? noInternetOnPressed;
  final Function(bool loading)? onLoading;

  const CustomFutureBuilder({
    Key? key,
    required this.future,
    required this.data,
    required this.loaderWidget,
    this.onLoading,
    this.noInternetOnPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future,
      builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return loaderWidget;
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            if (snapshot.error is NoInternetException) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 250,
                      height: 250,
                      child: Lottie.asset(
                        AppImages.networkJson,
                        fit: BoxFit.contain,
                      ),
                    ),
                    ElevatedButtonWidget(
                      onPressed: noInternetOnPressed,
                      text: 'Try Again',
                      primary: AppColors.borderColor,
                      height: 45,
                    )
                  ],
                ),
              );
            }
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          } else if (snapshot.hasData) {
            return data(snapshot.data as T);
          } else {
            return Center(
              child: Lottie.asset(AppImages.emptyJson, width: 300, height: 300),
            );
          }
        } else {
          return Center(child: Text('State: ${snapshot.connectionState}'));
        }
      },
    );
  }
}
