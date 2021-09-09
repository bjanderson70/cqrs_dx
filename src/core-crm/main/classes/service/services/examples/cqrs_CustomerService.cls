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
 * @description       : Customer Service
 * @author            : Bill Anderson
 * @group             : Sample
 * @last modified on  : 09-09-2021
 * @last modified by  : Bill Anderson
 * Modifications Log
 * Ver   Date         Author          Modification
 * 1.0   08-03-2021   Bill Anderson   Initial Version
 **/
public virtual inherited sharing class cqrs_CustomerService extends cqrs_BaseService {

    /////////////////////////////////////////////////////////
    // Data Members
    /////////////////////////////////////////////////////////

    cqrs_IResult lastResult=null;
    /////////////////////////////////////////////////////////
    // Ctors
    /////////////////////////////////////////////////////////

    /**
     * @description cqrs_CustomerService default ctor
     */
    public cqrs_CustomerService() {
        super();
    }

    /////////////////////////////////////////////////////////
    // Public Methods
    /////////////////////////////////////////////////////////
    /**
     * @description last Service Result
     * @return cqrs_IResult
     */
    public cqrs_IResult lastServiceResult() {
        return this.lastResult;
    }
    /**
     * @description find Account Records ByAccount Type
     * @param  acctType String Account Type Name
     * @return List<cqrs_AccountTypeRecordsDTO>
     */
    public virtual List<cqrs_AccountTypeRecordsDTO> findAccountRecordsByAccountType(String acctType) {
        cqrs_IQueryResult result=null;
        List<cqrs_AccountTypeRecordsDTO> data=null;
        // valid name
        if ( string.isBlank(acctType)) {
            // may not want to throw, so set state and return empty results
            this.lastServiceResult(new cqrs_QueryResult(new NullPointerException()));
            return new List<cqrs_AccountTypeRecordsDTO>();
        }
        try {
            // set up / arrange
            List<cqrs_IQuery> queries = new List<cqrs_IQuery> {
                // get account by type ()
                new cqrs_GetAccountByTypeQuery(acctType)
            };

            // act
            result= new cqrs_QueryDispatcher().dispatch(queries);
            // could have call a projector to map correct representation
            // cast to expect result
            data= (List<cqrs_AccountTypeRecordsDTO>)result.results();

        } catch(Exception excp) {
            result= new cqrs_QueryResult (excp);

            data = new List<cqrs_AccountTypeRecordsDTO>();
            // in order fr this to work, had to move
            // the log to the parent and not the parent of the parent!
            super.log(excp.getMessage());
        }
        // remember last result
        this.lastServiceResult(result);
        return data;
    }// end of findAccountRecordsByAccountType

    /**
     * @description component Type
     * @return  Type
     */
    public virtual override Type componentType() {
        return cqrs_CustomerService.class;
    }

    /////////////////////////////////////////////////////////////////
    // Protected  Methods
    /////////////////////////////////////////////////////////////////
    /**
     * @description last Service Result
     * @param  result cqrs_IResult
     */
    @TestVisible
    protected void lastServiceResult(cqrs_IResult result) {
        this.lastResult=result;
    }
}// end of cqrs_CustomerService