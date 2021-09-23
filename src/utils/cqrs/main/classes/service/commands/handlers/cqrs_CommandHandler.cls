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
 * @description       : Command handler
 * @author            : Bill Anderson
 * @group             : CQRS
 * @last modified on  : 09-20-2021
 * @last modified by  : Bill Anderson
 * Modifications Log
 * Ver   Date         Author          Modification
 * 1.0   07-31-2021   Bill Anderson   Initial Version
 **/
@SuppressWarnings('PMD.ClassNamingConventions')
public abstract inherited sharing class cqrs_CommandHandler implements cqrs_ICommandHandler {

    /////////////////////////////////////////////////////////////
    // Data Members
    /////////////////////////////////////////////////////////////

    // Here is where one would bring in the other services to use by the handler
    //     :
    //     :
    // IUnitOfWork uow=null;
    // ICache cache=null;
    // IValidation validation=null;
    // IMapperEngine mapper=null;
    // IPerformance cmdPerf = null;

    /////////////////////////////////////////////////////////////
    // Ctors
    /////////////////////////////////////////////////////////////

    /**
     * @description cqrs_CommandHandler default ctor
     */
    public cqrs_CommandHandler() {

    }

    // This may be done by ctor injection or perhaps using a resolver for the information
    // However, this provides the ability to test the handler via mocks during Unit tests!
    //        :
    //
    // protected cqrs_CommandHandler(IUnitOfWork unitOfWork,
    //                       IValidation validator,
    //                       IMapperEngine mapEngine,
    //                       IPerformance perf) {
    //     //     this.uow = unitOfWork;
    //     //     this.validation = validator;
    //     //     this.mapper = mapEngine;
    //     //     this.cmdPerf = perf;

    // }

    public cqrs_ICommandResult execute(cqrs_ICommand command) {
        cqrs_ICommandResult result=null;
        cqrs_BaseCommand entityInformation = (cqrs_BaseCommand)command;
        try {
            this.log('+++++++++++++++++++++++++++++++++++++++++++');
            this.log('++ Command Name        :' + entityInformation.name());
            this.log('++ Command Guid        :' + entityInformation.guid());
            this.log('++ Command User Context:' + entityInformation.context());
            this.log('++ Command Environment :' + entityInformation.environment());
            // handle the command
            result = this.handle(command);
        } catch (Exception excp) {
            this.log('++ cqrs_CommandHandler Exception :' + excp.getMessage());
            result = new cqrs_CommandResult(excp);
        }
        return result;
    }// end of execute

    /////////////////////////////////////////////////////////////
    // Abstract
    /////////////////////////////////////////////////////////////
    // Children know how to handle their command
    public abstract cqrs_ICommandResult handle(cqrs_ICommand command);

    /////////////////////////////////////////////////////////////
    // Protected Methods
    /////////////////////////////////////////////////////////////

    /**
     * @description This is contrived -- you should have your own Cross Cutting Concern Logger
     *      here we did this for syntactic sugar ( for the children)
     * @param  message String
     */
    @TestVisible
    protected virtual Boolean log(String message){
        Boolean add = String.isNotBlank (message);
        if ( add ) {
            system.debug('+++' +message);
        }
        return add;
    }// end of log

}// end of cqrs_CommandHandler
