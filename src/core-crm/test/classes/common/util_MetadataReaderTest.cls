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
 * @description       : Test util_MetadataReader Functionality
 * @author            : Bill Anderson
 * @group             : Test
 * @last modified on  : 09-17-2021
 * @last modified by  : Bill Anderson
 * Modifications Log
 * Ver   Date         Author          Modification
 * 1.0   12-12-2020   Bill Anderson   Initial Version
 **/

@isTest(OnInstall=true)
private class util_MetadataReaderTest {

    @isTest
    static void ctorTest() {
        // arrange / act
        util_MetadataReader reader=new util_MetadataReader(Commands_and_Queries__mdt.class);
        // assert
        system.assertEquals(util_Constants.TEST_CATEGORY, reader.theEnvironment);
        system.assertEquals(true, reader.theName.contains(util_MetadataReader.CMDT_EXTENSION));
        system.assertNotEquals(0, reader.hashCode);
        system.assertEquals (0,reader.recordCount);
        system.assertEquals (null,reader.theRecords);
        system.assertEquals (false,reader.hasRead);
    }
    @isTest
    static void processTest() {
        // arrange
        util_MetadataReader reader=new util_MetadataReader(Commands_and_Queries__mdt.class);
        // act
        Integer count = reader.process();
        // assert
        system.assertNotEquals(0, reader.hashCode);
        system.assertEquals (count,reader.recordCount);
        system.assertEquals (count,reader.theRecords.size());
        system.assertEquals (true,reader.hasRead);
    }

    @isTest
    static void logTest() {
        // arrange
        util_MetadataReader reader=new util_MetadataReader(Commands_and_Queries__mdt.class);
        // act
        Boolean added = reader.log('test');
        // assert
        system.assertEquals (true,added);
    }
    @isTest
    static void onGuardCustomMetadataNameTest() {
        // arrange
        util_MetadataReader reader=new util_MetadataReader(Commands_and_Queries__mdt.class);
        Boolean threwException = false;
        // act
        try { 
            reader.onGuardCustomMetadataName(null);
        } catch (Exception excp){
            threwException=true;
        }
    
        // assert
        system.assertEquals (true,threwException);
    }

    @isTest
    static void showContentsTest() {
        // arrange
        util_MetadataReader reader=new util_MetadataReader(Commands_and_Queries__mdt.class);
        util_MetadataReader.SHOW_CONTENTS=true;
        // act
        reader.showContents();
        // assert
        system.assertEquals (true,reader.hasRead);
    }


}// end of util_MetadataReaderTest