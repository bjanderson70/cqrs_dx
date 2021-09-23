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
 * @description       : Authentication -- contrived example
 * @author            : Bill Anderson
 * @group             : Sample
 * @last modified on  : 09-20-2021
 * @last modified by  : Bill Anderson
 * Modifications Log
 * Ver   Date         Author          Modification
 * 1.0   07-31-2021   Bill Anderson   Initial Version
 **/
@SuppressWarnings('PMD.ClassNamingConventions')
public virtual inherited sharing class cqrs_AuthenticationCommandHandler extends cqrs_CommandHandler {

    //////////////////////////////////////////////////////////////
    // Public Methods
    //////////////////////////////////////////////////////////////

    /**
     * @description handle all the necessary things the command needs to do
     * @param  command cqrs_ICommand
     * @return cqrs_ICommandResult
     */
    public virtual override cqrs_ICommandResult handle(cqrs_ICommand command) {
        // note command inherits for cqrs_BaseCommand, if needed user information, etc.
        // cqrs_BaseCommand entityInformation = (cqrs_BaseCommand)command;
        cqrs_ICommandResult result = null;
        try {
            cqrs_AuthenticationCommand authCommand = (cqrs_AuthenticationCommand)command;
            //=============================================================
            super.log('++ cqrs_AuthenticationCommand.Username    :' + authCommand.userId());
            super.log('++ cqrs_AuthenticationCommand.Password    :' + authCommand.password());
            //
            // Do whatever processing is needed. Take the data for this command
            // and process it accordingly. This is where you would take the Domain
            // data and use it either to perform some task or update/insert into
            // a Sink. The base would have a validator, mapper, unit-of-work etc.
            //
            result = new cqrs_CommandResult();
        } catch (Exception excp) {
            super.log('++ cqrs_AuthenticationCommand Exception    :' + excp.getMessage());
            result = new cqrs_CommandResult(excp);
        }
        return result;
    }// end of handle
}// end of cqrs_AuthenticationCommandHandler