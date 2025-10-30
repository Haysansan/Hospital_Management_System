class Person {
  final int id;
  final String name;
  final int age;
  final String gender;
  final String contactNumber;

  Person({
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
    required this.contactNumber,
  });
}

class Doctor extends Person {
  final String specialization;
  final List<Prescription> prescriptions;
  final List<Appointment> appointments;

  Doctor(
    this.specialization,
    this.appointments,
    this.prescriptions, {
    required int id,
    required String name,
    required int age,
    required String gender,
    required String contactNumber,
  }) : super(
          id: id,
          name: name,
          age: age,
          gender: gender,
          contactNumber: contactNumber,
        );
  // ---- Operations ---- //
  void addAppointment(Appointment appointment) {
    appointments.add(appointment);
  }

  void removeAppointment(int appointmentId) {
    appointments.removeWhere((appointment) => appointment.id == appointmentId);
  }

  void viewPrescriptions() {
    for (final prescription in prescriptions) {
      print('Prescription ${prescription.id}: '
          '${prescription.medication} | Dosage: ${prescription.dosage} | '
          'Instruction: ${prescription.instruction}');
    }
  }
}

class Patient extends Person {
  final String medicalHistory;
  final List<Prescription> prescriptions;
  final List<Appointment> appointments;

  Patient(
    this.prescriptions,
    this.appointments,
    this.medicalHistory, {
    required int id,
    required String name,
    required int age,
    required String gender,
    required String contactNumber,
  }) : super(
          id: id,
          name: name,
          age: age,
          gender: gender,
          contactNumber: contactNumber,
        );
  // ---- Operations ---- //
  void addPrescription(Prescription prescription) {
    prescriptions.add(prescription);
  }

  void viewAppointments() {
    for (final appointment in appointments) {
      print('Appointment ${appointment.id}: '
          '${appointment.date} | Room ${appointment.roomNumber} | '
          'Status: ${appointment.status} | Priority: ${appointment.priority}');
    }
  }
}

class Prescription {
  final int id;
  final String medication;
  final String dosage;
  final String instruction;

  Prescription({
    required this.id,
    required this.dosage,
    required this.medication,
    required this.instruction,
  });
}

class Appointment {
  final int id;
  final DateTime date;
  final String status;
  final int roomNumber;
  final String priority;

  Appointment({
    required this.id,
    required this.date,
    required this.status,
    required this.roomNumber,
    required this.priority,
  });
}

class Schedule {
  final String workingHours;
  final List<Appointment> appointments;
  Schedule({
    required this.workingHours,
    required this.appointments,
  });
}
