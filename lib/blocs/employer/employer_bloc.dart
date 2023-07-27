import 'package:bloc/bloc.dart';
import 'package:naseeb/domain/models/get_employee_detail_model.dart';
import 'package:naseeb/domain/models/get_employee_model.dart';
import 'package:naseeb/domain/repositories/employer_repo/employer_repo.dart';

part 'employer_event.dart';
part 'employer_state.dart';

class EmployerBloc extends Bloc<EmployerEvent, EmployerState> {
  EmployerBloc() : super(EmployerInitial()) {
    EmployerRepo repositories = EmployerRepo();
    on<GetEmployees>((event, emit) async {
      final getEmployees =
          await repositories.getEmployees(event.id, event.radius);
      try {
        emit(EmployerLoading());
        emit(EmployerLoaded(getEmployees));
      } catch (e) {
        emit(
          EmployerError(e.toString()),
        );
      }
    });

    on<GetEmployeeById>((event, emit) async {
      final getEmployee = await repositories.getEmployeeDetail(event.id);
      try {
        emit(EmployerLoading());
        emit(EmployeeDetailLoaded(getEmployee));
      } catch (e) {
        emit(
          EmployerError(e.toString()),
        );
      }
    });
  }
}
