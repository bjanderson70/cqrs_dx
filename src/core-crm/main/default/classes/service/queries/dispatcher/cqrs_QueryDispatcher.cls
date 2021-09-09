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
 * @description       : Query Dispatcher
 * @author            : Bill Anderson
 * @group             : CQRS
 * @last modified on  : 08-07-2021
 * @last modified by  : Bill Anderson
 * Modifications Log
 * Ver   Date         Author          Modification
 * 1.0   07-31-2021   Bill Anderson   Initial Version
 **/
public virtual inherited sharing class cqrs_QueryDispatcher implements cqrs_IQueryDispatcher {


    /////////////////////////////////////////////////////////
    // Ctor
    /////////////////////////////////////////////////////////
    /**
     * @description cqrs_QueryDispatcher default ctor
     */
    public cqrs_QueryDispatcher() {
        this.resolver = new cqrs_QueryHandlerResolver();
    }

    /////////////////////////////////////////////////////////
    // Protected Properties
    /////////////////////////////////////////////////////////
    /**
     * @description resolver
     * @return cqrs_QueryHandlerResolver
     */
    @TestVisible
    protected cqrs_QueryHandlerResolver resolver {
        get;  set;
    }

    /////////////////////////////////////////////////////////
    // Public Methods
    /////////////////////////////////////////////////////////
    /**
     * @description dispatch query via handler
     * @param  query cqrs_IQuery to process
     * @return cqrs_IQueryResult
     */
    public virtual cqrs_IQueryResult dispatch(cqrs_IQuery query) {
        cqrs_IQueryResult result=null;

        try {
            cqrs_IQueryHandler handler =   this.resolver.resolve(query);
            result= handler.retrieve(query);
        } catch(Exception excp) {
            result = new cqrs_QueryResult(excp);
        }
        return result;

    }// end of dispatch
    /**
     * @description dispatch command via handler
     * @param  command List<cqrs_IQuery> to process
     * @return cqrs_IQueryResult
     */
    public virtual cqrs_IQueryResult dispatch(List<cqrs_IQuery> queries) {
        cqrs_IQueryResult result=null;

        try {
            List<cqrs_IQueryHandler> ourQueryHandlers = this.getHandlers(queries);
            integer index=0;
            for ( cqrs_IQueryHandler handler : ourQueryHandlers ) {
                // execute the Query
                result= handler.retrieve(queries[index++]);
                if ( false == result.success() ) {
                    break;
                }
            }
        } catch(Exception excp) {
            result = new cqrs_QueryResult(excp);
        }
        // protected against empty queries
        return result==null ? new cqrs_QueryResult(): result;

    } // end of dispatch
    /////////////////////////////////////////////////////////
    // Protected Methods
    /////////////////////////////////////////////////////////
    /**
     * @description getHandlers description
     * @param  Querys queries description
     * @return return description
     */
    @TestVisible
    protected virtual List<cqrs_IQueryHandler> getHandlers(List<cqrs_IQuery> queries) {
        List<cqrs_IQueryHandler> cqrs_QueryHandlers = new List<cqrs_IQueryHandler>();

        for ( cqrs_IQuery query : queries ) {
            cqrs_QueryHandlers.add(this.resolver.resolve(query));
        }
        return cqrs_QueryHandlers;
    }// end of getHandlers
}// end of cqrs_QueryDispatcher