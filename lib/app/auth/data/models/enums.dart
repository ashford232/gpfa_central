enum Role { superadmin, admin, staff, unverified, rejected }

Role getRole(String role) {
  return Role.values.firstWhere((r) => r.name == role, orElse: () => .staff,);
}
