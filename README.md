# Check-in Process API (PAPI)

A MuleSoft application that provides airline check-in functionality through a RESTful API. This Process API handles passenger check-in operations including PNR-based check-in and payment approval for additional services.

## Overview

The Check-in PAPI is built using MuleSoft's Anypoint Platform and follows the API-led connectivity approach as a Process API layer. It provides endpoints for:

- Passenger check-in by PNR (Passenger Name Record)
- Payment approval for additional services (baggage fees)

## Features

- **PNR-based Check-in**: Complete check-in process using passenger's PNR
- **Payment Processing**: Handle payments for additional baggage
- **Flight Management Integration**: Connect with flight management systems
- **Passenger Data Registration**: Register and update passenger information
- **Secure Configuration**: Encrypted configuration properties support
- **API Gateway Integration**: Built-in API management and security
- **Comprehensive Logging**: Structured logging with tracing capabilities

## API Endpoints

### Check-in Operations

#### Check-in by PNR
```
PUT /api/v1/tickets/{PNR}/checkin
Content-Type: application/json
```

**Request Body:**
```json
{
  "lastName": "Smith",
  "numBags": 2
}
```

**Response:**
```json
{
  "paymentID": "PAY-1AKD7482FAB9STATKO"
}
```

#### Payment Approval
```
PUT /api/v1/tickets/{PNR}/paymentApproval
Content-Type: application/json
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

### API Console
Access the interactive API console at:
```
GET /console/v1/
```

## Technology Stack

- **MuleSoft Runtime**: 4.9.0+
- **Java**: 17
- **Maven**: Build and dependency management
- **APIKit**: API scaffolding and routing
- **DataWeave**: Data transformation
- **Secure Properties**: Encrypted configuration management
- **MUnit**: Testing framework

## Project Structure

```
check-in-papi/
├── src/
│   ├── main/
│   │   ├── mule/
│   │   │   ├── api.xml          # API endpoints and routing
│   │   │   ├── main.xml         # Core business logic flows
│   │   │   ├── global.xml       # Global configurations
│   │   │   ├── health.xml       # Health check endpoints
│   │   │   └── error.xml        # Error handling
│   │   └── resources/
│   │       ├── api/             # API specifications
│   │       ├── certs/           # TLS certificates
│   │       ├── *-properties.yaml    # Environment configurations
│   │       └── *-properties-secure.yaml # Encrypted properties
│   └── test/
│       ├── munit/               # MUnit test suites
│       └── resources/           # Test data and configurations
├── reports/                     # Generated reports
├── exchange-docs/               # API documentation
├── pom.xml                      # Maven configuration
└── mule-artifact.json          # Mule application metadata
```

## Prerequisites

- **Java 17** or higher
- **Maven 3.6+**
- **Anypoint Studio** (recommended for development)
- **MuleSoft Runtime 4.9.0+**

## Configuration

### Environment Properties

The application uses environment-specific configuration files:

- `dev-properties.yaml` / `dev-properties-secure.yaml` - Development environment
- `test-properties.yaml` / `test-properties-secure.yaml` - Test environment  
- `prod-properties.yaml` / `prod-properties-secure.yaml` - Production environment

### Key Configuration Properties

```yaml
# HTTPS Configuration
https:
  timeout: "60000"

# API Configuration  
api:
  id: "20213412"

# TLS Configuration
tls:
  keystore:
    type: "pkcs12"
    path: "certs/check-in-papi-dev.p12"
    alias: "server"
```

### Secure Properties

Sensitive configuration values are encrypted using Blowfish algorithm. Set the encryption key:

```
encrypt.key=your-encryption-key
```

## Building and Running

### Local Development

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd check-in-papi
   ```

2. **Install dependencies**
   ```bash
   mvn clean install
   ```

3. **Run the application**
   ```bash
   mvn mule:run
   ```

4. **Access the application**
   - API Base URL: `https://localhost:8082/api/v1`
   - API Console: `https://localhost:8082/console/v1`

### Deployment

#### CloudHub Deployment
```bash
mvn clean package deploy -DmuleDeploy
```

#### On-Premises Deployment
1. Build the deployable archive:
   ```bash
   mvn clean package
   ```

2. Deploy the generated JAR file to your Mule runtime

## Testing

### Run Unit Tests
```bash
mvn test
```

### Run MUnit Tests
```bash
mvn clean test -Dmunit
```

### Test Coverage
Test coverage reports are generated in the `target/site/munit/coverage` directory.

## Monitoring and Health Checks

The application includes health check endpoints for monitoring:

- Health status endpoint available
- Structured logging with correlation IDs
- Error handling with custom error types

## Security

- **HTTPS Only**: All endpoints secured with TLS
- **API Gateway**: Integrated with Anypoint API Gateway
- **Encrypted Properties**: Sensitive configuration encrypted
- **Certificate-based Security**: Client certificate authentication support

## Error Handling

Custom error types:
- `APP:CANT_CREATE_PAYMENT` - Payment creation failures

All errors return structured JSON responses with appropriate HTTP status codes.

## Dependencies

Key dependencies include:
- `mule-http-connector` - HTTP connectivity
- `mule-apikit-module` - API scaffolding
- `mule-secure-configuration-property-module` - Encrypted properties
- `mule-tracing-module` - Distributed tracing
- `apps-commons` - Shared application components

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new functionality
5. Ensure all tests pass
6. Submit a pull request

## API Documentation

Detailed API documentation is available in the Exchange documentation and can be accessed through the API console when the application is running.

## Support

For questions and support, please contact the development team or create an issue in the project repository.

## License

[Add your license information here]
