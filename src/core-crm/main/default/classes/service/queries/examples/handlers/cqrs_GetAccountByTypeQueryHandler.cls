/**
 * BSD 3-Clause License
 *
 * Copyright (c) 2020-2021, Bill Anderson
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice, this
 * list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 * this list of conditions and the following disclaimer in the documentation
 * and/or other materials provided with the distribution.
 *
 * 3. Neither the name of the copyright holder nor the names of its
 * contributors may be used to endorse or promote products derived from
 * this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED.IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE .
 *
 * @description       : Get Account By Type Query Handler
 * @author            : Bill Anderson
 * @group             : Sample
 * @last modified on  : 09-08-2021
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
 * Modifications Log
 * Ver   Date         Author          Modification
 * 1.0   07-31-2021   Bill Anderson   Initial Version
 **/
public virtual inherited sharing class cqrs_GetAccountByTypeQueryHandler extends cqrs_QueryHandler {

    //////////////////////////////////////////////////////////////
    // Public Methods
    //////////////////////////////////////////////////////////////

    /**
     * @description handle cqrs_GetAccountByTypeQuery
     * @param  query cqrs_IQuery
     * @return cqrs_IQueryResult
     */
    public virtual override cqrs_IQueryResult handle(cqrs_IQuery query) {
        // note query inherits for cqrs_BaseQuery, if needed user information, etc.
        // cqrs_BaseQuery entityInformation = (BaseQuery)query;
        cqrs_IQueryResult result = null;
        try {
            cqrs_GetAccountByTypeQuery accountTypeQuery = (cqrs_GetAccountByTypeQuery)query;
            super.log('++ cqrs_GetAccountByTypeQuery.theUserAccountType  :' + accountTypeQuery.theUserAccountType());

            // Here is where we may check the following:
            /*
                 (a) Cache -- using the base class functionality

                 (1) permissions
                 (2) validation of the input (namely, "theUserAccountType")
                 (3) Using a Repository/Selector (i.e. Account) to extract the data
                 (4) After the query we may need to use a Map Engine to convert to expect results
             */
            list<Object> data = this.getFromAccountRepository(accountTypeQuery.theUserAccountType());
            //
            // Do whatever processing is needed. Take the data from this command
            // and process it accordingly. This is where you would take the Domain
            // data and use it either to perform some task or update/insert into
            // a Sink. The base handler would have a validator, mapper, unit-of-work etc.
            //
            result = new cqrs_QueryResult(data!=null,data);
        } catch (Exception excp) {
            super.log('++ cqrs_GetAccountByTypeQuery Exception  :' + excp.getMessage());
            result = new cqrs_QueryResult(excp);
        }
        return result;
    } // end of handle

    /**
     * @description get From Account Repository
     *
     *    We would either ask a resolver for a Repo or Selector either passing in the type or query
     *    The repo/selector would then execute the call and return back our values. If we are good with the
     *    raw form, send it allong; otherwise, we map the results to the return type
     *
     * @param  acctTypeValue String
     * @return  List<cqrs_AccountTypeRecordsDTO>
     */
    @TestVisible
    protected List<cqrs_AccountTypeRecordsDTO> getFromAccountRepository(String acctTypeValue) {
        List<Account> accts=null;
        try {
            // note, not putting in limit -- could if you wanted.SELECT  FROM Account
            accts=[select id,name,type,industry from account where type=: acctTypeValue WITH SECURITY_ENFORCED ];
        } catch(Exception excp) {
            accts = new   List<Account>();
            super.log(excp.getStackTraceString());
        }
        // convert to proper type
        return this.findMapEngineAndConvert(accts);
    }

    /**
     * @description findMapEngineAndConvert
     * @param  fromValue  we would have the from value and to type
     * @return List<cqrs_AccountTypeRecordsDTO>
     */
    @TestVisible
    protected List<cqrs_AccountTypeRecordsDTO> findMapEngineAndConvert(List<Account> fromValue ) {
        List<cqrs_AccountTypeRecordsDTO> result = new List<cqrs_AccountTypeRecordsDTO>();

        for ( Account repoAccount: fromValue) {
            result.add( new cqrs_AccountTypeRecordsDTO(repoAccount.id
                                                       ,repoAccount.name
                                                       ,repoAccount.type
                                                       ,repoAccount.industry));
        }
        return result;
    }// end of findMapEngineAndConvert
}// end of cqrs_GetAccountByTypeQueryHandler
