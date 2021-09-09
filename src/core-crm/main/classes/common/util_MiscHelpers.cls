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
 * @description       : Misc Utilities
 * @author            : Bill Anderson
 * @group             : Utility
 * @last modified on  : 08-14-2021
 * @last modified by  : Bill Anderson
 * Modifications Log
 * Ver   Date         Author          Modification
 * 1.0   01-25-2021   Bill Anderson   Initial Version
 **/
@SuppressWarnings('sf:ConfusingTernary,sf:UseLocaleWithCaseConversions')
public inherited sharing class util_MiscHelpers {


    ///////////////////////////////////////////////////////////////////////
    // Ctors
    ///////////////////////////////////////////////////////////////////////
    /*
     * Singleton
     */
    @TestVisible
    private util_MiscHelpers() {
    }

    ///////////////////////////////////////////////////////////////////////
    // Public Methods
    ///////////////////////////////////////////////////////////////////////

    ///////////////////////////////////////////////////////////////////////
    // NOTE:
    // Custom Metadata pulled from SF can be NULL; thus, we pass in the value
    // and if null, set it fo the default
    ///////////////////////////////////////////////////////////////////////


    /**
     * @description the environment
     * @return either 'production', 'debug' (in sandbox) or 'test'
     */
    public static string getEnvironment() {
        string environment = util_Constants.PRODUCTION_CATEGORY;

        if ( util_Constants.IS_UNIT_TEST ) {
            environment = util_Constants.TEST_CATEGORY;
        } else if (util_MiscHelpers.isSandbox() ) {
            environment = util_Constants.DEBUG_CATEGORY;
        }
        return environment;
    }     // end of getEnvironment
    /**
     * @description just ensuring correct environment
     *
     * @param currentEnv user wants a particular environment
     * @return environment, otherwise , 'util_Constants.DEBUG_CATEGORY'
     */
    public static string ensureEnviromentIsCorrectOtherwiseDebug(string currentEnv) {
        Boolean incomingNull =currentEnv == null;
        // set env
        String env = incomingNull ? util_Constants.DEBUG_CATEGORY : currentEnv;
        if ( incomingNull == false
             && !util_Constants.KNOWN_ENVIRONMENTS.contains(currentEnv.toLowerCase()) ) {
            env = util_Constants.DEBUG_CATEGORY;
        }
        return env;
    }// end of ensureEnviromentIsCorrectOtherwiseDebug

    /**
     * @description Unique Guid
     * @return String unique
     */
    public static String newGuid() {

        Blob crytoBlob = Crypto.GenerateAESKey(128);
        return EncodingUtil.ConvertTohex(crytoBlob);
    }// end of newGuid
    /**
     *
     * @description is this a sanbox
     * @return true, if sandbox
     */
    public static Boolean isSandbox() {
        return util_Constants.isSandboxBool;
    }

}// end of util_MiscHelpers