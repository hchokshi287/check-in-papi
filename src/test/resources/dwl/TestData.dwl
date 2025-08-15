var testPNR = "XYZ123"
var requestPayload = readUrl("classpath://dwl/check-in-by-pnr-request.json", "application/json")
var responsePayload = {"paymentID": "PAY-1AKD7482FAB9STATKO"}
var mockPayload = requestPayload
var mockPayloadEmpty = {}
var mockPayloadFMS = {response: "mocked FMS"}
var mockPayloadRPD = mockPayloadEmpty
var mockPayloadCPB = mockPayloadEmpty

