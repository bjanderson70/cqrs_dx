// set up / arrange
List<cqrs_IQuery> queries = new List<cqrs_IQuery> {
    // get account by type ()
    new cqrs_GetAccountByTypeQuery('Enterprise')
};
Integer inx=1;
// act
cqrs_IQueryResult result= new cqrs_QueryDispatcher().dispatch(queries);
// results
System.debug('++++++++++++++++RESULTs++++++++++++++++++++++++++++');
System.debug('Query(s) Result Successful ?:' + result.success());
System.debug('Query(s) Result Count Found :' + result.results().size());
System.debug('Query(s) Result Searched for: "' + ((cqrs_GetAccountByTypeQuery)queries[0]).theUserAccountType() + '"' );
System.debug('++++++++++++++++RECORDs++++++++++++++++++++++++++++');
// iterate over the results
if ( result.results().size() > 0 ) {
    for ( cqrs_AccountTypeRecordsDTO dto: (List<cqrs_AccountTypeRecordsDTO>)result.results() ) {
        System.debug('Query Result (' + inx++ + ') Name=' +  dto.name);
    }
} else {
    System.debug('Query Result None Found' );
}