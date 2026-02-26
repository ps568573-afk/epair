# ePair Flutter App (epairsuyash)

Flutter conversion of the ePair electronics repair web app. All features from the React web app are included.

## Features

- **Customer app**: Home (categories, services, booking), AI Diagnosis (Gemini), Active Bookings, History, Profile. Switch to Technician or Admin from Profile.
- **Partner (Technician) panel**: Weekly revenue chart, active jobs, online/offline toggle, accept/update status.
- **Admin dashboard**: Sidebar navigation, Dashboard (KPIs, revenue chart, AI business insights), Customers, Technicians, Repair Catalog (categories & services), Booking Ledger, Analytics, Reviews, Promotions, Support Helpdesk, Financial Ledger, Settings (brand, operations, integrations).

## Run

```bash
cd epairsuyash
flutter pub get
flutter run
```

For web: `flutter run -d chrome`  
For a specific device: `flutter run -d <device_id>`

## AI (Gemini) setup

To use AI Diagnosis (customer) and AI Business Insights (admin), set your Gemini API key:

- In code: `GeminiService.apiKey = 'YOUR_API_KEY';` before calling any Gemini methods (e.g. in `main()`).
- Or use your preferred way to load from env/secure storage and assign to `GeminiService.apiKey`.

Without a key, the app still runs; AI features show a short “unavailable” message.

## Project structure

- `lib/core/` – models, theme (app_colors, app_theme), mock_data  
- `lib/features/customer/` – customer app and tabs (home, AI diagnosis, bookings, history, profile, confirm booking)  
- `lib/features/partner/` – partner panel (revenue chart, tasks)  
- `lib/features/admin/` – sidebar, header, dashboard, and all management screens  
- `lib/services/` – GeminiService for AI  
- `lib/main.dart` – app entry and mode switching (Customer / Partner / Admin)
