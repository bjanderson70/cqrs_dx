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
 * @description       : Command Dispatcher
 * @author            : Bill Anderson
 * @group             : CQRS
 * @last modified on  : 08-07-2021
 * @last modified by  : Bill Anderson
 * Modifications Log
 * Ver   Date         Author          Modification
 * 1.0   07-31-2021   Bill Anderson   Initial Version
 **/
public virtual inherited sharing class cqrs_CommandDispatcher implements cqrs_ICommandDispatcher {


    /////////////////////////////////////////////////////////
    // Ctor
    /////////////////////////////////////////////////////////
    /**
     * @description cqrs_CommandDispatcher defualt ctor
     */
    public cqrs_CommandDispatcher() {
        this.resolver = new cqrs_CommandHandlerResolver();
    }
    /////////////////////////////////////////////////////////
    // Protected Properties
    /////////////////////////////////////////////////////////
    /**
     * @description resolver
     * @return cqrs_CommandHandlerResolver
     */
    @TestVisible
    protected cqrs_CommandHandlerResolver resolver {
        get;  set;
    }
    /////////////////////////////////////////////////////////
    // Public Methods
    /////////////////////////////////////////////////////////

    /**
     * @description dispatch command via handler
     * @param  command cqrs_ICommand to process
     * @return cqrs_ICommandResult
     */
    public virtual cqrs_ICommandResult dispatch(cqrs_ICommand command) {
        cqrs_ICommandResult result=null;

        try {
            cqrs_ICommandHandler handler =   this.resolver.resolve(command);
            result= handler.execute(command);
        } catch(Exception excp) {
            result = new cqrs_CommandResult(excp);
        }
        return result;

    }// end of dispatch

    /**
     * @description dispatch command via handler
     * @param  command List<cqrs_ICommand> to process
     * @return cqrs_ICommandResult
     */
    public virtual cqrs_ICommandResult dispatch(List<cqrs_ICommand> commands) {
        cqrs_ICommandResult result=null;

        try {
            List<cqrs_ICommandHandler> ourCommandHandlers = this.getHandlers(commands);
            integer index=0;
            // iterate over the commands --
            // This could be done better -- TBD
            for ( cqrs_ICommandHandler handler : ourCommandHandlers ) {
                // execute the command
                result= handler.execute(commands[index++]);
                // were we successful
                if ( false == result.success() ) {
                    break;
                }
            }
        } catch(Exception excp) {
            result = new cqrs_CommandResult(excp);
        }
        // empty  commands , result could be null
        return result==null ? new cqrs_CommandResult() : result;

    } // end of dispatch

    /////////////////////////////////////////////////////////
    // Protected Methods
    /////////////////////////////////////////////////////////
    /**
     * @description get command Handlers
     * @param  commands List<cqrs_ICommand>
     * @return List<cqrs_ICommandHandler>
     */
    @TestVisible
    protected virtual List<cqrs_ICommandHandler> getHandlers(List<cqrs_ICommand> commands) {
        List<cqrs_ICommandHandler> cqrs_CommandHandlers = new List<cqrs_ICommandHandler>();

        for ( cqrs_ICommand command : commands ) {
            cqrs_CommandHandlers.add(this.resolver.resolve(command));
        }
        return cqrs_CommandHandlers;
    }// end of getHandlers
}// end of cqrs_CommandDispatcher