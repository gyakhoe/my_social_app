import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_social_app/conversation/bloc/conversation_bloc.dart';
import 'package:my_social_app/conversation/ui/conversation_list_widget.dart';

class ConversationBuilderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConversationBloc, ConversationState>(
      builder: _mapStateToWidget,
    );
  }

  Widget _mapStateToWidget(context, state) {
    if (state is ConversationLoadingInprogress) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    if (state is ConversationLoadingFailure) {
      return Center(
        child: Text(state.failureMessage),
      );
    }

    if (state is ConversationLoadingSuccess) {
      return ConversationListWidget(
        conversations: state.conversations,
      );
    }
    BlocProvider.of<ConversationBloc>(context).add(
      ConverstationListRequested(),
    );
    return Container();
  }
}
