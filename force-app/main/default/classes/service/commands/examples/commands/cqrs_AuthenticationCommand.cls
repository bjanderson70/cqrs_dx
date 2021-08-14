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
 * @description       : Authenticate Command
 * @author            : Bill Anderson
 * @group             : Sample-Commands
 * @last modified on  : 08-14-2021
 * @last modified by  : Bill Anderson
 * Modifications Log
 * Ver   Date         Author          Modification
 * 1.0   07-31-2021   Bill Anderson   Initial Version
 **/
public virtual inherited sharing class cqrs_AuthenticationCommand extends cqrs_BaseCommand {

    //////////////////////////////////////////////////////
    // Data Members
    //////////////////////////////////////////////////////
    // the password
    String thePassword;
    // the user information
    String userInformation;

    //////////////////////////////////////////////////////
    // Ctors
    //////////////////////////////////////////////////////
    /**
     * @description cqrs_AuthenticationCommand (default ctor)
     */
    public cqrs_AuthenticationCommand( ) {
        super();
        this.userId(null);
        this.password(null);
    }
    /**
     * @description cqrs_AuthenticationCommand
     * @param  userName String
     * @param  pwd   String
     */
    public cqrs_AuthenticationCommand(String userName, String pwd) {
        super();
        this.userId(userName);
        this.password(pwd);
    }

    //////////////////////////////////////////////////////
    // Public Methods
    //////////////////////////////////////////////////////
    /**
     * @description userId
     * @return String user-id
     */
    public String userId() {
        return this.userInformation;
    }
    /**
     * @description password
     * @return   return password
     */
    public String password() {
        return this.thePassword;
    }
    /**
     * @description componentType
     * @return  Type
     */
    public virtual override Type componentType() {
        return cqrs_AuthenticationCommand.class;
    }
    //////////////////////////////////////////////////////
    // Protected
    //////////////////////////////////////////////////////
    /**
     * @description password setter
     * @param  pwd String
     */
    @Testvisible
    protected void password(String pwd) {
        this.thePassword=pwd;
    }
    /**
     * @description userId setter
     * @param  id silly string id
     */
    @Testvisible
    protected void userId(String id) {
        this.userInformation=id;
    }
} // end of cqrs_AuthenticationCommand