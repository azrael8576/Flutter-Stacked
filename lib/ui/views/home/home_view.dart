import 'package:flutter/material.dart';
import 'package:flutterstacked/ui/shared/app_colors.dart';
import 'package:flutterstacked/ui/widgets/custom_drawer_widget.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: CustomDrawerWidget(
          drawerWidget: _MyDrawer(),
          childWidget: _MyChild(),
        ),
        floatingActionButton: FloatingActionButton(onPressed: null),
      ),
      viewModelBuilder: () => HomeViewModel(),
    );
  }
}

class _MyDrawer extends ViewModelWidget<HomeViewModel> {
  const _MyDrawer([Key key]) : super(key: key, reactive: true);

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return Stack(
      children: <Widget>[
        Container(
          color: AppColors.red,
        ),
        Container(
          color: AppColors.mediumBlue,
          width: 225.0,
        ),
      ],
    );
  }
}

class _MyChild extends ViewModelWidget<HomeViewModel> {
  const _MyChild([Key key]) : super(key: key, reactive: true);

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return Container(
      color: AppColors.white,
      child: Center(
        child: Text(
          '${viewModel.title} \n Tap Me!! \n Drag Me!!',
          style: TextStyle(fontSize: 50.0, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
