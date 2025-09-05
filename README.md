# Check-in PAPI (Passenger API)

A MuleSoft application that provides check-in functionality for airline passengers using their PNR (Passenger Name Record). This API allows passengers to check-in for their flights and process payments for additional services like baggage fees.

## 🚀 Overview

The Check-in PAPI is a RESTful API built with MuleSoft 4 that enables airline passengers to:
- Check-in for flights using their PNR
- Process payments for additional services (baggage fees)
- Receive boarding pass information after successful payment

## 📋 Features

- **Passenger Check-in**: Complete check-in process using PNR
- **Payment Processing**: Handle payments for additional services
- **Boarding Pass Generation**: Provide boarding pass details after payment approval
- **RESTful API**: Clean REST endpoints with comprehensive documentation
- **Error Handling**: Robust error handling with detailed error responses
- **Security**: Basic authentication for all endpoints
- **Logging**: Comprehensive logging and tracing capabilities

## 🛠️ Technology Stack

- **MuleSoft 4.9.0+**: Runtime platform
- **Java 17**: Runtime environment
- **RAML 1.0**: API specification
- **Maven**: Build and dependency management
- **MUnit**: Testing framework

## 📁 Project Structure

```
check-in-papi/
├── src/
│   ├── main/
│   │   ├── mule/                    # Mule configuration files
│   │   │   ├── api.xml             # API router configuration
│   │   │   ├── main.xml            # Main application flows
│   │   │   ├── global.xml          # Global configurations
│   │   │   └── error.xml           # Error handling
│   │   ├── resources/
│   │   │   ├── api.raml            # API specification
│   │   │   ├── properties.yaml     # Application properties
│   │   │   └── *.yaml              # Environment-specific properties
│   │   └── java/                   # Custom Java classes
│   └── test/
│       ├── munit/                  # MUnit test files
│       └── resources/              # Test resources
├── reports/                        # API documentation reports
├── pom.xml                        # Maven configuration
└── mule-artifact.json             # Mule artifact metadata
```

## 🔧 Prerequisites

- **MuleSoft Anypoint Studio** 7.0+
- **Java 17** or higher
- **Maven 3.6+**
- **Mule Runtime** 4.9.0+

## 🚀 Getting Started

### 1. Clone the Repository

```bash
git clone <repository-url>
cd check-in-papi
```

### 2. Import into Anypoint Studio

1. Open Anypoint Studio
2. Import the project as a Maven project
3. Wait for dependencies to be resolved

### 3. Configure Properties

Update the environment-specific property files in `src/main/resources/`:
- `dev-properties.yaml` - Development environment
- `test-properties.yaml` - Test environment  
- `prod-properties.yaml` - Production environment

### 4. Run the Application

#### Using Anypoint Studio
1. Right-click on the project
2. Select "Run As" → "Mule Application"

#### Using Maven
```bash
mvn clean install
mvn mule:run
```

The application will start on `https://localhost:8081`

## 📚 API Documentation

### Base URL
```
https://localhost:8081/api/v1
```

### Authentication
All endpoints require Basic Authentication. Include credentials in the Authorization header:
```
Authorization: Basic <base64-encoded-credentials>
```

### Endpoints

#### 1. Check-in Passenger
**PUT** `/tickets/{PNR}/checkin`

Check-in a passenger using their PNR.

**Request Body:**
```json
{
  "lastName": "Smith",
  "firstName": "John",
  "email": "john.smith@email.com",
  "phone": "+1-555-123-4567",
  "flightNumber": "AA1234",
  "departureDate": "2024-03-15",
  "departureTime": "14:30:00",
  "departureAirport": "ATL",
  "arrivalAirport": "SFO",
  "seatClass": "Economy",
  "numBags": 2,
  "specialRequests": "Wheelchair assistance"
}
```

**Response:**
```json
{
  "paymentID": "PAY-1AKD7482FAB9STATKO"
}
```

#### 2. Payment Approval
**PUT** `/tickets/{PNR}/paymentApproval`

Approve payment for additional services and get boarding pass information.

**Request Body:**
```json
{
  "paymentID": "PAY-1AKD7482FAB9STATKO",
  "payerID": "STK829AJDK9",
  "paymentStatus": "APPROVED",
  "paymentMethod": "CREDIT_CARD",
  "amount": 75.00,
  "currency": "USD",
  "transactionId": "TXN-1234567890"
}
```

**Response:**
```json
{
  "lastName": "Smith",
  "flightDate": "2019-02-14",
  "depart": "14:30:00",
  "boarding": "13:15:00",
  "gate": "4A",
  "flight": "ANY6584",
  "airportDepart": "ATL",
  "airportArrive": "SFO",
  "class": "Economy",
  "seat": "16C",
  "bagsCount": 2,
  "PNR": "928382J"
}
```

### Error Responses

All error responses follow this format:
```json
{
  "error": "Error message",
  "code": "ERROR_CODE",
  "timestamp": "2024-03-15T14:30:00Z"
}
```

**Common Error Codes:**
- `INVALID_INPUT` - Invalid input data provided
- `PNR_NOT_FOUND` - PNR not found
- `INVALID_PAYMENT` - Invalid payment data
- `PAYMENT_NOT_FOUND` - Payment ID not found
- `INTERNAL_ERROR` - Internal server error

## 🧪 Testing

### Running Tests

```bash
# Run all tests
mvn test

# Run specific test suite
mvn test -Dtest=CheckInTestSuite
```

### Test Coverage

The project includes comprehensive MUnit tests covering:
- API endpoint functionality
- Error handling scenarios
- Data transformation logic
- Integration flows

## 📊 API Console

Access the interactive API console at:
```
https://localhost:8081/console/v1/
```

## 🔒 Security

- **Authentication**: Basic Authentication required for all endpoints
- **HTTPS**: All communications use HTTPS
- **Rate Limiting**: 100 requests/minute, 1000 requests/hour per API key

## 🚀 Deployment

### CloudHub Deployment

1. Package the application:
```bash
mvn clean package
```

2. Deploy to CloudHub using Anypoint Platform or CLI

### On-Premises Deployment

1. Build the application:
```bash
mvn clean package
```

2. Deploy the generated JAR file to your Mule runtime

## 📈 Monitoring and Logging

The application includes:
- **Structured Logging**: Comprehensive logging with trace variables
- **Error Tracking**: Detailed error logging and handling
- **Performance Monitoring**: Built-in performance metrics
- **Health Checks**: Application health monitoring endpoints

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🆘 Support

For support and questions:
- Create an issue in the repository
- Contact the development team
- Check the API documentation in the `/reports` directory

## 📋 Changelog

### Version 1.0.0
- Initial release
- Check-in functionality
- Payment processing
- Boarding pass generation
- Comprehensive API documentation

---

**Built with ❤️ using MuleSoft**
