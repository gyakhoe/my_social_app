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
            return UserSearchTextField(icon: Icons.close);
          } else if (state is SearchTextEntered) {
            return UserSearchTextField(icon: Icons.close);
          } else {
            return UserSearchTextField(icon: Icons.search);
          }
        },
      ),
    );
  }
}

class UserSearchTextField extends StatefulWidget {
  final IconData icon;
  UserSearchTextField({
    Key key,
    this.icon,
  }) : super(key: key);

  @override
  _UserSearchTextFieldState createState() => _UserSearchTextFieldState();
}

class _UserSearchTextFieldState extends State<UserSearchTextField> {
  TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 9,
          child: TextField(
              controller: textEditingController,
              onTap: () =>
                  BlocProvider.of<SearchBloc>(context).add(SearchSelected()),
              onChanged: (value) {
                BlocProvider.of<SearchBloc>(context)
                    .add(SearchTextEntered(value));
              },
              onSubmitted: (value) {
                FocusScope.of(context).unfocus();
                textEditingController.clear();
                BlocProvider.of<SearchBloc>(context).add(SearchCancelled());
              },
              autocorrect: false,
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
              icon: widget.icon,
            )),
      ],
    );
  }
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
