import 'package:flutter/material.dart';
import 'package:flutterstacked/logger.dart';
import 'package:flutterstacked/ui/shared/app_colors.dart';
import 'package:flutterstacked/ui/widgets/custom_drawer_flip_scaffold.dart';
import 'package:stacked/stacked.dart';

import 'demo_viewmodel.dart';

final log = getLogger('DemoView');
bool _isButtonTapped = false;

class DemoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DemoViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: CustomDrawerFlipScaffold(
          drawerWidget: _MyDrawer(),
          childWidget: _MyChild(),
        ),
        floatingActionButton: FloatingActionButton(onPressed: null),
      ),
      viewModelBuilder: () => DemoViewModel(),
    );
  }
}

class _MyDrawer extends ViewModelWidget<DemoViewModel> {
  const _MyDrawer([Key key]) : super(key: key, reactive: true);

  @override
  Widget build(BuildContext context, DemoViewModel viewModel) {
    return SizedBox(
      width: 300,
      height: double.infinity,
      child: Material(
        color: AppColors.mediumBlue,
        child: SafeArea(
          child: Theme(
            data: ThemeData(brightness: Brightness.dark),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    '_MyDrawer',
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.w400,
                      color: AppColors.white,
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.new_releases),
                  title: Text('News'),
                ),
                ListTile(
                  leading: Icon(Icons.star),
                  title: Text('Favourites'),
                ),
                ListTile(
                  leading: Icon(Icons.map),
                  title: Text('Map'),
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                ),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Profile'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MyChild extends ViewModelWidget<DemoViewModel> {
  const _MyChild([Key key]) : super(key: key, reactive: true);

  @override
  Widget build(BuildContext context, DemoViewModel viewModel) {
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
