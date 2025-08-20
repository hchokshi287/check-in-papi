# Check-In Passenger API (PAPI)

A MuleSoft-based API for managing passenger check-in processes, including flight management, passenger registration, and payment processing for baggage.

## 📋 Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Configuration](#configuration)
- [API Endpoints](#api-endpoints)
- [Running the Application](#running-the-application)
- [Testing](#testing)
- [Deployment](#deployment)
- [Project Structure](#project-structure)
- [Contributing](#contributing)

## 🎯 Overview

The Check-In Passenger API (PAPI) is a MuleSoft application that provides RESTful endpoints for airline passenger check-in operations. It handles passenger data registration, flight management, and payment processing for baggage services.

## ✨ Features

- **Passenger Check-in**: Process passenger check-in requests using PNR (Passenger Name Record)
- **Flight Management**: Handle flight-related operations and data
- **Passenger Registration**: Register and manage passenger information
- **Payment Processing**: Create and manage payments for baggage services
- **Payment Approval**: Approve payment requests for passenger services
- **Comprehensive Error Handling**: Robust error handling with specific error types
- **Logging and Tracing**: Detailed logging and tracing capabilities
- **API Console**: Built-in API documentation and testing interface

## 🔧 Prerequisites

- **Mule Runtime**: 4.9.0 or higher
- **Java**: JDK 17
- **Anypoint Studio**: Latest version recommended
- **Maven**: 3.6.0 or higher
- **Anypoint Platform**: Access to Anypoint Platform for deployment

## 🚀 Installation

1. **Clone the repository**:
   ```bash
   git clone <repository-url>
   cd check-in-papi
   ```

2. **Import into Anypoint Studio**:
   - Open Anypoint Studio
   - Import existing Maven project
   - Select the project directory

3. **Install dependencies**:
   ```bash
   mvn clean install
   ```

## ⚙️ Configuration

### Environment Properties

The application uses different property files for different environments:

- **Development**: `src/main/resources/dev-properties.yaml`
- **Test**: `src/main/resources/test-properties.yaml`
- **Production**: `src/main/resources/prod-properties.yaml`

### Key Configuration Parameters

```yaml
https:
  timeout: "60000"
  
api:
  id: "20213412"

tls:
  keystore:
    type: "pkcs12"
    path: "certs/check-in-papi-dev.p12"
    alias: "server"
```

### TLS Configuration

The application uses PKCS12 keystore for TLS/SSL configuration. Ensure the certificate files are placed in the `src/main/resources/certs/` directory.

## 🔌 API Endpoints

### Base URL
- **API**: `/api/{version}/*`
- **Console**: `/console/{version}/*`

### Available Endpoints

#### 1. Passenger Check-in
- **Method**: `PUT`
- **Path**: `/tickets/{PNR}/checkin`
- **Content-Type**: `application/json`
- **Description**: Process passenger check-in using PNR

#### 2. Payment Approval
- **Method**: `PUT`
- **Path**: `/tickets/{PNR}/paymentApproval`
- **Content-Type**: `application/json`
- **Description**: Approve payment for passenger services

### Response Format

#### Check-in Response
```json
{
  "paymentID": "PAY-1AKD7482FAB9STATKO"
}
```

#### Payment Approval Response
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

## 🏃‍♂️ Running the Application

### Local Development

1. **Using Anypoint Studio**:
   - Right-click on the project
   - Select "Run As" → "Mule Application"

2. **Using Maven**:
   ```bash
   mvn mule:run
   ```

3. **Using Mule Runtime**:
   ```bash
   mvn clean package
   mvn mule:deploy
   ```

### Access Points

- **API Console**: `http://localhost:8081/console/1`
- **API Endpoints**: `http://localhost:8081/api/1`

## 🧪 Testing

### Unit Testing

The project includes comprehensive MUnit tests:

```bash
mvn test
```

### Test Structure

- **Test Suite**: `src/test/munit/main-test-suite.xml`
- **Test Data**: `src/test/resources/checkinbypnrtest/`
- **DataWeave Tests**: `src/test/resources/dwl/`

### Running Specific Tests

```bash
# Run specific test suite
mvn test -Dtest=main-test-suite.xml

# Run with specific environment
mvn test -Dmule.env=test
```

## 🚀 Deployment

### CloudHub Deployment

1. **Package the application**:
   ```bash
   mvn clean package
   ```

2. **Deploy to CloudHub**:
   ```bash
   mvn deploy -DmuleDeploy
   ```

### Runtime Fabric Deployment

1. **Build the application**:
   ```bash
   mvn clean package
   ```

2. **Deploy to Runtime Fabric**:
   ```bash
   mvn deploy -DmuleDeploy
   ```

### Environment-Specific Deployment

```bash
# Development
mvn deploy -Dmule.env=dev

# Test
mvn deploy -Dmule.env=test

# Production
mvn deploy -Dmule.env=prod
```

## 📁 Project Structure

```
check-in-papi/
├── src/
│   ├── main/
│   │   ├── java/                    # Java source files
│   │   ├── mule/
│   │   │   ├── api.xml             # API router configuration
│   │   │   ├── main.xml            # Main application flows
│   │   │   ├── global.xml          # Global configurations
│   │   │   ├── error.xml           # Error handling
│   │   │   └── health.xml          # Health check endpoints
│   │   └── resources/
│   │       ├── api/                # API specifications
│   │       ├── certs/              # SSL certificates
│   │       ├── dev-properties.yaml # Development properties
│   │       ├── test-properties.yaml # Test properties
│   │       └── prod-properties.yaml # Production properties
│   └── test/
│       ├── java/                   # Java test files
│       ├── munit/                  # MUnit test suites
│       └── resources/              # Test resources
├── pom.xml                         # Maven configuration
├── mule-artifact.json             # Mule artifact configuration
└── README.md                      # This file
```

## 🔄 Main Flows

### 1. check-in-by-pnr
Handles the complete check-in process:
- Sets logging variables
- Processes check-in payload
- Manages flight operations
- Registers passenger data
- Creates payment for baggage
- Returns payment ID

### 2. payment-approval-by-pnr
Processes payment approval requests:
- Validates PNR
- Returns flight and passenger information

### 3. Sub-flows
- **set-logging-vars**: Configures tracing and logging variables
- **check-in-flights-management**: Handles flight-related operations
- **register-passenger-data**: Manages passenger registration
- **create-payment-for-bags**: Processes baggage payment creation

## 🛡️ Error Handling

The application implements comprehensive error handling:

- **Global Error Handler**: Defined in `error.xml`
- **Flow-specific Error Handling**: Custom error handling for specific flows
- **Error Types**: 
  - `APP:CANT_CREATE_PAYMENT`: Payment creation failures
  - HTTP status codes for different error scenarios

## 📊 Monitoring and Logging

- **Tracing**: Built-in tracing capabilities for request tracking
- **Logging**: Comprehensive logging at different levels
- **Health Checks**: Health check endpoints for monitoring
- **Metrics**: Performance and usage metrics

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Development Guidelines

- Follow MuleSoft best practices
- Use DataWeave for all transformations
- Implement proper error handling
- Add comprehensive unit tests
- Update documentation for new features

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🆘 Support

For support and questions:

- **Documentation**: Check the API console at `/console/1`
- **Issues**: Create an issue in the repository
- **Team**: Contact the development team

## 🔗 Related Links

- [MuleSoft Documentation](https://docs.mulesoft.com/)
- [Anypoint Platform](https://www.mulesoft.com/platform/anypoint-platform)
- [MUnit Testing](https://docs.mulesoft.com/munit/2.3/)
- [DataWeave Reference](https://docs.mulesoft.com/dataweave/2.4/)

---

**Version**: 1.0.0-SNAPSHOT  
**Last Updated**: December 2024  
**Mule Runtime**: 4.9.0+  
**Java Version**: 17
