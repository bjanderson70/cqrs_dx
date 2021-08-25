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
 * @description       : Generic Reader of Custom Metadata. All that is required
 *                      is the name and what field to index by
 * @author            : Bill Anderson
 * @group             : Utility
 * @last modified on  : 08-25-2021
 * @last modified by  : Bill Anderson
 * Modifications Log
 * Ver   Date         Author          Modification
 * 1.0   02-15-2021   Bill Anderson   Initial Version
 **/
@SuppressWarnings('PMD.ClassNamingConventions,sf:UseLocaleWithCaseConversions')
public virtual inherited sharing class util_MetadataReader {


    /////////////////////////////////////////////////////////////////////////////
    // Data Members
    /////////////////////////////////////////////////////////////////////////////
    /*
     * Our Exception ,if any
     */

    public class util_MetadataReaderException extends Exception {}
    /*
     * Common Keys used to Index CMDT
     */
    public static final String RECORD_INDEX_KEY = 'id';
    // developer name index
    public static final String DEVELOPER_NAME_KEY = 'developername';
    // environment index
    public static final String ENVIRONMENT_KEY = 'environment__c';
    // label key index
    public static final String MASTER_LABEL_KEY = 'masterlabel';
    // possible ctor error message when thrown
    public static final String EXCEPTION_MESSAGE = 'Not a valid Custom Metadata Type';

    /***************************************************
    * Private Section
    ***************************************************/
    // my limit number of records; normally 50K
    private static final String MAX_LIMIT = ' LIMIT 2000';
    /*
     * Default key index
     */
    @TestVisible
    private String indexByField = RECORD_INDEX_KEY;
    /***************************************************
    * Private [STATIC] Section
    ***************************************************/
    /*
     * CMDT Extension on the name
     */
    @TestVisible
    private static final String CMDT_EXTENSION = '__mdt';
    @TestVisible
    // show contents are they are processed
    private static Boolean SHOW_CONTENTS = System.Test.isRunningTest();

    /////////////////////////////////////////////////////////////////////////////
    // Ctors
    /////////////////////////////////////////////////////////////////////////////

    /**
     * util_MetadataReader
     * @description read custom metadata
     * @param  metaDataType Schema.smetaDataType
     */
    public util_MetadataReader(Type metaDataType) {
        this(metaDataType,RECORD_INDEX_KEY, util_MiscHelpers.getEnvironment());
    }

    /**
     * util_MetadataReader
     * @description read custom metadata
     * @param  metaDataType Schema.smetaDataType
     * @param indexBy String index field (ID is the default, others could be: 'developername', 'label', 'namespaceprefix', etc. )
     */
    @SuppressWarnings('sf:AvoidMethodsBeforeInitializers')
    public util_MetadataReader(Type metaDataType, String indexBy) {
        this(metaDataType,indexBy, util_MiscHelpers.getEnvironment());
    }
    /**
     * util_MetadataReader
     * @description read custom metadata
     * @param  metaDataType Schema.smetaDataType
     * @param indexBy String index field (ID is the default, others could be: 'developername', 'label', 'namespaceprefix', etc. )
     * @param environment (Test, Debug, Production)
     */
    @SuppressWarnings('sf:AvoidMethodsBeforeInitializers')
    public util_MetadataReader(Type metaDataType, String indexBy, String environment) {
        this.onGuardCustomMetadataName(metaDataType);

        this.theName = metaDataType.getName();
        this.cmdtSObjectType = Schema.getGlobalDescribe().get(this.theName);
        this.theMetaDataType = metaDataType;
        this.indexByField = indexBy;
        this.theEnvironment = util_MiscHelpers.ensureEnviromentIsCorrectOtherwiseDebug(environment);
        this.recordCount = 0;
        this.cacheKey = util_Strings.removeUnderscore(this.theName)+this.theEnvironment;
        this.hasRead = false;
        this.hashCode = System.hashCode(this);

    }

    /////////////////////////////////////////////////////////////////////////////
    // Public Properties
    /////////////////////////////////////////////////////////////////////////////

    /*
     * Environment
     */
    @TestVisible
    public String theEnvironment {get; protected set;}
    /*
     * CustomMetata Data Type
     */
    @TestVisible
    public Type theMetaDataType { get; protected set;}
    /*
     * Collection of Fields
     */
    @TestVisible
    public Map<String,Schema.SObjectField> theFields { get; protected set;}
    /*
     * Number of Records
     */
    @TestVisible
    public Integer recordCount {get; protected set;}
    /*
     * Name of the resource
     */
    @TestVisible
    public String theName { get; protected set;}
    /*
     * hashCode
     */
    @TestVisible
    public Integer hashCode { get; protected set;}
    /*
     * records (index by Record ID)
     */
    @TestVisible
    public Map<String, Map<String,String> > theRecords { get; protected set;}
    /**
     * Index the map by field ( if not valid, will use ID)
     */
    public String theIndexByField {
        get {
            return this.indexByField;
        }
        set {
            this.indexByField = string.isBlank(value) ? RECORD_INDEX_KEY : value.tolowercase().trim();
        }
    }

    /////////////////////////////////////////////////////////////////////////////
    // Protected Properties
    /////////////////////////////////////////////////////////////////////////////
    /*
     * CMT Stype
     */
    @TestVisible
    protected SObjectType cmdtSObjectType { get; set;}
    /*
     * Cache Key
     */
    @TestVisible
    protected String cacheKey { get; set;}
    /*
     * Has Read
     */
    @TestVisible
    protected Boolean hasRead {get; set;}
    /////////////////////////////////////////////////////////////////////////////
    // Public Methods
    /////////////////////////////////////////////////////////////////////////////

    /**
     * getByIndexKey
     * @description Lookup the record based on the the index key
     * @param  key Index key (String)
     * @return  Map<String,String> the reocrd which contains a collecion of name/value pairs
     */
    public Map<String,String> getByIndexKey(String key) {
        Map<String,String> record = null;
        // any records ?
        if ( this.recordCount > 0 && string.isNotBlank(key)) {
            record = this.theRecords.get(key.toLowerCase().trim());
        }
        return record;
    }// end of getByIndexKey

    /**
     * process
     * @description process the infomation
     * @return   return Record Count
     */
    public Integer process() {

        if ( this.hasRead == false ) {
            Integer size = 0;
            // anything cached ?
            if ( this.theRecords == null ) {
                // read the information
                size= this.readFieldsImpl();

            } else {
                // set the record count
                size= this.theRecords.size();
            }
            this.recordCount = size;
            // we only do this ONCE
            this.hasRead=size > 0;

        }
        return this.recordCount;
    }// end of process

    /*
     * Just to print out in Test Mode
     */
    public void showContents() {
        // only if Tetsing
        if ( util_MetadataReader.SHOW_CONTENTS ) {
            this.hasRead=false;
            // process will run and print
            this.process();

        }

    }  // end of showContents

    /////////////////////////////////////////////////////////////////////////////
    // Protected Methods
    /////////////////////////////////////////////////////////////////////////////

    /**
     * readFieldsImpl
     * @description read in the fields
     * @return  Integer number of read fields
     */
    @TestVisible
    @SuppressWarnings('sf:SOQLInjection,PMD.ApexSOQLInjection')
    protected virtual Integer readFieldsImpl() {
        Integer count=0;


        try {
            Schema.DescribeSObjectResult dsr = this.cmdtSObjectType.getDescribe();
            this.theFields = dsr.fields.getMap();
            Boolean fieldExists= this.theFields.get(ENVIRONMENT_KEY) != null;
            String queryFields = string.join(new List<String>(this.theFields.keyset()),',');
            List<SObject> records=null;

            String query = this.makeQuery(queryFields,fieldExists);
            records = Database.query(query);

            // any records to process
            if ( records != null ) {
                // create out map holder
                this.theRecords = new Map<String, Map<String,String> >();
                count = this.processRecords(records);
            }

        } catch (Exception excp) {
            this.log(excp.getStackTraceString());
        }
        return count;
    }// end of readFieldsImpl
    /**
     * processRecords
     * @description proces the sobject records
     * @param  records list of sobjects
     * @return         return Integer count
     */
    @TestVisible
    protected virtual integer processRecords (List<SObject> records) {
        integer count=0,
                rSize = records.size();
        Map<String,String> recordMap;
        Set<String> fSet;
        String result,
               idResult,
               defaultIdResult;

        // iterate over the records
        for (Integer inx=0; inx < rSize; inx++) {
            recordMap =  new Map<String,String>();
            count++;
            idResult=null;
            defaultIdResult=null;
            fSet = this.theFields.keyset();

            for (String fieldname:  fSet ) {

                result = this.getFieldFromRecord(fieldname,records[inx]);
                recordMap.put(fieldname,result);

                // remember key
                if (  idResult==null ) {
                    if ( fieldname == this.indexByField ) {
                        idResult = result;
                    }
                    if  ( defaultIdResult==null && fieldname == RECORD_INDEX_KEY ) {
                        // fallback resource
                        defaultIdResult= result;
                    }
                }
            }
            // ensure we have a valid index
            if ( idResult == null ) {
                idResult = defaultIdResult;
            }
            // maps index are case sensitive
            this.theRecords.put(idResult.toLowerCase().trim(), recordMap );

        }

        return count;
    }// end of processRecords
    /**
     * getFieldFromRecord
     * @param  fieldname field name
     * @param  record    record Sobject
     * @return  String result
     */
    @TestVisible
    protected virtual String getFieldFromRecord(String fieldname, SObject record){
        Object result = record.get(fieldname);
        return result == null ? '' : record.get(fieldname)+'';
    }
    /**
     * onGuardCustomMetadataName
     * @ description guard againset bad type
     * @param  theCMDT type
     */
    @TestVisible
    protected void onGuardCustomMetadataName(Type theCMDT) {
        if ( theCMDT == null || !theCMDT.getName().endsWith(CMDT_EXTENSION) ) {
            throw new util_MetadataReaderException(EXCEPTION_MESSAGE);
        }
    }// endof onGuardCustomMetadataName

    /**
     * @description make Query
     * @param  queryFields query Fields
     * @param  fieldExists env exists
     * @return query string
     */
    @TestVisible
    protected string makeQuery(String queryFields, Boolean fieldExists) {
        String query = 'SELECT ' + queryFields + ' FROM ' + this.theName;
        if ( fieldExists
             && false==this.theEnvironment.equalsIgnoreCase(util_Constants.ALL_CATEGORY)) {
            query += ' WHERE environment__c=\'' + string.escapeSingleQuotes(this.theEnvironment) +'\'';
        }
        query +=  MAX_LIMIT;

        return query;
    }// end of makeQuery

    /**
     * @description This is contrived -- you should have your own Cross Cutting Concern Logger
     *      here we did this for syntactic sugar ( for the children)
     * @param  message String
     */
    @TestVisible
    protected virtual Boolean log(String message){
        Boolean add = String.isNotBlank (message);
        if ( add ) {
            system.debug('+++' +message);
        }
        return add;
    } // end of log
    /////////////////////////////////////////////////////////////////////////////
    // Private Methods
    /////////////////////////////////////////////////////////////////////////////

}// end of util_MetadataReader