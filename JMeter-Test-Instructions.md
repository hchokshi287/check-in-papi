# JMeter Test Plan for Check-In API

This directory contains a comprehensive JMeter test plan for testing the Check-In Passenger API (PAPI).

## Files Included

1. **`Check-In-API-JMeter-Test-Plan.jmx`** - Main JMeter test plan file
2. **`test-data.csv`** - Test data file for dynamic testing
3. **`JMeter-Test-Instructions.md`** - This instruction file

## API Endpoints Tested

The test plan covers the following endpoints:

1. **Check-In by PNR**
   - **Method**: PUT
   - **URL**: `/api/v1/tickets/{PNR}/checkin`
   - **Content-Type**: application/json
   - **Request Body**: JSON with passenger and baggage information
   - **Expected Response**: JSON with payment ID

2. **Payment Approval by PNR**
   - **Method**: PUT
   - **URL**: `/api/v1/tickets/{PNR}/paymentApproval`
   - **Content-Type**: application/json
   - **Request Body**: JSON with payment approval information
   - **Expected Response**: JSON with flight and passenger details

## Test Plan Structure

### 1. Load Test Thread Group
- **Threads**: 5 concurrent users
- **Ramp-up**: 10 seconds
- **Loop Count**: 10 iterations per thread
- **Purpose**: Performance and load testing

### 2. Functional Test Thread Group
- **Threads**: 1 user
- **Ramp-up**: 1 second
- **Loop Count**: 1 iteration
- **Purpose**: Functional validation with dynamic test data

## Prerequisites

1. **JMeter Installation**: Download and install Apache JMeter (version 5.6.3 or later)
2. **Java**: Ensure Java 8 or later is installed
3. **API Server**: Ensure the Check-In API is running on `https://localhost:8081`
4. **SSL Certificate**: If using self-signed certificates, you may need to configure JMeter to accept them

## Configuration

### Base Configuration
The test plan uses the following default configuration:
- **Base URL**: `https://localhost:8081`
- **API Version**: `v1`
- **Content Type**: `application/json`

### Test Data
The functional test uses data from `test-data.csv` with the following columns:
- `lastName`: Passenger's last name
- `numBags`: Number of bags
- `pnr`: Passenger Name Record (unique identifier)
- `paymentApproved`: Boolean for payment approval status

## Running the Tests

### Method 1: Using JMeter GUI
1. Open JMeter
2. Load the test plan: `File > Open > Check-In-API-JMeter-Test-Plan.jmx`
3. Ensure the API server is running
4. Click the green "Start" button to run the tests

### Method 2: Using Command Line
```bash
# Navigate to JMeter bin directory
cd /path/to/jmeter/bin

# Run the test plan
./jmeter -n -t Check-In-API-JMeter-Test-Plan.jmx -l results.jtl -e -o report/
```

## Test Assertions

### Response Code Assertions
- All requests expect HTTP 200 (OK) response codes

### JSON Path Assertions
- **Check-In Endpoint**: Validates presence of `paymentID` field
- **Payment Approval Endpoint**: Validates presence of `flight` and `PNR` fields

### Duration Assertions
- All requests should complete within 5 seconds

## Reports and Results

The test plan includes three result collectors:

1. **View Results Tree**: Detailed view of each request/response
2. **Aggregate Report**: Summary statistics for all requests
3. **Summary Report**: High-level summary of test results

### Key Metrics Monitored
- **Response Time**: Average, median, 90th percentile, 95th percentile, 99th percentile
- **Throughput**: Requests per second
- **Error Rate**: Percentage of failed requests
- **Response Codes**: Distribution of HTTP status codes

## Customization

### Modifying Test Data
Edit `test-data.csv` to add more test scenarios:
```csv
lastName,numBags,pnr,paymentApproved
NewPassenger,5,NEW123X,true
```

### Adjusting Load Parameters
In the JMeter GUI, modify the Thread Group settings:
- **Number of Threads**: Increase for higher load
- **Ramp-up Period**: Adjust for gradual load increase
- **Loop Count**: Change for longer/shorter test duration

### Changing API Endpoint
Update the User Defined Variables in the Test Plan:
- `baseUrl`: Change to your API server URL
- `apiVersion`: Update if using different API version

## Troubleshooting

### Common Issues

1. **SSL Certificate Errors**
   - Add `-Djavax.net.ssl.trustStore=/path/to/truststore.jks` to JMeter startup
   - Or disable SSL verification in HTTP Request Defaults

2. **Connection Refused**
   - Verify API server is running on the correct port (8081)
   - Check firewall settings

3. **Test Data Not Loading**
   - Ensure `test-data.csv` is in the same directory as the JMeter script
   - Verify CSV file format and encoding

4. **Assertion Failures**
   - Check API response format matches expected JSON structure
   - Verify test data values are correct

### Debug Mode
Enable debug logging in JMeter:
1. Right-click on Thread Group
2. Select "Add > Listener > Debug Sampler"
3. Run tests to see detailed request/response information

## Performance Testing Guidelines

### Load Testing Scenarios
1. **Baseline**: 1-5 users, 1-5 minutes
2. **Normal Load**: 10-50 users, 10-30 minutes
3. **Peak Load**: 100+ users, 30-60 minutes
4. **Stress Testing**: Increase load until system breaks

### Monitoring
- Monitor server CPU, memory, and network usage
- Watch for error rates and response time degradation
- Set up alerts for performance thresholds

## Security Considerations

- The test plan uses HTTPS for secure communication
- Sensitive data in test files should be encrypted or stored securely
- Consider using environment variables for sensitive configuration
- Regularly update test data to avoid using production-like data

## Support

For issues with the JMeter test plan:
1. Check the troubleshooting section above
2. Review JMeter logs for detailed error messages
3. Verify API server configuration and availability
4. Consult JMeter documentation for advanced configuration options
