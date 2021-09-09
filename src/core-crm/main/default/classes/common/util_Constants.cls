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
 * @description       : Constants
 * @author            : Bill Anderson
 * @group             : Utilities
 * @last modified on  : 07-30-2021
 * @last modified by  : Bill Anderson
 * Modifications Log
 * Ver   Date         Author          Modification
 * 1.0   12-15-2020   Bill Anderson   Initial Version
 **/
@SuppressWarnings('sf:AvoidUsingHardCodedIP,sf:UseLocaleWithCaseConversions')
public inherited sharing class util_Constants {

    ////////////////////////////////////////////////////////////////////
    // Data Members
    ////////////////////////////////////////////////////////////////////

    public static final Boolean IS_UNIT_TEST = System.Test.isRunningTest();
    // use by the custom MDT for configuration categories (case senstive)
    public static final string DEBUG_CATEGORY = 'debug';
    public static final string PRODUCTION_CATEGORY = 'production';
    public static final string TEST_CATEGORY = 'test';
    public static final string ALL_CATEGORY = 'all';

    /***********************************************************
     * Known environments
     */
    public static final Set<String> KNOWN_ENVIRONMENTS = new Set<String> {
        util_Constants.DEBUG_CATEGORY
        , util_Constants.PRODUCTION_CATEGORY
        , util_Constants.TEST_CATEGORY
        , util_Constants.ALL_CATEGORY
    };      // end of KNOWN_ENVIRONMENTS
 
    /***********************************************************
     * Sandbox
     */
    // determine if sandbox
    public static final Boolean isSandboxBool = [SELECT IsSandbox FROM Organization LIMIT 1].IsSandbox;
   
    ///////////////////////////////////////////
    // Private Ctor
    ///////////////////////////////////////////
    // ensure no instantiations
    @TestVisible
    private util_Constants() {
    }
}// end of util_Constants