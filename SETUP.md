# Commission Calculator - Setup and Running Instructions

## Overview
This is a full-stack Commission Calculator application with:
- **Backend**: ASP.NET Core Web API (.NET 8)
- **Frontend**: React application
- **Purpose**: Compare FCamara commission rates vs competitor rates

## Business Rules Implemented
- **FCamara Commission Rates**:
  - Local Sales: 20%
  - Foreign Sales: 35%
- **Competitor Commission Rates**:
  - Local Sales: 2%
  - Foreign Sales: 7.55%

## Prerequisites
- .NET 8 SDK
- Node.js (v16 or higher)
- npm or yarn

## Running the Application

### 1. Start the Backend API

```bash
cd api
dotnet restore
dotnet run
```

The API will be available at:
- HTTPS: https://localhost:5000
- HTTP: http://localhost:5111
- Swagger UI: https://localhost:5000/swagger

### 2. Start the Frontend React App

```bash
cd ui
npm install
npm start
```

The React app will be available at:
- http://localhost:3000

## API Endpoints

### POST /api/commision/calculate
Calculate commissions for both FCamara and competitors.

**Request Body:**
```json
{
  "localSalesCount": 10,
  "foreignSalesCount": 10,
  "averageSaleAmount": 100.00
}
```

**Response:**
```json
{
  "fCamaraCommissionAmount": 550.00,
  "competitorCommissionAmount": 95.50,
  "localSalesCount": 10,
  "foreignSalesCount": 10,
  "averageSaleAmount": 100.00
}
```

## Testing the API

You can test the API using:
1. **Swagger UI**: Navigate to https://localhost:5000/swagger
2. **HTTP file**: Use the `test-api.http` file in the api folder
3. **Postman/Insomnia**: Import the API endpoints

## Example Calculation

For the example in the README:
- Local Sales: 10 × £100 × 20% = £200
- Foreign Sales: 10 × £100 × 35% = £350
- **FCamara Total**: £550

- Local Sales: 10 × £100 × 2% = £20
- Foreign Sales: 10 × £100 × 7.55% = £75.50
- **Competitor Total**: £95.50

**FCamara Advantage**: £454.50 more than competitor

## Features Implemented

### Backend (Production Quality)
- ✅ Proper commission calculation logic
- ✅ Input validation with data annotations
- ✅ Error handling and proper HTTP status codes
- ✅ CORS configuration for React frontend
- ✅ Swagger documentation
- ✅ Decimal precision handling
- ✅ RESTful API design

### Frontend (Production Quality)
- ✅ React functional components with hooks
- ✅ Form validation and error handling
- ✅ Loading states and user feedback
- ✅ Responsive design
- ✅ Professional UI/UX
- ✅ Currency formatting (GBP)
- ✅ Commission breakdown display
- ✅ Advantage calculation and display

### Integration
- ✅ CORS properly configured
- ✅ API communication with error handling
- ✅ Proper HTTP methods and status codes
- ✅ JSON serialization/deserialization

## Architecture Decisions

1. **Separation of Concerns**: Clear separation between API and UI
2. **Validation**: Both client-side and server-side validation
3. **Error Handling**: Comprehensive error handling at all levels
4. **User Experience**: Loading states, clear feedback, and professional design
5. **Maintainability**: Clean code structure and proper naming conventions
6. **Production Ready**: Proper CORS, validation, error handling, and responsive design

## Troubleshooting

### Common Issues

1. **CORS Errors**: Ensure the API is running on https://localhost:5000 and React on http://localhost:3000
2. **Port Conflicts**: Check if ports 5000, 5111, or 3000 are already in use
3. **SSL Certificate**: Accept the development SSL certificate when prompted

### Development Tips

1. **Hot Reload**: Both API and React support hot reload during development
2. **Debugging**: Use browser dev tools for frontend and Visual Studio/VS Code for backend
3. **API Testing**: Use Swagger UI for quick API testing during development