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
 * @description       : Query Handler
 * @author            : Bill Anderson
 * @group             : CQRS
 * @last modified on  : 08-27-2021
 * @last modified by  : Bill Anderson
 * Modifications Log
 * Ver   Date         Author          Modification
 * 1.0   07-31-2021   Bill Anderson   Initial Version
 **/
public abstract inherited sharing class cqrs_QueryHandler implements cqrs_IQueryHandler {

    /////////////////////////////////////////////////////////////
    // Data Members
    /////////////////////////////////////////////////////////////

    // IUnitOfWork uow=null;
    // IValidation validation=null;
    // IMapperEngine mapper=null;
    // IPerformance cmdPerf = null;
    // ICache cache = null;

    /////////////////////////////////////////////////////////////
    // Ctors
    /////////////////////////////////////////////////////////////
    /*
     * Default ctor
     */
    public cqrs_QueryHandler() {

    }

    // public cqrs_QueryHandler(IUnitOfWork unitOfWork,
    //                       IValidation validator,
    //                       IMapperEngine mapEngine,
    //                       IPerformance perf) {
    //     //     this.uow = unitOfWork;
    //     //     this.validation = validator;
    //     //     this.mapper = mapEngine;
    //     //     this.cmdPerf = perf;
    //     //     this.cache = some-cache interface

    // }
    public cqrs_IQueryResult retrieve(cqrs_IQuery query){
        cqrs_IQueryResult result=null;
        try {
            result = this.handle(query);
        } catch (Exception excp) {
            result = new cqrs_QueryResult(excp);
        }
        return result;
    }

    /////////////////////////////////////////////////////////////
    // Abstract
    /////////////////////////////////////////////////////////////
    // Children know how to handle their query
    public abstract cqrs_IQueryResult handle(cqrs_IQuery query);

    /////////////////////////////////////////////////////////////
    // Protected Methods
    /////////////////////////////////////////////////////////////

    /**
     * @description This would be you Cross Cutting Concern Logger
     *      here we did this for syntactic sugar ( for the children)
     * @param  message message description
     */
    @TestVisible
    protected virtual Boolean log(String message){
        Boolean add=string.isNotBlank(message);
        if ( add ) {
            system.debug('+++QueryHandler:' +message);
        }
        return add;
    }
}// end of cqrs_QueryHandler