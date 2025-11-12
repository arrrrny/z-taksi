# Z-Taksi App Flow & Screens

## 🚀 Application Flow

```
┌─────────────────┐
│  Splash Screen  │
│   (Loading...)  │
└────────┬────────┘
         │
    Check Auth
         │
    ┌────┴────┐
    │         │
   Yes       No
    │         │
    │    ┌────────────┐
    │    │   Login    │
    │    │   Screen   │
    │    └─────┬──────┘
    │          │
    │     ┌────┴────┐
    │    Sign Up    │
    │    │         │
    └────┴─────────┴───┐
                       │
                  ┌────▼────┐
                  │  Home   │
                  │ Screen  │
                  └────┬────┘
                       │
              ┌────────┴────────┐
              │                 │
        Passenger          Driver
         Mode              Mode
              │                 │
    ┌─────────┴─────┐    ┌──────┴──────┐
    │               │    │             │
  Book         View     Toggle      View
  Ride        History  Online/    History
    │               │   Offline       │
    │               │      │          │
    └───────┬───────┘      │          │
            │              │          │
    ┌───────▼──────┐   ┌───▼──────┐  │
    │ Ride Booking │   │  Active  │  │
    │   Screen     │   │   Ride   │  │
    └──────────────┘   └──────────┘  │
                                     │
                    ┌────────────────┴┐
                    │   Profile       │
                    │   Screen        │
                    └─────────────────┘
```

## 📱 Screen Breakdown

### 1. Splash Screen
**Purpose**: Initial loading and authentication check
**Features**:
- App logo and name display
- Loading indicator
- Auto-navigation to Login or Home

**User Flow**:
```
App Launch → Check Auth → 
  If Authenticated → Home Screen
  If Not Authenticated → Login Screen
```

---

### 2. Login Screen
**Purpose**: User authentication
**Features**:
- Email input field
- Password input field (with show/hide toggle)
- Login button
- Sign up navigation link
- Form validation
- Error handling

**User Actions**:
- Enter credentials
- Toggle password visibility
- Submit login
- Navigate to sign up

---

### 3. Sign Up Screen
**Purpose**: New user registration
**Features**:
- Full name input
- Email input
- Phone number input
- Password input (with show/hide toggle)
- Role selection (Passenger/Driver radio buttons)
- Sign up button
- Form validation

**User Actions**:
- Enter personal information
- Select role (Passenger or Driver)
- Submit registration
- Return to login

---

### 4. Home Screen (Container)
**Purpose**: Main navigation container
**Features**:
- Bottom navigation bar
- Role-based content switching
- Tab navigation (Home, Profile)

**Content**:
- Tab 1: Passenger Home OR Driver Home
- Tab 2: Profile Screen

---

### 5a. Passenger Home Screen
**Purpose**: Main interface for passengers
**Features**:
- Map view placeholder (ready for Google Maps)
- Current location display
- "Book a Ride" button
- Current ride status (if active)
- Update location button
- Quick access to ride history

**User Actions**:
- View current location on map
- Book a new ride
- View current ride status
- Update GPS location
- Access ride history

**Visual Layout**:
```
┌─────────────────────────────┐
│    App Bar (Z-Taksi)        │
│         [History Icon]       │
├─────────────────────────────┤
│                             │
│        MAP VIEW             │
│     (Google Maps)           │
│                             │
│   📍 Your Location          │
│                             │
├─────────────────────────────┤
│  Hello, [Name]!             │
│  Where would you like to go?│
│                             │
│  ┌───────────────────────┐  │
│  │  🚖 Book a Ride       │  │
│  └───────────────────────┘  │
│                             │
│  ┌───────────────────────┐  │
│  │  📍 Update Location   │  │
│  └───────────────────────┘  │
└─────────────────────────────┘
```

---

### 5b. Driver Home Screen
**Purpose**: Main interface for drivers
**Features**:
- Map view placeholder
- Online/Offline toggle switch
- Driver status display
- Active ride information
- Ride request notifications area
- Access to ride history

**User Actions**:
- Toggle online/offline status
- View active rides
- Accept ride requests
- Update ride status
- View passenger information
- Navigate to pickup/destination

