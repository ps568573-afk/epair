import '../models/models.dart';

class MockData {
  MockData._();

  static final List<User> users = [
    User(
      id: '1',
      name: 'John Doe',
      email: 'john@example.com',
      role: 'customer',
      status: 'active',
      joinedDate: '2023-10-15',
      totalBookings: 12,
      avatar: 'https://picsum.photos/seed/john/100/100',
    ),
    User(
      id: '2',
      name: 'Jane Smith',
      email: 'jane@repair.com',
      role: 'provider',
      status: 'active',
      joinedDate: '2023-09-20',
      totalBookings: 45,
      avatar: 'https://picsum.photos/seed/jane/100/100',
    ),
    User(
      id: '3',
      name: 'Mike Ross',
      email: 'mike@law.com',
      role: 'customer',
      status: 'inactive',
      joinedDate: '2023-11-02',
      totalBookings: 0,
      avatar: 'https://picsum.photos/seed/mike/100/100',
    ),
    User(
      id: '4',
      name: 'Alice Wong',
      email: 'alice@epair.com',
      role: 'provider',
      status: 'pending',
      joinedDate: '2024-01-10',
      totalBookings: 0,
      avatar: 'https://picsum.photos/seed/alice/100/100',
    ),
  ];

  static final List<Category> categories = [
    Category(id: 'cat1', name: 'Smartphones', icon: 'smartphone'),
    Category(id: 'cat2', name: 'Laptops', icon: 'laptop'),
    Category(id: 'cat3', name: 'Gaming', icon: 'sports_esports'),
    Category(id: 'cat4', name: 'Appliances', icon: 'electrical_services'),
  ];

  static final List<Service> services = [
    Service(
      id: 's1',
      name: 'iPhone Screen Repair',
      categoryId: 'cat1',
      basePrice: 89,
      status: 'active',
      description: 'Cracked screen replacement for all iPhone models.',
    ),
    Service(
      id: 's2',
      name: 'MacBook Battery replacement',
      categoryId: 'cat2',
      basePrice: 129,
      status: 'active',
      description: 'Original battery replacement with 6-month warranty.',
    ),
    Service(
      id: 's3',
      name: 'PS5 HDMI Port Fix',
      categoryId: 'cat3',
      basePrice: 75,
      status: 'active',
      description: 'Quick soldering fix for broken HDMI ports.',
    ),
    Service(
      id: 's4',
      name: 'Android Charging Port',
      categoryId: 'cat1',
      basePrice: 45,
      status: 'active',
      description: 'Fix for loose or non-responsive charging ports.',
    ),
    Service(
      id: 's5',
      name: 'Laptop Deep Clean',
      categoryId: 'cat2',
      basePrice: 40,
      status: 'active',
      description: 'Dust removal and thermal paste re-application.',
    ),
  ];

  static final List<Booking> bookings = [
    Booking(
      id: 'B001',
      customerName: 'John Doe',
      providerName: 'Jane Smith',
      serviceName: 'iPhone Screen Repair',
      date: '2024-01-20',
      amount: 89,
      status: 'completed',
    ),
    Booking(
      id: 'B002',
      customerName: 'Mike Ross',
      providerName: 'Jane Smith',
      serviceName: 'PS5 HDMI Port Fix',
      date: '2024-01-22',
      amount: 75,
      status: 'in-progress',
    ),
    Booking(
      id: 'B003',
      customerName: 'Sarah Connor',
      providerName: 'Bob Repair',
      serviceName: 'Laptop Deep Clean',
      date: '2024-01-23',
      amount: 40,
      status: 'pending',
    ),
  ];

  static final List<Review> reviews = [
    Review(
      id: 'R1',
      customerName: 'John Doe',
      providerName: 'Jane Smith',
      serviceName: 'iPhone Screen Repair',
      rating: 5,
      comment: 'Fast and fair! My phone looks brand new.',
      date: '2024-01-21',
    ),
    Review(
      id: 'R2',
      customerName: 'Sarah Connor',
      providerName: 'Bob Repair',
      serviceName: 'Laptop Deep Clean',
      rating: 4,
      comment: 'Good service, technician was very professional.',
      date: '2024-01-19',
    ),
  ];

  static final List<Promotion> promotions = [
    Promotion(
      id: 'P1',
      code: 'EPAIRNEW',
      discount: '15%',
      type: 'percentage',
      expiry: '2024-12-31',
      status: 'active',
      usageCount: 200,
    ),
    Promotion(
      id: 'P2',
      code: 'SCREENFIX',
      discount: '\$10',
      type: 'fixed',
      expiry: '2024-08-30',
      status: 'scheduled',
      usageCount: 0,
    ),
  ];

  static final List<SupportTicket> tickets = [
    SupportTicket(
      id: 'T101',
      user: 'John Doe',
      subject: 'Warranty Claim',
      priority: 'high',
      status: 'open',
      date: '2024-01-24',
    ),
  ];

  static final List<RevenueDataPoint> revenueData = [
    RevenueDataPoint(name: 'Mon', revenue: 1200, bookings: 12),
    RevenueDataPoint(name: 'Tue', revenue: 1500, bookings: 15),
    RevenueDataPoint(name: 'Wed', revenue: 900, bookings: 8),
    RevenueDataPoint(name: 'Thu', revenue: 2100, bookings: 22),
    RevenueDataPoint(name: 'Fri', revenue: 2500, bookings: 28),
    RevenueDataPoint(name: 'Sat', revenue: 3200, bookings: 35),
    RevenueDataPoint(name: 'Sun', revenue: 1800, bookings: 18),
  ];

  static final List<Transaction> transactions = [
    Transaction(
      id: 'TXN-9082',
      customer: 'John Doe',
      technician: 'Jane Smith',
      amount: 89.00,
      status: 'succeeded',
      payoutStatus: 'paid',
      date: '2024-01-24 10:15',
      method: 'Visa ****4242',
    ),
    Transaction(
      id: 'TXN-9083',
      customer: 'Mike Ross',
      technician: 'Jane Smith',
      amount: 75.00,
      status: 'pending',
      payoutStatus: 'unpaid',
      date: '2024-01-24 11:30',
      method: 'Apple Pay',
    ),
    Transaction(
      id: 'TXN-9084',
      customer: 'Sarah Connor',
      technician: 'Bob Repair',
      amount: 40.00,
      status: 'succeeded',
      payoutStatus: 'unpaid',
      date: '2024-01-23 14:45',
      method: 'Mastercard ****8811',
    ),
    Transaction(
      id: 'TXN-9085',
      customer: 'Alex Murphy',
      technician: 'Jane Smith',
      amount: 129.00,
      status: 'failed',
      payoutStatus: 'unpaid',
      date: '2024-01-23 09:20',
      method: 'Google Pay',
    ),
  ];
}
