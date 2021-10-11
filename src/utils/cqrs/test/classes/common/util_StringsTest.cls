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
 * @description       : Test util_Strings Functionality
 * @author            : Bill Anderson
 * @group             : Test
 * @last modified on  : 08-03-2021
 * @last modified by  : Bill Anderson
 * Modifications Log
 * Ver   Date         Author          Modification
 * 1.0   12-12-2020   Bill Anderson   Initial Version
 **/
@SuppressWarnings('PMD.ClassNamingConventions')
@isTest(OnInstall=true)
private class util_StringsTest {

    /////////////////////////////////////////////////////////////////////////
    // Data members
    /////////////////////////////////////////////////////////////////////////

    static final Map<String,String> UNDERSCORE_TEST_ORACLE = new  Map<String,String> {
        'test_' => 'test',
        'last_here'=> 'lasthere',
        'last__'=> 'last',
        '__ok__'=> 'ok',
        ''=> '',
        'none'=> 'none'
    };

    /////////////////////////////////////////////////////////////////////////
    // Unit Tests
    /////////////////////////////////////////////////////////////////////////

    @isTest
    static void removeUnderscoreTest(){
        system.assertNotEquals(null, new util_Strings());
        // assign
        for (String key : UNDERSCORE_TEST_ORACLE.keyset() ) {
            // assert
            system.assertEquals(UNDERSCORE_TEST_ORACLE.get(key), 
            util_Strings.removeUnderscore(key) );
        }
    }

}// end of util_StringsTest