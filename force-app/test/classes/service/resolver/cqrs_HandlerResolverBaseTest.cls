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
 * @description       : Test cqrs_Result Functionality
 * @author            : Bill Anderson
 * @group             : Test
 * @last modified on  : 08-14-2021
 * @last modified by  : Bill Anderson
 * Modifications Log
 * Ver   Date         Author          Modification
 * 1.0   01-09-2021   Bill Anderson   Initial Version
 **/
@SuppressWarnings('sf:UseLocaleWithCaseConversions')
@isTest(OnInstall=true)
private class cqrs_HandlerResolverBaseTest {

    //////////////////////////////////////////////////////////////////
    // Unit Tests
    //////////////////////////////////////////////////////////////////

    /**
     * @description resolve  Test
     */
    @isTest
    static void resolveTest() {
        // arrange
        cqrs_HandlerResolverBase base = new cqrs_HandlerResolverBase();
        // act / assert
        system.assertNotEquals(null, base.resolve('cqrs_GetAccountByTypeQuery',
                                                  cqrs_Resolver.CommandRequestTypeEnum.QUERY));
        system.assertNotEquals(null, base.resolve ('cqrs_AuthenticationCommand',
                                                   cqrs_Resolver.CommandRequestTypeEnum.COMMAND));
        system.assertEquals(null, base.resolve ('Nothing',
                                                cqrs_Resolver.CommandRequestTypeEnum.COMMAND));
        system.assertEquals(null, base.resolve ('NothingAgain',
                                                cqrs_Resolver.CommandRequestTypeEnum.QUERY));


    }

    @isTest
    static void ensureCorrectHandlerNameTest() {
        // arrange
        cqrs_HandlerResolverBase base = new cqrs_HandlerResolverBase();
        // act / assert
        system.assertEquals('cqrs_GetAccountByTypeQueryHandler',
                            base.ensureCorrectHandlerName('cqrs_GetAccountByTypeQuery'));
        system.assertEquals('',
                            base.ensureCorrectHandlerName(''));
    }
    @isTest
    static void getResolverTest() {
        // arrange
        cqrs_HandlerResolverBase base = new cqrs_HandlerResolverBase();
        system.assertNotEquals(null,
                               base.getResolver());
    }

}// end of cqrs_HandlerResolverBaseTest