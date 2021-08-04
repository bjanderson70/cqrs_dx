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
 * @description       : Test Authenticate Command Sample
 * @author            : Bill Anderson
 * @group             : Test
 * @last modified on  : 08-03-2021
 * @last modified by  : Bill Anderson
 * Modifications Log
 * Ver   Date         Author          Modification
 * 1.0   07-31-2021   Bill Anderson   Initial Version
 **/
@isTest(OnInstall=true)
private class cqrs_AuthenticationCommandTest {


    //////////////////////////////////////////////////////
    // Test Data
    //////////////////////////////////////////////////////
    static final String UID = 'uid';
    static final String PWD = 'pwd';
    //////////////////////////////////////////////////////
    // Unit Tests
    //////////////////////////////////////////////////////
    @isTest
    static void ctorTest() {
        // arrange / act
        cqrs_AuthenticationCommand command = new cqrs_AuthenticationCommand(UID,PWD);
        // assert
        system.assertEquals(UID, command.userId());
        system.assertEquals(PWD, command.password());

    }

    @isTest
    static void getterSetterTest() {
        // arrange / act
        final String EXPECTED_UID = UID + '1';
        final String EXPECTED_PWD = PWD + '1';

        cqrs_AuthenticationCommand command = new cqrs_AuthenticationCommand(UID,PWD);
        // assert
        system.assertEquals(UID, command.userId());
        system.assertEquals(PWD, command.password());
        // act
        command.userId(EXPECTED_UID);
        command.password(EXPECTED_PWD);
        // assert
        system.assertEquals(EXPECTED_UID, command.userId());
        system.assertEquals(EXPECTED_PWD, command.password());

    }
} // end of cqrs_AuthenticationCommand