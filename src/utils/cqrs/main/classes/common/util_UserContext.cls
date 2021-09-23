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
 * @description       : User Context
 * @author            : Bill Anderson
 * @group             : Utilities
 * @last modified on  : 09-20-2021
 * @last modified by  : Bill Anderson
 * Modifications Log
 * Ver   Date         Author          Modification
 * 1.0   07-31-2021   Bill Anderson   Initial Version
 **/
@SuppressWarnings('PMD.ClassNamingConventions,sf:TooManyMethods')
public virtual inherited sharing class util_UserContext implements util_IUserContext {

    //////////////////////////////////////////////////
    // Data Member
    //////////////////////////////////////////////////
    // Simple Indexes
    @TestVisible
    static final String FIRSTNAME_ID = 'firstname',
                        LASTNAME_ID = 'lastname',
                        PROFILE_ID = 'profileid',
                        ORD_ID = 'orgId',
                        ROLE_ID = 'roleId',
                        USER_ID = 'userId';
    // holds user context
    Map<String,String> content = new Map<String,String>();

    //////////////////////////////////////////////////
    // Ctors
    //////////////////////////////////////////////////
    /**
     * @description util_IUserContext default ctor
     */
    public util_UserContext() {
        // roles may not be set
        final String setRoleId = UserInfo.getUserRoleId(),
                     roleId = String.isBlank(setRoleId) ? '' : setRoleId;

        String fname = UserInfo.getFirstName();
        content.put(ORD_ID,UserInfo.getOrganizationId());
        content.put(PROFILE_ID,UserInfo.getProfileId());
        content.put(USER_ID,UserInfo.getUserId());
        content.put(LASTNAME_ID,UserInfo.getLastName());
        if ( string.isBlank(fname)){
            fname='';
        }
        content.put(FIRSTNAME_ID,fname);

        content.put(ROLE_ID,roleId);
    }
    //////////////////////////////////////////////////
    // Public Methods
    //////////////////////////////////////////////////

    public String profileId() {
        return this.content.get(PROFILE_ID);
    }
    public String roleId() {
        return this.content.get(ROLE_ID);
    }
    public String firstname() {
        return this.content.get(FIRSTNAME_ID);
    }
    public String lastname() {
        return this.content.get(LASTNAME_ID);
    }
    public String userId() {
        return this.content.get(USER_ID);
    }
    public String orgId() {
        return this.content.get(ORD_ID);
    }
    //////////////////////////////////////////
    // Protected Methods (Setters)
    //////////////////////////////////////////
    @TestVisible
    protected void  profileId(String value) {
        this.content.put(PROFILE_ID,value);
    }
    @TestVisible
    protected void  roleId(String value) {
        this.content.put(ROLE_ID,value);
    }
    @TestVisible
    protected void  firstname(String value) {
        this.content.put(FIRSTNAME_ID,value);
    }
    @TestVisible
    protected void  lastname(String value) {
        this.content.put(LASTNAME_ID,value);
    }
    @TestVisible
    protected void  userId(String value) {
        this.content.put(USER_ID,value);
    }
    @TestVisible
    protected void  orgId(String value) {
        this.content.put(ORD_ID,value);
    }
}// end of util_UserContext