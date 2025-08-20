# Check-In Passenger API (check-in-papi)

A MuleSoft API application that provides passenger check-in functionality for airline services. This API allows passengers to check in for their flights using their PNR (Passenger Name Record) and handles payment processing for baggage.

## 🚀 Project Overview

This MuleSoft application provides RESTful API endpoints for:
- **Passenger Check-in**: Process passenger check-in requests using PNR
- **Payment Approval**: Handle payment approvals for baggage fees
- **Flight Management**: Manage flight-related operations
- **Passenger Registration**: Register passenger data

## 📋 Prerequisites

- **Mule Runtime**: 4.9.0 or higher
- **Java**: JDK 17
- **Anypoint Studio**: Latest version
- **Maven**: 3.6.0 or higher

## 🏗️ Project Structure

```
check-in-papi/
├── src/
│   ├── main/
│   │   ├── mule/
│   │   │   ├── api.xml              # API Gateway configuration
│   │   │   ├── main.xml             # Main application flows
│   │   │   ├── global.xml           # Global configurations
│   │   │   ├── error.xml            # Error handling
│   │   │   └── health.xml           # Health check endpoints
│   │   └── resources/
│   │       ├── api/                 # API specifications
│   │       ├── certs/               # SSL certificates
│   │       ├── dev-properties.yaml  # Development properties
│   │       ├── prod-properties.yaml # Production properties
│   │       └── test-properties.yaml # Test properties
│   └── test/
│       ├── munit/                   # MUnit test suites
│       └── resources/
│           └── dwl/                 # Test data and transformations
├── pom.xml                          # Maven configuration
└── mule-artifact.json              # Mule artifact configuration
```

## 🔧 Configuration

### Environment Properties

The application supports multiple environments with different configuration files:

- **Development**: `src/main/resources/dev-properties.yaml`
- **Production**: `src/main/resources/prod-properties.yaml`
- **Test**: `src/main/resources/test-properties.yaml`

### Key Configuration Properties

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

## 🛠️ Installation & Setup

### 1. Clone the Repository

```bash
git clone <repository-url>
cd check-in-papi
```

### 2. Import into Anypoint Studio

1. Open Anypoint Studio
2. Go to `File` → `Import`
3. Select `MuleSoft` → `Anypoint Studio Project from External Location`
4. Choose the project directory
5. Click `Finish`

### 3. Configure SSL Certificates

Place your SSL certificates in the `src/main/resources/certs/` directory:
- `check-in-papi-dev.p12` (for development)
- `check-in-papi-prod.p12` (for production)

### 4. Update Properties

Modify the appropriate properties file for your environment:
- Update API IDs
- Configure timeouts
- Set correct certificate paths

## 🚀 Running the Application

### Local Development

1. **Using Anypoint Studio**:
   - Right-click on the project
   - Select `Run As` → `Mule Application`

2. **Using Maven**:
   ```bash
   mvn clean install
   mvn mule:run
   ```

### Application URLs

- **API Base URL**: `http://localhost:8081/api/v1`
- **API Console**: `http://localhost:8081/console/v1`

## 📡 API Endpoints

### 1. Check-in by PNR

**Endpoint**: `PUT /api/v1/tickets/{PNR}/checkin`

**Description**: Process passenger check-in using PNR

**Request Body**:
```json
{
  "lastName": "Smith",
  "numBags": 2
}
```

**Response**:
```json
{
  "paymentID": "PAY-1AKD7482FAB9STATKO"
}
```

### 2. Payment Approval

**Endpoint**: `PUT /api/v1/tickets/{PNR}/paymentApproval`

**Description**: Handle payment approval for baggage fees

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

### Running MUnit Tests

1. **Using Anypoint Studio**:
   - Right-click on test suite
   - Select `Run As` → `MUnit Test`

2. **Using Maven**:
   ```bash
   mvn clean test
   ```

### Test Data

Test data is available in `src/test/resources/dwl/`:
- `check-in-by-pnr-request.json`: Sample check-in request
- `TestData.dwl`: DataWeave test transformations

### Test Coverage

The project includes comprehensive MUnit tests covering:
- API endpoint functionality
- Error handling scenarios
- Data transformations
- Flow validations

## 🔒 Security

### SSL/TLS Configuration

The application uses PKCS12 keystores for SSL/TLS:
- Development: `check-in-papi-dev.p12`
- Production: `check-in-papi-prod.p12`

### API Security

- Secure configuration properties module
- TLS encryption for HTTPS endpoints
- Input validation and sanitization

## 📊 Monitoring & Logging

### Logging Configuration

- **Development**: `log4j2.xml`
- **Test**: `log4j2-test.xml`

### Tracing

The application includes comprehensive tracing:
- Request/response logging
- Flow execution tracking
- Performance monitoring
- Error tracking

### Health Checks

Health check endpoints are available for monitoring application status.

## 🚀 Deployment

### CloudHub Deployment

1. **Package the Application**:
   ```bash
   mvn clean package
   ```

2. **Deploy to CloudHub**:
   - Use Anypoint Platform Runtime Manager
   - Upload the generated JAR file
   - Configure environment-specific properties

### Runtime Fabric Deployment

1. **Build Docker Image**:
   ```bash
   mvn clean package
   ```

2. **Deploy to Runtime Fabric**:
   - Use Anypoint Platform Runtime Manager
   - Configure deployment settings
   - Set environment variables

## 🔧 Dependencies

### Core Dependencies

- **Mule HTTP Connector**: HTTP listener and requester
- **APIKit Module**: API specification handling
- **Secure Configuration Property Module**: Secure property management
- **Tracing Module**: Application tracing and monitoring

### Test Dependencies

- **MUnit Runner**: Unit testing framework
- **MUnit Tools**: Testing utilities
- **Weave Assertions**: DataWeave testing assertions

## 🐛 Troubleshooting

### Common Issues

1. **SSL Certificate Errors**:
   - Verify certificate paths in properties files
   - Ensure certificates are in the correct format (PKCS12)

2. **Port Conflicts**:
   - Check if port 8081 is available
   - Update port configuration if needed

3. **Maven Build Issues**:
   - Clean and rebuild: `mvn clean install`
   - Check Mule runtime version compatibility

### Debug Mode

Enable debug logging by modifying `log4j2.xml`:
```xml
<Logger name="org.mule.runtime.core.internal.processor.LoggerMessageProcessor" level="DEBUG"/>
```

## 📝 API Documentation

### API Console

Access the interactive API console at:
`http://localhost:8081/console/v1`

### OpenAPI Specification

The API specification is available in the `src/main/resources/api/` directory.

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add/update tests
5. Submit a pull request

## 📄 License

This project is licensed under the [License Name] - see the LICENSE file for details.

## 📞 Support

For support and questions:
- Create an issue in the repository
- Contact the development team
- Check the MuleSoft documentation

## 🔄 Version History

- **v1.0.0-SNAPSHOT**: Initial release with check-in and payment approval functionality

---

**Note**: This is a MuleSoft application. Ensure you have the appropriate MuleSoft licenses and access to Anypoint Platform for full functionality.
