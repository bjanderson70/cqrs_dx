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
 * @description       : cqrs_AccountTypeRecordsDTO  Test
 * @author            : Bill Anderson
 * @group             : CQRS
 * @last modified on  : 09-08-2021
 * @last modified by  : Bill Anderson
 * Modifications Log
 * Ver   Date         Author          Modification
 * 1.0   07-31-2021   Bill Anderson   Initial Version
 **/
@isTest(OnInstall=true)
private class cqrs_AccountTypeRecordsDTOTest {
    /////////////////////////////////////////////////////////////
    // Data Members
    /////////////////////////////////////////////////////////////
    static final String DTO_ID = 'Id';
    static final String DTO_NAME = 'Name';
    static final String DTO_TYPE = 'Type';
    static final String DTO_IND = 'Industry';
    /////////////////////////////////////////////////////////////
    // Unit Tests
    /////////////////////////////////////////////////////////////
    @isTest
    static void ctorTest() {
        // arrange / act
        cqrs_AccountTypeRecordsDTO dto = new cqrs_AccountTypeRecordsDTO(DTO_ID,
                                                                        DTO_NAME,
                                                                        DTO_TYPE,
                                                                        DTO_IND);
        // assertions
        system.assertEquals(DTO_ID, dto.Id);
        system.assertEquals(DTO_NAME, dto.Name); 
        system.assertEquals(DTO_TYPE, dto.Type);   
        system.assertEquals(DTO_IND, dto.Industry);     
    }
   
}// end of cqrs_AccountTypeRecordsDTOTest
