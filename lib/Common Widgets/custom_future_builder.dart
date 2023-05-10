import 'package:expathy/Common%20Widgets/elevated_button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../Remote/app_exceptions.dart';
import '../Utils/app_images.dart';

class CustomFutureBuilder<T> extends StatelessWidget {
  final Widget Function(T data) data;
  final Widget loaderWidget;
  final Future<T> future;
  final Function(bool loading)? onLoading;
  const CustomFutureBuilder({
    Key? key,
    required this.future,
    required this.data,
    required this.loaderWidget,
    this.onLoading,
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
                    Lottie.asset(
                      AppImages.networkJson,
                    ),
                    ElevatedButtonWidget(onPressed: () {}, text: 'Try Again')
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
