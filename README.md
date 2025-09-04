# Check-in API

A MuleSoft-based REST API that provides airline passenger check-in functionality using PNR (Passenger Name Record) identifiers. This API allows passengers to check-in for their flights and process payments for additional services like baggage fees.

## 🚀 Features

- **Passenger Check-in**: Check-in passengers using their PNR
- **Payment Processing**: Handle payments for additional services (baggage fees)
- **Flight Information**: Retrieve boarding pass details and flight information
- **RESTful API**: Built with MuleSoft 4.x and follows REST principles
- **API Documentation**: Complete RAML specification with examples
- **Testing Support**: Includes Postman collection and JMeter test plans

## 📋 Prerequisites

- **Java 17** or higher
- **MuleSoft Runtime 4.9.0** or higher
- **Maven 3.6+** for building the project
- **Anypoint Studio** (recommended for development)

## 🛠️ Installation & Setup

### 1. Clone the Repository

```bash
git clone <repository-url>
cd check-in-papi
```

### 2. Build the Project

```bash
mvn clean install
```

### 3. Run the Application

```bash
mvn mule:run
```

The API will be available at: `https://localhost:8081/api/v1`

## 📚 API Documentation

### Base URL
```
https://localhost:8081/api/v1
```

### Authentication
All endpoints require Basic Authentication. Include your credentials in the Authorization header:
```
Authorization: Basic <base64-encoded-credentials>
```

### Endpoints

#### 1. Check-in Passenger
**PUT** `/tickets/{PNR}/checkin`

Check-in a passenger using their PNR and return a payment ID for additional services.

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

Approve payment for additional services and receive boarding pass information.

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

The API returns standard HTTP status codes with detailed error information:

```json
{
  "error": "Error description",
  "code": "ERROR_CODE",
  "timestamp": "2024-03-15T14:30:00Z"
}
```

**Common Error Codes:**
- `INVALID_PNR`: PNR not found or invalid format
- `INVALID_INPUT`: Invalid request data
- `INVALID_PAYMENT`: Invalid payment information
- `PAYMENT_NOT_FOUND`: Payment ID not found
- `INTERNAL_ERROR`: Server error

## 🧪 Testing

### Postman Collection
Import the provided Postman collection (`Check-in-API-Postman-Collection.json`) to test the API endpoints with pre-configured requests.

### JMeter Test Plan
Use the JMeter test plan (`Check-in-API-JMeter-Test-Plan.jmx`) for performance testing and load testing scenarios.

### Test Data
The project includes test data in `test-data.csv` with sample passenger information for testing purposes.

### MUnit Tests
Run the MUnit tests to validate the application logic:

```bash
mvn test
```

## 📁 Project Structure

```
check-in-papi/
├── src/
│   ├── main/
│   │   ├── mule/                 # Mule configuration files
│   │   │   ├── api.xml          # API Kit configuration
│   │   │   ├── main.xml         # Main application flow
│   │   │   ├── global.xml       # Global configurations
│   │   │   └── error.xml        # Error handling
│   │   └── resources/
│   │       ├── api.raml         # API specification
│   │       └── *.yaml           # Environment properties
│   └── test/
│       ├── munit/               # MUnit test files
│       └── resources/           # Test resources
├── reports/                     # API documentation reports
├── Check-in-API-Postman-Collection.json
├── Check-in-API-JMeter-Test-Plan.jmx
├── test-data.csv
├── pom.xml
└── mule-artifact.json
```

## 🔧 Configuration

### Environment Properties
The application supports multiple environments with separate property files:
- `dev-properties.yaml` - Development environment
- `test-properties.yaml` - Testing environment  
- `prod-properties.yaml` - Production environment

### Secure Properties
Sensitive configuration values are stored in secure property files:
- `dev-properties-secure.yaml`
- `test-properties-secure.yaml`
- `prod-properties-secure.yaml`

## 🚀 Deployment

### Local Development
```bash
mvn mule:run
```

### CloudHub Deployment
```bash
mvn clean package
mvn mule:deploy
```

### Runtime Fabric
Package the application and deploy to Runtime Fabric using Anypoint Platform.

## 📊 API Console

Access the interactive API console at:
```
https://localhost:8081/console/v1/
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🆘 Support

For support and questions:
- Create an issue in the repository
- Contact the development team
- Check the API documentation at `/console/v1/`

## 🔄 Version History

- **v1.0.0** - Initial release with check-in and payment approval functionality

---

**Built with ❤️ using MuleSoft 4.x**
