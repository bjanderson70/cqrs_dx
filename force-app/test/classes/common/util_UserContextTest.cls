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
 * @description       : Test UserContext Functionality
 * @author            : Bill Anderson
 * @group             : Test
 * @last modified on  : 08-27-2021
 * @last modified by  : Bill Anderson
 * Modifications Log
 * Ver   Date         Author          Modification
 * 1.0   12-12-2020   Bill Anderson   Initial Version
 **/

@isTest(OnInstall=true)
private class util_UserContextTest {

    /////////////////////////////////////////////////////
    // Unit Tests
    /////////////////////////////////////////////////////
    @isTest
    static void ctorTest() {
        // arrange
        final Boolean expected = true;
        // act
        final util_UserContext context = new util_UserContext();
        // assert
        system.assertEquals(expected, context.profileId() != null);
        system.assertEquals(expected, context.roleId() != null);
        system.assertEquals(expected, context.firstname() != null);
        system.assertEquals(expected, context.lastname() != null);
        system.assertEquals(expected, context.userId() != null);
        system.assertEquals(expected, context.orgId() != null);

    }

    @isTest
    static void setterTest() {
        // arrange
        final util_UserContext context = new util_UserContext();
        // act
        context.profileId(util_UserContext.PROFILE_ID);
        context.roleId(util_UserContext.ROLE_ID);
        context.firstname(util_UserContext.FIRSTNAME_ID);
        context.lastname(util_UserContext.LASTNAME_ID);
        context.userId(util_UserContext.USER_ID);
        context.orgId(util_UserContext.ORD_ID);

        // assert
        system.assertEquals(util_UserContext.PROFILE_ID, context.profileId() );
        system.assertEquals(util_UserContext.ROLE_ID, context.roleId() );
        system.assertEquals(util_UserContext.FIRSTNAME_ID, context.firstname() );
        system.assertEquals(util_UserContext.LASTNAME_ID, context.lastname() );
        system.assertEquals(util_UserContext.USER_ID, context.userId() );
        system.assertEquals(util_UserContext.ORD_ID, context.orgId() );

    }
} // end of util_UserContextTest