**Visual Layout**:
```
┌─────────────────────────────┐
│  App Bar (Z-Taksi Driver)   │
│         [History Icon]       │
├─────────────────────────────┤
│                             │
│        MAP VIEW             │
│     (Driver Location)        │
│                             │
├─────────────────────────────┤
│  Driver Mode    [🔘 Toggle] │
│  You are online/offline     │
│                             │
│  ┌───────────────────────┐  │
│  │   Active Ride          │  │
│  │   👤 Passenger         │  │
│  │   📍 Pickup            │  │
│  │   🏁 Destination       │  │
│  │   [Action Button]      │  │
│  └───────────────────────┘  │
└─────────────────────────────┘
```

---

### 6. Ride Booking Screen
**Purpose**: Book a new ride
**Features**:
- Map preview
- Pickup location input (auto-filled from GPS)
- Destination input with search
- Fare estimation card
- Distance display
- Confirm booking button
- Fare breakdown (base fare, distance, time)

**User Actions**:
- View/edit pickup location
- Enter destination
- View estimated fare
- Confirm booking

**Visual Layout**:
```
┌─────────────────────────────┐
│  ← Book a Ride              │
├─────────────────────────────┤
│  ┌───────────────────────┐  │
│  │                       │  │
│  │   Map Preview         │  │
│  │                       │  │
│  └───────────────────────┘  │
│                             │
│  📍 Pickup Location         │
│  [123 Main St          🔍]  │
│                             │
│  🏁 Destination             │
│  [Enter destination    🔍]  │
│                             │
│  ┌───────────────────────┐  │
│  │ Estimated Fare  $15.50│  │
│  │ Distance: 5.0 km      │  │
│  │ Base Fare: $2.50      │  │
│  └───────────────────────┘  │
│                             │
│  [   Confirm Booking   ]    │
└─────────────────────────────┘
```

---

### 7. Ride History Screen
**Purpose**: View past rides
**Features**:
- List of all completed/cancelled rides
- Ride status indicators
- Date and time display
- Fare information
- Pickup and destination addresses
- Pull-to-refresh
- Detailed ride view (bottom sheet)

**User Actions**:
- Scroll through ride history
- Tap ride for details
- Pull to refresh
- View ride breakdown

**Visual Layout**:
```
┌─────────────────────────────┐
│  ← Ride History             │
├─────────────────────────────┤
│  ┌───────────────────────┐  │
│  │ 📍 456 Park Ave       │  │
│  │ From: 123 Main St     │  │
│  │ Dec 15, 2024 - 2:30 PM│  │
│  │                 $15.50│  │
│  │            COMPLETED   │  │
│  └───────────────────────┘  │
│                             │
│  ┌───────────────────────┐  │
│  │ 📍 789 Oak Blvd       │  │
│  │ From: 456 Park Ave    │  │
│  │ Dec 14, 2024 - 5:15 PM│  │
│  │                 $22.00│  │
│  │            COMPLETED   │  │
│  └───────────────────────┘  │
│                             │
│  ┌───────────────────────┐  │
│  │ 📍 321 Elm St         │  │
│  │ From: 789 Oak Blvd    │  │
│  │ Dec 13, 2024 - 9:45 AM│  │
│  │                  $8.50│  │
│  │            CANCELLED   │  │
│  └───────────────────────┘  │
└─────────────────────────────┘
```

---

### 8. Profile Screen
**Purpose**: User profile and settings
**Features**:
- User avatar (initials)
- Name display
- Role badge (Passenger/Driver)
- Email information
- Phone number
- Member since date
- Settings menu
- Help & Support
- Privacy Policy
- About app
- Logout button

**User Actions**:
- View profile information
- Access settings
- View help & support
- Read privacy policy
- View about information
- Logout

**Visual Layout**:
```
┌─────────────────────────────┐
│  Profile            [✏️]     │
├─────────────────────────────┤
│                             │
│         ┌─────┐             │
│         │  J  │             │
│         └─────┘             │
│      John Doe               │
│     [PASSENGER]             │
│                             │
│  ┌───────────────────────┐  │
│  │ 📧 Email              │  │
│  │ john@example.com      │  │
│  └───────────────────────┘  │
│                             │
│  ┌───────────────────────┐  │
│  │ 📱 Phone              │  │
│  │ +1234567890           │  │
│  └───────────────────────┘  │
│                             │
│  ┌───────────────────────┐  │
│  │ 📅 Member Since       │  │
│  │ Nov 12, 2025          │  │
│  └───────────────────────┘  │
│                             │
│  ┌───────────────────────┐  │
│  │ ⚙️ Settings       →   │  │
│  │ ❓ Help & Support →   │  │
│  │ 🔒 Privacy Policy →   │  │
│  │ ℹ️ About          →   │  │
│  └───────────────────────┘  │
│                             │
│  ┌───────────────────────┐  │
│  │ 🚪 Logout             │  │
│  └───────────────────────┘  │
└─────────────────────────────┘
```

