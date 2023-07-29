import 'package:bloc/bloc.dart';
import 'package:naseeb/domain/models/about_user_model.dart';
import 'package:naseeb/domain/repositories/user_repo/user_repo.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<GetUserDataEvent>((event, emit) async {
      try {
        emit(UserLoading());
        final user = await UserRepo().aboutUser();
        emit(UserLoaded(user));
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });
  }
}
