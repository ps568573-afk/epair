/// App view enum for admin navigation
enum AppView {
  dashboard,
  users,
  providers,
  services,
  bookings,
  payments,
  analytics,
  reviews,
  promotions,
  support,
  settings,
}

/// App mode: Customer, Admin, or Partner (technician)
enum AppMode {
  admin,
  customer,
  partner,
}

class User {
  final String id;
  final String name;
  final String email;
  final String role; // customer | provider | admin
  final String status; // active | inactive | pending
  final String joinedDate;
  final int totalBookings;
  final String? avatar;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.status,
    required this.joinedDate,
    required this.totalBookings,
    this.avatar,
  });
}

class Category {
  final String id;
  final String name;
  final String icon; // Material icon name or code

  Category({required this.id, required this.name, required this.icon});
}

class Service {
  final String id;
  final String name;
  final String categoryId;
  final double basePrice;
  final String status; // active | draft
  final String description;

  Service({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.basePrice,
    required this.status,
    required this.description,
  });

  Service copyWith({
    String? id,
    String? name,
    String? categoryId,
    double? basePrice,
    String? status,
    String? description,
  }) {
    return Service(
      id: id ?? this.id,
      name: name ?? this.name,
      categoryId: categoryId ?? this.categoryId,
      basePrice: basePrice ?? this.basePrice,
      status: status ?? this.status,
      description: description ?? this.description,
    );
  }
}

class Booking {
  final String id;
  final String customerName;
  final String providerName;
  final String serviceName;
  final String date;
  final double amount;
  final String status; // pending | accepted | in-progress | completed | cancelled

  Booking({
    required this.id,
    required this.customerName,
    required this.providerName,
    required this.serviceName,
    required this.date,
    required this.amount,
    required this.status,
  });

  Booking copyWith({String? status}) {
    return Booking(
      id: id,
      customerName: customerName,
      providerName: providerName,
      serviceName: serviceName,
      date: date,
      amount: amount,
      status: status ?? this.status,
    );
  }
}

class Review {
  final String id;
  final String customerName;
  final String providerName;
  final String serviceName;
  final int rating;
  final String comment;
  final String date;

  Review({
    required this.id,
    required this.customerName,
    required this.providerName,
    required this.serviceName,
    required this.rating,
    required this.comment,
    required this.date,
  });
}

class Promotion {
  final String id;
  final String code;
  final String discount;
  final String type; // percentage | fixed
  final String expiry;
  final String status; // active | expired | scheduled
  final int usageCount;

  Promotion({
    required this.id,
    required this.code,
    required this.discount,
    required this.type,
    required this.expiry,
    required this.status,
    required this.usageCount,
  });
}

class SupportTicket {
  final String id;
  final String user;
  final String subject;
  final String priority; // low | medium | high
  final String status; // open | pending | resolved
  final String date;

  SupportTicket({
    required this.id,
    required this.user,
    required this.subject,
    required this.priority,
    required this.status,
    required this.date,
  });
}

class Transaction {
  final String id;
  final String customer;
  final String technician;
  final double amount;
  final String status; // succeeded | pending | failed | refunded
  final String payoutStatus; // paid | unpaid
  final String date;
  final String method;

  Transaction({
    required this.id,
    required this.customer,
    required this.technician,
    required this.amount,
    required this.status,
    required this.payoutStatus,
    required this.date,
    required this.method,
  });
}

class RevenueDataPoint {
  final String name;
  final double revenue;
  final int bookings;

  RevenueDataPoint({
    required this.name,
    required this.revenue,
    required this.bookings,
  });
}
