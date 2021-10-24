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
 * @description       : cqrs_GetAccountByTypeQuery Handler Test
 * @author            : Bill Anderson
 * @group             : CQRS
 * @last modified on  : 09-09-2021
 * @last modified by  : Bill Anderson
 * Modifications Log
 * Ver   Date         Author          Modification
 * 1.0   07-31-2021   Bill Anderson   Initial Version
 **/
@TestVisible
@isTest(OnInstall=true)
private class cqrs_GetAccountByTypeQueryHandlerTest {
    /////////////////////////////////////////////////////////////
    // Data Members
    /////////////////////////////////////////////////////////////
    static final String ENTERPISE_ID = 'Enterprise';
    /////////////////////////////////////////////////////////////
    // Mock
    /////////////////////////////////////////////////////////////
    @SuppressWarnings('sf:ConfusingTernary')
    public class cqrs_GetAccountByTypeQueryHandlerMock extends cqrs_GetAccountByTypeQueryHandler {

        public override cqrs_IQueryResult handle(cqrs_IQuery query) {
            return query != null ? new cqrs_QueryResult() : new cqrs_QueryResult(new NullPointerException());
        }
    }
    /////////////////////////////////////////////////////////////
    // Unit Tests
    /////////////////////////////////////////////////////////////

    @isTest
    static void ctorTest() {
        // arrange/act/asset
        system.assertNotEquals(null, new cqrs_GetAccountByTypeQueryHandlerMock());
    }



    @isTest
    static void retrieveTest(){
        // arrange
        cqrs_QueryHandler handler = new cqrs_GetAccountByTypeQueryHandler();
        cqrs_IQuery query= new cqrs_GetAccountByTypeQuery(ENTERPISE_ID);
        // add data
        cqrs_GetAccountByTypeQueryHandlerTest.addAccountData();
        // act  / assert
        system.assertNotEquals(null, handler.retrieve(query));

    }
    @isTest
    static void handleTest(){
        // arrange
        cqrs_QueryHandler handler = new cqrs_GetAccountByTypeQueryHandler();
        cqrs_IQuery query= new cqrs_GetAccountByTypeQuery(ENTERPISE_ID);
        // add data
        cqrs_GetAccountByTypeQueryHandlerTest.addAccountData();
        // act  / assert
        system.assertEquals(true, handler.handle(query).success());
        // act
        query = null;
        // act  / assert
        system.assertEquals(false, handler.handle(query).success());

    }


    @isTest
    static void  logTest(){
        // arrange
        cqrs_QueryHandler handler = new cqrs_GetAccountByTypeQueryHandlerMock();
        // act  / assert
        system.assertEquals(true, handler.log('test'));
        system.assertEquals(false, handler.log(null));
    }

    /////////////////////////////////////////////////////////////////////////////
    // Helper
    /////////////////////////////////////////////////////////////////////////////
    /*
     * Add Account Data
     */
    @TestVisible
    static integer  addAccountData(){
        // arrange
        List<Account> values= new List<Account> {
            new Account(Name='Ohana, Inc.',Type='Enterprise', Industry='Technology'),
            new Account(Name='Another, Inc.',Type='Enterprise', Industry='Technology'),
            new Account(Name='Other, Inc.',Type='Small Business', Industry='Technology')
        };
        insert values;
        return values.size();
    }// end of addAccountData
}
