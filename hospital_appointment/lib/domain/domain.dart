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

  String getInfo() {
    return '$name, $age years old, ($gender) - Contact: $contactNumber';
  }
}

class Doctor extends Person {
  final String specialization;
  Schedules? schedules;

  Doctor({
    required super.id,
    required super.name,
    required super.age,
    required super.gender,
    required super.contactNumber,
    required this.specialization,
    this.schedules,
  });
}

class Patient extends Person {
  final String medicalHistory;

  Patient({
    required super.id,
    required super.name,
    required super.age,
    required super.gender,
    required super.contactNumber,
    required this.medicalHistory,
  });
}

class Prescription {
  final int id;
  final Doctor doctor;
  final Patient patient;
  final String medication;
  final String dosage;
  final String instruction;

  Prescription({
    required this.id,
    required this.doctor,
    required this.patient,
    required this.medication,
    required this.dosage,
    required this.instruction,
  });

  bool validate() {
    return medication.isNotEmpty && dosage.isNotEmpty && instruction.isNotEmpty;
  }
}

class Appointment {
  final int id;
  final Doctor doctor;
  final Patient patient;
  final DateTime date;
  final String status;

  Appointment({
    required this.id,
    required this.doctor,
    required this.patient,
    required this.date,
    this.status = 'Scheduled',
  });

  void schedules() {
    // In real logic, this could notify patients
  }
}

class Schedules {
  final int id;
  Doctor? doctor;
  List<Appointment> appointments = [];

  Schedules({
    required this.id,
    this.doctor,
  });

  void addAppointment(Appointment a) => appointments.add(a);
  void removeAppointment(Appointment a) => appointments.remove(a);
}

class HospitalManagement {
  final List<Doctor> doctors = [];
  final List<Patient> patients = [];
  final List<Appointment> appointments = [];
  final List<Prescription> prescriptions = [];
  final List<Schedules> schedules = [];

  void addDoctor(Doctor doctor) => doctors.add(doctor);
  void addPatient(Patient patient) => patients.add(patient);

  void assignSchedule(Doctor doctor, Schedules schedule) {
    doctor.schedules = schedule;
    schedule.doctor = doctor;
    schedules.add(schedule);
  }

  void scheduleAppointment(Doctor doctor, Patient patient, DateTime date) {
    final appointment = Appointment(
      id: appointments.length + 1,
      doctor: doctor,
      patient: patient,
      date: date,
    );
    appointments.add(appointment);
    doctor.schedules?.addAppointment(appointment);
  }

  void issuePrescription(
    Doctor doctor,
    Patient patient,
    String medication,
    String dosage,
    String instruction,
  ) {
    final prescription = Prescription(
      id: prescriptions.length + 1,
      doctor: doctor,
      patient: patient,
      medication: medication,
      dosage: dosage,
      instruction: instruction,
    );
    prescriptions.add(prescription);
  }

  String viewSchedule(Doctor doctor) {
    if (doctor.schedules == null || doctor.schedules!.appointments.isEmpty) {
      return '${doctor.name} has no scheduled appointments.';
    }
    final items = doctor.schedules!.appointments
        .map((a) =>
            'Appointment ${a.id}: ${a.patient.name} on ${a.date.toString()}')
        .join('\n');
    return 'Schedule for Dr. ${doctor.name}:\n$items';
  }
}
