List<cqrs_ICommand> commands = new List<cqrs_ICommand> {
    new cqrs_AuthenticationCommand('test-uid','test-password'),
    new cqrs_WriteResultCommand('test-id')
};
cqrs_ICommandResult result= new cqrs_CommandDispatcher().dispatch(commands);
System.debug('++++++++++++++++RESULTs++++++++++++++++++++++++++++');
System.debug('Command(s) Result Successful?:' + result.success());
System.debug('Command(s) Result:' + result);