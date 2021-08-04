//
// Call a Service directly
//
Integer inx=1;
String serviceName='Customer Service';
String accountType = 'enterprise';
// get the service by name
cqrs_CustomerService service =  (cqrs_CustomerService) cqrs_ServiceProvider.newInstance().getService( serviceName);
// show some service information
System.debug('++++++++++++++++RESULTs++++++++++++++++++++++++++++');
System.debug('Service Name:' + service.name());
System.debug('Service Guid:' + service.guid());
System.debug('++++++++++++++++RECORDs++++++++++++++++++++++++++++');
//
// iterate over the results
//
for ( cqrs_AccountTypeRecordsDTO dto: service.findAccountRecordsByAccountType(accountType)) {
    System.debug('Service Result (' + inx++ + ') Name=' + dto.name);
}