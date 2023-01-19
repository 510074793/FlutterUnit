import 'package:app_config/app_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:old_fancy_mobile_ui/old_fancy_mobile_ui.dart';
import 'package:widget_repository/widget_repository.dart';

import '../../widget_ui/mobile/widget_panel/widget_model_item.dart';

class PhoneWidgetContent extends StatelessWidget {
  final List<WidgetModel> items;

  const PhoneWidgetContent({Key? key,required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppStyle style = context.read<AppBloc>().state.appStyle;
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (_, int index) => _buildHomeItem(context, items[index], style),
        childCount: items.length,
      ),
    );
  }

  Widget _buildHomeItem(
      BuildContext context, WidgetModel model, AppStyle style) {
    switch (style) {
      case AppStyle.standard:
        return StandardWidgetItem(
          model: model,
          onTap: () => _toDetail(context, model),
        );
      case AppStyle.fancy:
        return BlocBuilder<AppBloc, AppState>(
          buildWhen: (p, c) => (p.itemStyleIndex != c.itemStyleIndex),
          builder: (context, state) {
            int index = state.itemStyleIndex;
            ShapeBorder? shapeBorder = HomeItemSupport.shapeBorderMap[index];
            return Padding(
              padding: const EdgeInsets.only(
                  bottom: 10, top: 2, left: 10, right: 10),
              child: InkWell(
                  customBorder: shapeBorder,
                  onTap: () => _toDetail(context, model),
                  child: HomeItemSupport.get(model, index)),
            );
          },
        );
    }
  }

  void _toDetail(BuildContext context, WidgetModel model) {
    Navigator.pushNamed(
      context,
      UnitRouter.widget_detail,
      arguments: model,
    );
  }
}
