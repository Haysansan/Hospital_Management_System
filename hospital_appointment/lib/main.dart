import 'domain/domain.dart';
import 'data/appointment_repository.dart';
import 'ui/console.dart';

void main() {
  HospitalManagement hospital = HospitalManagement();
  AppointmentRepository repo = AppointmentRepository();

  ConsoleUI console = ConsoleUI(hospital: hospital, repo: repo);

  console.start();
}
