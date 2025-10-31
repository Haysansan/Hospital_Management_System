import 'dart:convert';
import 'dart:io';
import '../domain/domain.dart';

class AppointmentRepository {
  final String filePath;

  AppointmentRepository({this.filePath = 'appointments.json'});

  void save(List<Appointment> appointments) {
    final data = appointments.map((a) => _appointmentToJson(a)).toList();
    final jsonString = jsonEncode(data);
    File(filePath).writeAsStringSync(jsonString);
  }

  List<Appointment> load(List<Doctor> doctors, List<Patient> patients) {
    final file = File(filePath);
    if (!file.existsSync()) return [];

    final content = file.readAsStringSync();
    final decoded = jsonDecode(content) as List;
    return decoded
        .map((json) => _appointmentFromJson(json, doctors, patients))
        .toList();
  }

  Map<String, dynamic> _appointmentToJson(Appointment a) {
    return {
      'id': a.id,
      'doctorId': a.doctor.id,
      'patientId': a.patient.id,
      'date': a.date.toIso8601String(),
      'status': a.status,
    };
  }

  Appointment _appointmentFromJson(
    Map<String, dynamic> json,
    List<Doctor> doctors,
    List<Patient> patients,
  ) {
    final doctor = doctors.firstWhere((d) => d.id == json['doctorId']);
    final patient = patients.firstWhere((p) => p.id == json['patientId']);

    return Appointment(
      id: json['id'],
      doctor: doctor,
      patient: patient,
      date: DateTime.parse(json['date']),
      status: json['status'] ?? 'Scheduled',
    );
  }
}
