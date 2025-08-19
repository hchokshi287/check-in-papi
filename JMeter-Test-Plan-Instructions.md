# JMeter Test Plan for Check-In PAPI

## Overview
This JMeter test plan is designed to test the Check-In Passenger API (PAPI) endpoints. The test plan includes two main HTTP requests that are self-contained and can be executed independently.

## Test Plan Configuration

### Global Variables
The test plan uses the following user-defined variables that can be easily modified:

- **protocol**: `https` - The protocol to use for API calls
- **serverName**: `localhost` - The server hostname
- **port**: `8081` - The server port
- **apiPath**: `/api/v1/tickets` - The base API path
- **PNR**: `928382J` - The Passenger Name Record for testing

### Test Structure

#### 1. Check-In by PNR
- **Method**: PUT
- **URL**: `${protocol}://${serverName}:${port}${apiPath}/${PNR}/checkin`
- **Headers**: 
  - Content-Type: application/json
  - Accept: application/json
- **Body**: JSON payload for check-in request
```json
{
  "lastName": "Smith",
  "numBags": 2,
  "payerID": "PAYER123456",
  "paymentID": "PAY-1AKD7482FAB9STATKO"
}
```

#### 2. Payment Approval by PNR
- **Method**: PUT
- **URL**: `${protocol}://${serverName}:${port}${apiPath}/${PNR}/paymentApproval`
- **Headers**: 
  - Content-Type: application/json
  - Accept: application/json
- **Body**: JSON payload for payment approval
```json
{
  "paymentApproved": true,
  "payerID": "PAYER123456",
  "paymentID": "PAY-1AKD7482FAB9STATKO"
}
```

## How to Use

### Prerequisites
1. Ensure your MuleSoft API is running on `https://localhost:8081`
2. Make sure JMeter is installed on your system
3. The API should be accessible and responding to requests

### Running the Test Plan

1. **Open JMeter** and load the test plan file `Check-In-PAPI-JMeter-Test-Plan.jmx`

2. **Configure Variables** (if needed):
   - Double-click on "Test Plan" in the left panel
   - Modify the user-defined variables as needed:
     - Change `serverName` if your API is not running on localhost
     - Change `port` if your API is running on a different port
     - Change `PNR` to test with different passenger records

3. **Run the Test**:
   - Click the green "Start" button or press Ctrl+R
   - The test will execute both HTTP requests sequentially

4. **View Results**:
   - **View Results Tree**: Shows detailed information about each request/response
   - **Summary Report**: Provides a summary of test execution statistics

### Test Execution Details

- **Thread Group**: Single thread executing once
- **Loop Count**: 1 (each request runs once)
- **Ramp-up Time**: 1 second
- **No Assertions**: As requested, the test plan does not include any assertions

### Expected Results

#### Check-In by PNR Response
```json
{
  "paymentID": "PAY-1AKD7482FAB9STATKO"
}
```

#### Payment Approval by PNR Response
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

## Customization Options

### Modifying Test Data
1. **Change PNR**: Update the `PNR` variable in the Test Plan
2. **Modify Request Bodies**: Edit the JSON payloads in each HTTP request
3. **Add More Test Cases**: Duplicate existing requests and modify parameters

### Load Testing Configuration
To convert this functional test to a load test:
1. Increase the number of threads in the Thread Group
2. Adjust the ramp-up time for gradual load increase
3. Set loop count to run multiple iterations
4. Add a Constant Throughput Timer for controlled request rate

### Environment-Specific Configuration
For different environments, modify these variables:
- **Development**: `serverName=localhost`, `port=8081`
- **Staging**: `serverName=staging-server`, `port=443`
- **Production**: `serverName=api.production.com`, `port=443`

## Troubleshooting

### Common Issues
1. **Connection Refused**: Ensure the MuleSoft API is running
2. **SSL Certificate Issues**: For self-signed certificates, configure JMeter SSL settings
3. **404 Not Found**: Verify the API path and PNR values
4. **400 Bad Request**: Check the JSON payload format

### SSL Configuration
If using HTTPS with self-signed certificates:
1. Go to JMeter's SSL Manager (Options > SSL Manager)
2. Import your certificate or configure SSL settings
3. Alternatively, use HTTP for local testing

## File Structure
```
Check-In-PAPI-JMeter-Test-Plan.jmx          # Main JMeter test plan
JMeter-Test-Plan-Instructions.md            # This documentation file
```

## Notes
- This test plan is designed for functional testing without assertions
- Each HTTP request is self-contained and can be executed independently
- The test plan follows JMeter best practices for API testing
- All sensitive data (PNR, payment IDs) are test values and should be replaced for production testing
