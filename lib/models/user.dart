enum UserRole { student, teacher }

class AppUser {
  final String fullName;
  final String email;
  final String phone;
  final String school;
  final UserRole role;
  final bool teacherRequestPending;
  final bool teacherAccessApproved;

  AppUser({
    required this.fullName,
    required this.email,
    required this.phone,
    this.school = '',
    this.role = UserRole.student,
    this.teacherRequestPending = false,
    this.teacherAccessApproved = false,
  });

  AppUser copyWith({
    String? fullName,
    String? email,
    String? phone,
    String? school,
    UserRole? role,
    bool? teacherRequestPending,
    bool? teacherAccessApproved,
  }) {
    return AppUser(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      school: school ?? this.school,
      role: role ?? this.role,
      teacherRequestPending: teacherRequestPending ?? this.teacherRequestPending,
      teacherAccessApproved: teacherAccessApproved ?? this.teacherAccessApproved,
    );
  }

  String get roleLabel => role == UserRole.teacher ? 'Professeur' : 'Élève';

  bool get canRequestTeacherAccess =>
      role == UserRole.student && !teacherRequestPending && !teacherAccessApproved;

  bool get canActivateTeacherMode =>
      teacherAccessApproved && role == UserRole.student;
}
