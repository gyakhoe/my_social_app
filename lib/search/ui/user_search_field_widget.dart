import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_social_app/search/bloc/search_bloc.dart';

class UserSearchFieldWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          if (state is SearchTextEntering) {
            return _buildSearchTextField(Icons.close, context);
          } else if (state is SearchTextEntered) {
            return _buildSearchTextField(Icons.close, context);
          } else {
            return _buildSearchTextField(Icons.search, context);
          }
        },
      ),
    );
  }
}

Widget _buildSearchTextField(IconData icon, BuildContext context) {
  return Row(
    children: <Widget>[
      Expanded(
        flex: 9,
        child: TextField(
            onTap: () =>
                BlocProvider.of<SearchBloc>(context).add(SearchSelected()),
            onSubmitted: (value) => BlocProvider.of<SearchBloc>(context)
                .add(SearchTextEntered(value)),
            decoration: InputDecoration(
              hintText: 'Type username here.',
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
            )),
      ),
      Expanded(
          flex: 1,
          child: SearchIconButton(
            icon: icon,
          )),
    ],
  );
}

class SearchIconButton extends StatelessWidget {
  final IconData icon;

  const SearchIconButton({Key key, this.icon}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(icon),
        onPressed: () {
          FocusNode currentFocus = FocusScope.of(context);
          currentFocus.unfocus();
          BlocProvider.of<SearchBloc>(context).add(SearchCancelled());
        });
  }
}
