import 'package:cw_weather/src/core/widgets/failure_widget.dart';
import 'package:cw_weather/src/core/widgets/no_data_widget.dart';
import 'package:cw_weather/src/core/widgets/text/text_title.dart';
import 'package:cw_weather/src/weather_module/pages/cities/view/widgets/city_list_widget.dart';
import 'package:cw_weather/src/weather_module/pages/cities/view/widgets/search_field_widget.dart';
import 'package:flutter/material.dart';

import 'package:cw_weather/src/weather_module/pages/cities/view_models/cities_view_model.dart';

class CitiesPage extends StatefulWidget {
  final CitiesViewModel viewModel;

  const CitiesPage({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  @override
  State<CitiesPage> createState() => _CitiesPageState();
}

class _CitiesPageState extends State<CitiesPage> {
  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: widget.viewModel.showSearchBar,
      builder: (context, showSearchBar, body) {
        return Scaffold(
          appBar: AppBar(
            title: showSearchBar
                ? SearchFieldWidget(onSubmitted: widget.viewModel.onSearch)
                : const TextTitle(text: 'Cities'),
            actions: [
              IconButton(
                  onPressed: widget.viewModel.triggerSearchBar,
                  icon: Icon(showSearchBar ? Icons.close : Icons.search))
            ],
          ),
          body: body,
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, top: 8.0, right: 16.0),
        child: AnimatedBuilder(
            animation: Listenable.merge([
              widget.viewModel.citiesNotifier,
              widget.viewModel.errorNotifier
            ]),
            builder: (context, _) {
              var cities = widget.viewModel.citiesNotifier.value;
              var error = widget.viewModel.errorNotifier.value;

              if (error != null) {
                return Center(
                  child: FailureWidget(text: error.message),
                );
              } else if (cities == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (cities.isEmpty) {
                return const NoDataWidget();
              } else if (cities.isNotEmpty) {
                return CityListWidget(cities: cities);
              }
              return const SizedBox.shrink();
            }),
      ),
    );
  }
}
