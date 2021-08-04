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
 * @description       : Base Service
 * @author            : Bill Anderson
 * @group             : CQRS
 * @last modified on  : 08-03-2021
 * @last modified by  : Bill Anderson
 * Modifications Log
 * Ver   Date         Author          Modification
 * 1.0   07-31-2021   Bill Anderson   Initial Version
 **/
public virtual inherited sharing class cqrs_BaseService extends cqrs_BaseQueryAndCommandContext implements cqrs_IService {


    ////////////////////////////////////////////////////////////////////
    // Ctors (Protected)
    ////////////////////////////////////////////////////////////////////

    /**
     * @description cqrs_BaseService default ctor
     */
    @TestVisible
    protected cqrs_BaseService() {
        super(null,null);
    }
    /**
     * @description cqrs_BaseService  ctor
     * @param util_IUserContext user context
     */
    @TestVisible
    protected cqrs_BaseService(util_IUserContext usrContext) {
        super(usrContext,null);
    }
    /**
     * @description cqrs_BaseServiceAndCommandContext  ctor
     * @param util_IUserContext user context
     * @param usrEnvironment String user runtime environment
     */
    @TestVisible
    protected cqrs_BaseService( util_IUserContext usrContext, String usrEnvironment) {
        super(usrContext,usrEnvironment);
    }
    ////////////////////////////////////////////////////////////////////
    // Public Methods
    ////////////////////////////////////////////////////////////////////

    /////////////////////////////////
    // Getters
    /////////////////////////////////
    /**
     * @description componentType - children SHOULD override the component type
     * @return Type class type
     */
    public virtual override Type componentType() {
        return cqrs_BaseService.class;
    }

    ////////////////////////////////////////////////////////////////////
    // Protected Methods
    ////////////////////////////////////////////////////////////////////

    /**
     * @description log
     * @param  message message
     * @return true if logged
     */
    @TestVisible
    protected virtual Boolean log(String message) {
        Boolean add = message != null;
        if ( add ) {
            system.debug('++' + message);
        }
        return add;
    } // end of log


}// end of cqrs_BaseService