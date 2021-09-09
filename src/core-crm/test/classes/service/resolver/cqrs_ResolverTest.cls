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
 * @description       : Test cqrs_Resolver Functionality
 * @author            : Bill Anderson
 * @group             : Test
 * @last modified on  : 08-27-2021
 * @last modified by  : Bill Anderson
 * Modifications Log
 * Ver   Date         Author          Modification
 * 1.0   01-09-2021   Bill Anderson   Initial Version
 **/
@SuppressWarnings('sf:UseLocaleWithCaseConversions')
@isTest(OnInstall=true)
private class cqrs_ResolverTest {


    /////////////////////////////////////////////////////////////////
    // Data Members
    /////////////////////////////////////////////////////////////////

    static final String COMMAND_SERVICE='UI Customer Service Command';
    static final String BAD_HANDLER='Bad Handler';
    static final String SAMPLE_QUERY_HANDLER_IN_TEST='cqrs_GetAccountByTypeQueryHandler';
    static final String SAMPLE_COMMAND_HANDLER_IN_TEST='cqrs_AuthenticationCommandHandler';
    static final String SAMPLE_QUERY_CHAIN_IN_TEST='Query Test';
    /////////////////////////////////////////////////////////////////
    // Unit Tests
    /////////////////////////////////////////////////////////////////

    @isTest
    static void ctorTest() {
        // arrange /act / assert
        system.assertNotEquals(null,  cqrs_Resolver.newInstance());
    }
    @isTest
    static void cqrsListByLabelTest() {
        // arrange
        cqrs_Resolver resolver=  cqrs_Resolver.newInstance();
        // act /assert
        system.assertNotEquals(null, resolver.cqrsListByLabel(SAMPLE_QUERY_CHAIN_IN_TEST,
                                                              cqrs_Resolver.CommandRequestTypeEnum.QUERY));
        // act
        List<cqrs_Resolver.CQRS_ContainerDomain> chain=resolver.cqrsListByLabel (COMMAND_SERVICE,
                                                                                 cqrs_Resolver.CommandRequestTypeEnum.COMMAND);
        // assert
        system.assertEquals( true,!chain.isEmpty() );
        // assert (expect sorted order)
        for (cqrs_Resolver.CQRS_ContainerDomain item : chain) {
            // assert
            system.assertEquals( true,util_Constants.TEST_CATEGORY.equalsIgnoreCase(item.environment));
        }
    }

    @isTest
    static void getCommandHandlerTest() {
        // arrange
        cqrs_Resolver resolver=  cqrs_Resolver.newInstance();

        // act
        cqrs_ICommandHandler handler = resolver.getCommandHandler (SAMPLE_COMMAND_HANDLER_IN_TEST);
        // assert
        system.assertNotEquals(null, handler);
        // act
        handler = resolver.getCommandHandler (BAD_HANDLER);
        // assert
        system.assertEquals(null, handler);

    }
    @isTest
    static void getQueryHandlerTest() {
        // arrange
        cqrs_Resolver resolver=  cqrs_Resolver.newInstance();

        // act
        cqrs_IQueryHandler handler = resolver.getQueryHandler (SAMPLE_QUERY_HANDLER_IN_TEST);
        // assert
        system.assertNotEquals(null, handler);
        // act
        handler = resolver.getQueryHandler (BAD_HANDLER);
        // assert
        system.assertEquals(null, handler);
    }

    @isTest
    static void getCommandChainTest() {
        // arrange
        cqrs_Resolver resolver=  cqrs_Resolver.newInstance();

        // act
        List<cqrs_ICommand> commands = resolver.getCommandChain (COMMAND_SERVICE);
        // assert
        system.assertNotEquals(null, commands);
        // test environment SHOULD have values
        system.assertEquals(true, !commands.isEmpty());
        // act
        commands = resolver.getCommandChain (BAD_HANDLER);
        // assert
        system.assertEquals(true, commands.isEmpty());
    }

    @isTest
    static void getQueryChainTest() {
        // arrange
        cqrs_Resolver resolver=  cqrs_Resolver.newInstance();

        // act ( query would find none as we referencing a command service)
        List<cqrs_IQuery> queries = resolver.getQueryChain (COMMAND_SERVICE);
        // assert
        system.assertEquals(true, queries.isEmpty());
    }

    @isTest
    static void findCQHandlerNameByCQNameTest() {
        // arrange
        cqrs_Resolver resolver=  cqrs_Resolver.newInstance();

        // act
        String result = resolver.findCQHandlerNameByCQName ('');
        // assert
        system.assertEquals(null, result);
        // act
        result = resolver.findCQHandlerNameByCQName (null);
        // assert
        system.assertEquals(null, result);

        // iterate over our active records
        for ( cqrs_Resolver.CQRS_ContainerDomain item : cqrs_Resolver.ALL_ACTIVE_RECORDS )
        {
            // act
            result = resolver.findCQHandlerNameByCQName (item.concreteType);
            // assert
            system.assertEquals(item.handlerType, result);
        }
    }// end of findCQHandlerNameByCQNameTest

} // end of cqrs_IResolverTest