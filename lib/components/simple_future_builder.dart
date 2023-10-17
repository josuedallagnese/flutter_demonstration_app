import 'package:flutter/material.dart';

class SimpleFutureBuilder<T> extends StatefulWidget {
  const SimpleFutureBuilder({
    super.key,
    this.initialData,
    this.future,
    required this.onLoaded,
    this.onError,
    this.onLoading
  });

  final Future<T?>? future;
  final Widget Function()? onLoading;
  final Widget Function(T instance) onLoaded;
  final Widget Function(String error)? onError;
  final T? initialData;

  @override
  State<SimpleFutureBuilder<T>> createState() => _SimpleFutureBuilderState<T>();
}

class _SimpleFutureBuilderState<T> extends State<SimpleFutureBuilder<T>> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: widget.future,
        initialData: widget.initialData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return widget.onLoaded(snapshot.data as T);
          } else if (snapshot.hasError) {
            return Center(
                child: widget.onError?.call(snapshot.error.toString()) ??
                    Text(snapshot.error.toString()));
          } else {
            return widget.onLoading?.call() ??
                const Center(
                  child: CircularProgressIndicator(),
                );
          }
        });
  }
}
