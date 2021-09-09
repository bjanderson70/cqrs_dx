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
 * @description       : Base Class for Query and Command Context
 * @author            : Bill Anderson
 * @group             : Core
 * @last modified on  : 08-28-2021
 * @last modified by  : Bill Anderson
 * Modifications Log
 * Ver   Date         Author          Modification
 * 1.0   08-02-2021   Bill Anderson   Initial Version
 **/
public abstract inherited sharing class cqrs_BaseQueryAndCommandContext implements cqrs_IEntityIdentifier {

    ////////////////////////////////////////////////////////////////////
    // Data Members
    ////////////////////////////////////////////////////////////////////
    /*
     * Private Data Members
     */
    //query or command name
    String theName;
    // query of command unique id
    String theGuid;
    // query or command type
    Type theType;
    // runtime environment
    String theEnvironment;
    // user context
    util_IUserContext theUserContext;

    ////////////////////////////////////////////////////////////////////
    // Ctors [Protected]
    ////////////////////////////////////////////////////////////////////

    /**
     * @description cqrs_BaseQueryAndCommandContext default ctor
     */
    @TestVisible
    protected cqrs_BaseQueryAndCommandContext() {
        this(null,null);
    }
    /**
     * @description cqrs_BaseQueryAndCommandContext  ctor
     * @param util_IUserContext user context
     */
    @TestVisible
    protected cqrs_BaseQueryAndCommandContext(util_IUserContext usrContext) {
        this(usrContext,null);
    }
    /**
     * @description cqrs_BaseQueryAndCommandContext  ctor
     * @param util_IUserContext user context
     * @param usrEnvironment String user runtime environment
     */
    @TestVisible
    protected cqrs_BaseQueryAndCommandContext( util_IUserContext usrContext, String usrEnvironment) {
        this.theGuid = util_MiscHelpers.newGuid();
        this.environment(usrEnvironment);
        this.context(usrContext);
        this.name(this.componentType().getName());
    }

    ///!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    // Public Methods (ABSTRACT)
    ///!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    // fource children to provide their type
    public abstract Type componentType();

    ////////////////////////////////////////////////////////////////////
    // Public Methods
    ////////////////////////////////////////////////////////////////////

    /////////////////////////////////
    // Getters
    /////////////////////////////////
    /**
     * @description guid
     * @return   return unique string id
     */
    public String guid() {
        return this.theGuid;
    }
    /**
     * @description class name
     * @return   return string class name
     */
    public String name() {
        return this.theName;
    }
    /**
     * @description environment (Test,Debug, Production, All)
     * @return String runtime environment
     */
    public String environment() {
        return this.theEnvironment;
    }
    /**
     * @description user context
     * @return util_IUserContext (Abstraction of User Information)
     */
    public util_IUserContext context() {
        return this.theUserContext;
    }
    /////////////////////////////////
    // Setters
    /////////////////////////////////
    /**
     * @description context of user
     * @param  ctx util_IUserContext
     */
    public void context(util_IUserContext usrCtx){
        this.theUserContext = usrCtx == null ? util_UserContextSettings.newInstance().getUserContext() : usrCtx;
    }
    ////////////////////////////////////////////////////////////////////
    // Protected Methods
    ////////////////////////////////////////////////////////////////////
    /**
     * @description name of class
     * @param  clsName class Name
     */
    @TestVisible
    protected void name(String clsName) {
        this.theName = clsName==null? cqrs_BaseQueryAndCommandContext.class.getname() : clsName;
    }
    /**
     * @description environment  (Test,Debug, Production, All)
     * @param  env String runtime Environment
     */
    @TestVisible
    protected void environment(String env) {
        String environ = string.isBlank(env) ? util_MiscHelpers.getEnvironment() : util_MiscHelpers.ensureEnviromentIsCorrectOtherwiseDebug(env);
        this.theEnvironment=environ;
    }


}// end of cqrs_BaseQueryAndCommandContext