---

## 🎨 Design System

### Color Palette
- **Primary**: Green (#2E7D32) - Eco-friendly, trustworthy
- **Secondary**: Dark Green (#1B5E20) - Professional
- **Accent**: Amber (#FFB300) - Attention, call-to-action
- **Background**: Light Gray (#F5F5F5) - Clean, modern
- **Surface**: White (#FFFFFF) - Cards, elevated elements
- **Error**: Red (#D32F2F) - Warnings, errors
- **Success**: Green (#388E3C) - Confirmations

### Typography
- **Font Family**: Poppins (Google Fonts)
- **Display Large**: 32px, Bold
- **Display Medium**: 28px, Bold
- **Headline Medium**: 24px, SemiBold
- **Title Large**: 20px, SemiBold
- **Body Large**: 16px, Regular
- **Body Medium**: 14px, Regular

### Components
- **Buttons**: Rounded (12px), Primary color
- **Cards**: Rounded (16px), Shadow elevation 2
- **Input Fields**: Rounded (12px), Border 1px
- **Bottom Sheets**: Rounded top corners (20px)

---

## 🔄 User Journeys

### Journey 1: Passenger Books a Ride
```
1. Launch App
2. Login/Already authenticated
3. Navigate to Home (Passenger View)
4. Tap "Book a Ride"
5. Enter destination
6. Review fare estimate
7. Confirm booking
8. Wait for driver acceptance
9. Track ride progress
10. Complete ride
11. View in ride history
```

### Journey 2: Driver Accepts a Ride
```
1. Launch App
2. Login/Already authenticated
3. Navigate to Home (Driver View)
4. Toggle to "Online"
5. Receive ride request
6. Review passenger & route details
7. Accept ride
8. Navigate to pickup location
9. Update status: "Picked Up"
10. Navigate to destination
11. Update status: "Completed"
12. View in ride history
```

### Journey 3: User Registration
```
1. Launch App
2. Tap "Sign Up"
3. Enter name, email, phone
4. Create password
5. Select role (Passenger/Driver)
6. Submit registration
7. Auto-login to app
8. Navigate to Home screen
```

---

## 📊 State Management

### Auth Provider States
- `isAuthenticated`: Boolean
- `currentUser`: User object or null
- `isLoading`: Boolean
- `errorMessage`: String or null

### Location Provider States
- `currentPosition`: Position or null
- `currentAddress`: String or null
- `isLoading`: Boolean
- `errorMessage`: String or null

### Ride Provider States
- `currentRide`: Ride or null
- `rideHistory`: List of Rides
- `nearbyDrivers`: List of Drivers
- `isLoading`: Boolean
- `errorMessage`: String or null

---

## 🔐 Permissions Required

### Android
- `INTERNET` - Network connectivity
- `ACCESS_FINE_LOCATION` - GPS location
- `ACCESS_COARSE_LOCATION` - Approximate location
- `ACCESS_BACKGROUND_LOCATION` - Background tracking

### iOS
- `NSLocationWhenInUseUsageDescription` - Location while using
- `NSLocationAlwaysAndWhenInUseUsageDescription` - Always location
- `NSLocationAlwaysUsageDescription` - Background location

---

## 🚀 Next Steps for Production

1. **Backend Integration**
   - Connect Firebase or custom backend
   - Implement real-time database sync
   - Add authentication flow

2. **Maps Integration**
   - Add Google Maps API key
   - Implement real-time tracking
   - Add route drawing
   - Show nearby drivers

3. **Payment Integration**
   - Add payment gateway (Stripe, PayPal)
   - Implement wallet system
   - Add receipt generation

4. **Notifications**
   - Push notifications for ride updates
   - Driver arrival notifications
   - Ride request alerts

5. **Testing**
   - Integration tests
   - Widget tests
   - End-to-end testing
   - Real device testing

---

**Status**: ✅ Complete UI/UX flow designed and implemented
**Ready for**: Backend integration and production deployment
