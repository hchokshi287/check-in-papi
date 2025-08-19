# Check-In Passenger API (PAPI)

A MuleSoft-based REST API for handling passenger check-in operations and payment approvals for airline services.

## 📋 Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Installation & Setup](#installation--setup)
- [API Documentation](#api-documentation)
- [Testing](#testing)
- [Deployment](#deployment)
- [Project Structure](#project-structure)
- [Configuration](#configuration)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)

## 🎯 Overview

The Check-In Passenger API (PAPI) is a MuleSoft application that provides RESTful endpoints for airline passenger check-in operations. It handles passenger check-in requests, baggage processing, and payment approvals using Passenger Name Records (PNR).

### Key Capabilities

- **Passenger Check-In**: Process check-in requests with baggage information
- **Payment Processing**: Handle baggage fee payments and approvals
- **Flight Management**: Integrate with flight management systems
- **Passenger Registration**: Register and validate passenger data
- **Comprehensive Logging**: Detailed tracing and logging for operations

## ✨ Features

- **RESTful API Design**: Clean, REST-compliant endpoints
- **APIKit Integration**: Built with MuleSoft APIKit for automatic API documentation
- **Error Handling**: Comprehensive error handling with custom error types
- **DataWeave Transformations**: Advanced data mapping and transformations
- **Security**: Secure configuration properties and TLS support
- **Testing**: MUnit test suite for comprehensive testing
- **Performance Testing**: JMeter test plans for load and performance testing

## 🔧 Prerequisites

Before running this application, ensure you have the following installed:

- **Java**: JDK 8 or later
- **Mule Runtime**: Mule 4.9.0 or later
- **Anypoint Studio**: 7.x or later (for development)
- **Maven**: 3.6.x or later
- **Apache JMeter**: 5.6.3 or later (for performance testing)

## 🚀 Installation & Setup

### 1. Clone the Repository

```bash
git clone <repository-url>
cd check-in-papi
```

### 2. Configure Properties

The application uses environment-specific property files:

- `src/main/resources/properties.yaml` - Default properties
- `src/main/resources/dev-properties.yaml` - Development environment
- `src/main/resources/test-properties.yaml` - Test environment
- `src/main/resources/prod-properties.yaml` - Production environment

### 3. Build the Project

```bash
mvn clean install
```

### 4. Run Locally

#### Using Anypoint Studio
1. Import the project into Anypoint Studio
2. Right-click on the project
3. Select "Run As" > "Mule Application"

#### Using Command Line
```bash
mvn mule:run
```

The application will start on `http://localhost:8081`

## 📚 API Documentation

### Base URL
```
http://localhost:8081
```

### API Console
Access the interactive API console at:
```
http://localhost:8081/console/v1/
```

### Endpoints

#### 1. Check-In by PNR

**Endpoint**: `PUT /api/v1/tickets/{PNR}/checkin`

**Description**: Process passenger check-in with baggage information

**Request Body**:
```json
{
  "lastName": "Smith",
  "numBags": 2,
  "payerID": "PAYER123456",
  "paymentID": "PAY-1AKD7482FAB9STATKO"
}
```

**Response**:
```json
{
  "paymentID": "PAY-1AKD7482FAB9STATKO"
}
```

#### 2. Payment Approval by PNR

**Endpoint**: `PUT /api/v1/tickets/{PNR}/paymentApproval`

**Description**: Approve payment for baggage fees

**Request Body**:
```json
{
  "paymentApproved": true,
  "payerID": "PAYER123456",
  "paymentID": "PAY-1AKD7482FAB9STATKO"
}
```

**Response**:
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

## 🧪 Testing

### Unit Testing

The project includes comprehensive MUnit tests:

```bash
mvn test
```

Test files are located in `src/test/munit/`

### API Testing

#### Postman Collection

Import the provided Postman collection:
- File: `Check-In-PAPI.postman_collection.json`
- Environment variables:
  - `baseUrl`: `http://localhost:8081`
  - `PNR`: Test PNR value (e.g., `928382J`)

#### JMeter Performance Testing

1. **Load Test Plan**: `Check-In-API-JMeter-Test-Plan.jmx`
2. **Test Data**: `test-data.csv`
3. **Instructions**: See `JMeter-Test-Instructions.md`

Run JMeter tests:
```bash
jmeter -n -t Check-In-API-JMeter-Test-Plan.jmx -l results.jtl -e -o report/
```

### Test Data

The project includes sample test data in `test-data.csv` with various scenarios for:
- Different passenger names
- Various baggage counts
- Multiple PNR values
- Payment approval states

## 🚀 Deployment

### CloudHub Deployment

1. **Package the Application**:
   ```bash
   mvn clean package
   ```

2. **Deploy to CloudHub**:
   ```bash
   mvn mule:deploy
   ```

### Runtime Fabric Deployment

1. **Build Docker Image**:
   ```bash
   mvn clean package
   docker build -t check-in-papi .
   ```

2. **Deploy to Runtime Fabric**:
   ```bash
   mule deploy check-in-papi
   ```

### Configuration Management

- Use secure configuration properties for sensitive data
- Environment-specific property files for different deployment targets
- TLS configuration for secure communication

## 📁 Project Structure

```
check-in-papi/
├── src/
│   ├── main/
│   │   ├── mule/
│   │   │   ├── api.xml              # APIKit router configuration
│   │   │   ├── main.xml             # Main application flows
│   │   │   ├── global.xml           # Global configurations
│   │   │   ├── error.xml            # Error handling
│   │   │   └── health.xml           # Health check endpoints
│   │   ├── resources/
│   │   │   ├── api/                 # API specifications
│   │   │   ├── properties.yaml      # Default properties
│   │   │   ├── dev-properties.yaml  # Development properties
│   │   │   ├── test-properties.yaml # Test properties
│   │   │   └── prod-properties.yaml # Production properties
│   │   └── java/                    # Custom Java classes
│   └── test/
│       ├── munit/                   # MUnit test files
│       └── resources/               # Test resources
├── Check-In-PAPI.postman_collection.json
├── Check-In-API-JMeter-Test-Plan.jmx
├── JMeter-Test-Instructions.md
├── pom.xml
└── README.md
```

## ⚙️ Configuration

### Application Properties

Key configuration properties in `properties.yaml`:

```yaml
https:
  port: "8081"
  timeout: "30000"

api:
  groupId: "${api.groupId}"
  artifactId: "${api.artifactId}"
  version: "${api.version}"
  majorVersion: "v1"
```

### Environment-Specific Configuration

- **Development**: `dev-properties.yaml`
- **Testing**: `test-properties.yaml`
- **Production**: `prod-properties.yaml`

### Security Configuration

- Secure configuration properties for sensitive data
- TLS/SSL configuration for HTTPS endpoints
- API authentication and authorization (if required)

## 🔍 Troubleshooting

### Common Issues

1. **Port Already in Use**
   - Change the port in `properties.yaml`
   - Check for other running applications

2. **Maven Build Failures**
   - Ensure all dependencies are available
   - Check Maven settings and repositories

3. **API Endpoint Not Found**
   - Verify the API specification is correctly configured
   - Check the APIKit router configuration

4. **Test Failures**
   - Ensure the application is running before running tests
   - Check test data and expected responses

### Logging

The application uses Log4j2 for logging. Configuration files:
- `src/main/resources/log4j2.xml` - Main logging configuration
- `src/test/resources/log4j2-test.xml` - Test logging configuration

### Debug Mode

Enable debug logging by modifying `log4j2.xml`:
```xml
<Logger name="com.mulesoft" level="DEBUG"/>
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new functionality
5. Ensure all tests pass
6. Submit a pull request

### Development Guidelines

- Follow MuleSoft best practices
- Use DataWeave for all transformations
- Implement proper error handling
- Add comprehensive logging
- Write unit tests for new features
- Update documentation as needed

## 📄 License

This project is licensed under the [MIT License](LICENSE).

## 📞 Support

For support and questions:
- Check the troubleshooting section
- Review the API documentation
- Consult MuleSoft documentation
- Create an issue in the repository

---

**Version**: 1.0.0-SNAPSHOT  
**Mule Runtime**: 4.9.0  
**Last Updated**: 2024
