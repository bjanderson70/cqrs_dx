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
 * @description       : Responsible for resolving Handlers,COmmands and Queries Types
 *                      This needs a lot of improvements!! REFACTOR !!!
 * @author            : Bill Anderson
 * @group             : CQRS
 * @last modified on  : 08-27-2021
 * @last modified by  : Bill Anderson
 * Modifications Log
 * Ver   Date         Author          Modification
 * 1.0   08-01-2021   Bill Anderson   Initial Version
 **/
@SuppressWarnings('sf:TooManyMethods,PMD.CyclomaticComplexity')
public virtual inherited sharing class cqrs_Resolver implements cqrs_IResolver {

    /////////////////////////////////////////////////////////////////
    // Data Members
    /////////////////////////////////////////////////////////////////
    /*
     * Data Representation ( we need to sort on "Order")
     * - This is a DTO - fields are available to caller/callee
     */
    @SuppressWarnings('sf:AvoidPublicFields')
    public class CQRS_ContainerDomain implements Comparable {
        public String label;
        public String handlerType;
        public String concreteType;

        public String environment;
        public String requestType;
        public Integer order;
        public Boolean active;
        // support sorting
        public Integer compareTo(Object compareTo)
        {
            CQRS_ContainerDomain cqrs = (CQRS_ContainerDomain) compareTo;
            if (this.label == cqrs.label && this.order == cqrs.order ) { return 0;}
            if (this.label > cqrs.label && this.order > cqrs.order) { return 1;}
            return -1;
        }
    }
    // resolve to command, query or service
    public enum CommandRequestTypeEnum {
        QUERY,
        COMMAND,
        SERVICE
    }
    /*******************************Private **********************************/

    // names are CASE-sensitive
    private static final String CONCRETE_TYPE        ='concrete_type__c';
    private static final String ACTIVE_TYPE          ='active__c';
    private static final String HANDLER_TYPE         ='handler_type__c';
    private static final String ENVIRONMENT_FIELD    ='environment__c';
    private static final String ORDER_FIELD          ='order__c';
    private static final String REQUEST_FIELD        ='requesttype__c';
    private static final String COMMAND_TYPE         = CommandRequestTypeEnum.COMMAND.name();
    private static final string QUERY_TYPE           = CommandRequestTypeEnum.QUERY.name();

    // holds the commands, queries and service
    private static util_MetadataReader cqrsMDT = null;
    //
    // This is a quick hack can be done better!!
    //
    // our records by category ( query/commands)
    private static final Map<String, List<CQRS_ContainerDomain> > COMMAND_RECORDS_BY_CATEGORY = new  Map<String, List<CQRS_ContainerDomain> >();
    private static final Map<String, List<CQRS_ContainerDomain> > QRY_RECORDS_BY_CATEGORY = new  Map<String, List<CQRS_ContainerDomain> >();
    private static final Map<String, List<CQRS_ContainerDomain> > SERVICE_RECORDS_BY_CATEGORY = new  Map<String, List<CQRS_ContainerDomain> >();
    // segregated query and commands handlers
    @TestVisible
    private static final Map<String, cqrs_ICommandHandler > COMMAND_HANDLER_RECORDS = new  Map<String, cqrs_ICommandHandler> ();
    @TestVisible
    private static final Map<String, cqrs_IQueryHandler> QRY_HANDLER_RECORDS = new  Map<String, cqrs_IQueryHandler> ();
    // service records
    @TestVisible
    private static final Map<String, cqrs_IService> SERVICE_RECORDS = new  Map<String, cqrs_IService> ();
    // all commands and queries
    @TestVisible
    private static final List<CQRS_ContainerDomain> ALL_ACTIVE_RECORDS = new  List<CQRS_ContainerDomain>();

    // our instance
    private static cqrs_Resolver INSTANCE=null;
    /////////////////////////////////////////////////////////////////
    // Ctors
    /////////////////////////////////////////////////////////////////
    /*
     * Singleton
     */
    @TestVisible
    private cqrs_Resolver() {
        // it ONLY reads the data ONCE ( so repeat calls do not do anything but return !!)
        this.initialize();
    }

    /////////////////////////////////////////////////////////////////
    // Public Methods
    /////////////////////////////////////////////////////////////////
    /**
     * @description new Instance
     * @return cqrs_Resolver
     */
    public static cqrs_Resolver newInstance() {
        if (cqrs_Resolver.INSTANCE==null ) {
            cqrs_Resolver.INSTANCE=new cqrs_Resolver();
        }
        return cqrs_Resolver.INSTANCE;
    }
    /**
     * @description cqrsListByLabel description
     * @param  label Identifier
     * @param rtype CommandRequestType
     * @return  List<CQRS_ContainerDomain>
     */
    public List<CQRS_ContainerDomain> cqrsListByLabel(String label,CommandRequestTypeEnum rtype) {
        List<CQRS_ContainerDomain> results = null;
        if ( string.isNotBlank(label)) {
            if ( rtype == CommandRequestTypeEnum.COMMAND ) {
                results=COMMAND_RECORDS_BY_CATEGORY.get(label);
            } else if ( rtype == CommandRequestTypeEnum.QUERY ) {
                results=QRY_RECORDS_BY_CATEGORY.get(label);
            } else {
                results=SERVICE_RECORDS_BY_CATEGORY.get(label);
            }

            if ( results != null && results.size() > 1) {
                results.sort();
            }

        }
        return results;
    } // end of cqrsListByLabel
    /**
     * @description getCommandHandler description
     * @param  label label description
     * @return cqrs_ICommandHandler
     */
    public cqrs_ICommandHandler getCommandHandler(String handler){
        cqrs_ICommandHandler cmd = null;

        if (String.isNotBlank(handler)) {
            cmd = (cqrs_ICommandHandler)COMMAND_HANDLER_RECORDS.get(handler);
            if ( cmd == null ) {
                cmd =(cqrs_ICommandHandler) this.getType(handler);
                COMMAND_HANDLER_RECORDS.put(handler,cmd);
            }
        }

        return cmd;
    } // end of getCommandHandler
    /**
     * @description get Query Handler
     * @param  handler String
     * @return cqrs_IQueryHandler
     */
    public cqrs_IQueryHandler getQueryHandler(String handler){
        cqrs_IQueryHandler qry = null;

        if (String.isNotBlank(handler)) {

            qry = (cqrs_IQueryHandler)QRY_HANDLER_RECORDS.get(handler);
            if ( qry == null ) {
                qry =(cqrs_IQueryHandler) this.getType(handler);
                QRY_HANDLER_RECORDS.put(handler,qry);
            }
        }
        return qry;
    } // end of getQueryHandler
    /**
     * @description get Command Chain
     * @param  label String
     * @return  List<cqrs_ICommand>
     */
    public List<cqrs_ICommand> getCommandChain(String label){
        List<cqrs_ICommand> query = new List<cqrs_ICommand>();
        List<Object> result=this.getChain(label,
                                          CommandRequestTypeEnum.COMMAND);

        if ( !result.isEmpty() ) {
            for (Object item: result) {
                query.add((cqrs_ICommand)item);
            }
        }
        return query;
    } // end of getCommandChain

    /**
     * @description get Query Chain
     * @param  label label
     * @return   List<cqrs_IQuery>
     */
    public List<cqrs_IQuery> getQueryChain(String label){
        List<cqrs_IQuery> query = new List<cqrs_IQuery>();
        List<Object> result=this.getChain(label,
                                          CommandRequestTypeEnum.QUERY);

        if ( !result.isEmpty() ) {
            for (Object item: result) {
                query.add((cqrs_IQuery)item);
            }
        }
        return query;
    } // end of getQueryChain
    /**
     * @description get Service by name (TBD by type)
     * @param  name service name
     * @return cqrs_IService
     */
    public virtual cqrs_IService getService(String name) {
        cqrs_IService service= string.isNotBlank(name)? SERVICE_RECORDS.get(name):null;
        List<CQRS_ContainerDomain> cqrs= null;
        // still no service?
        if ( service == null ) {
            cqrs=this.cqrsListByLabel(name,CommandRequestTypeEnum.SERVICE);
        }

        // found service
        if ( cqrs != null && !cqrs.isEmpty() )
        {
            String firstService = cqrs[0].concreteType;
            Object value= this.getType(firstService);
            if ( value  != null) {
                service=(cqrs_IService)value;
            }

        }
        return service;
    }// end of getService

    /**
     * @description getChain
     * @param  label label
     * @param  rtype CommandRequestTypeEnum (Command || Query)
     * @return List<Object>
     */
    public virtual List<Object> getChain(String label,CommandRequestTypeEnum rtype){
        List<CQRS_ContainerDomain> cqrs= this.cqrsListByLabel(label,rtype);
        List<Object> chain = new List<Object>();

        if ( cqrs != null )
        {
            Object value;
            for ( CQRS_ContainerDomain item : cqrs) {
                value = this.getType(item.concreteType);
                if ( value  != null) {
                    chain.add(value);
                }
            }
        }
        return chain;
    }  // end of getChain
    /**
     * @description find the Handler Name from the Command or Query Name
     * @param  commandOrQueryName the command or Query name
     * @return String the Handler name
     */
    public virtual String findCQHandlerNameByCQName(String commandOrQueryName){
        String result=null;
        Boolean isValid = string.isNotBlank(commandOrQueryName);
        // valid name
        if ( isValid )
        {
            // iterate over all the commands and queries matching the
            // concrete-type name; then return its Handler Name
            for ( CQRS_ContainerDomain item : ALL_ACTIVE_RECORDS) {
                if ( item.concreteType.equalsIgnoreCase(commandOrQueryName)) {
                    result=item.handlerType;
                    break;
                }
            }
        }
        return result;
    } // end of findCommandOrQueryHandlerByName

    /////////////////////////////////////////////////////////////////
    // Protected Methods
    /////////////////////////////////////////////////////////////////
    /**
     * @description getType
     * @param  concreteType concrete type name
     * @return Type
     */
    @SuppressWarnings('sf:ConfusingTernary')
    @TestVisible
    protected virtual Object getType(String concreteType) {
        Type value=null;
        Object result=null;
        try {
            value = Type.forName(concreteType);

            if ( value  != null) {
                result= value.newInstance();
            } else {
                this.log('Exception: Invalid Type of ' + concreteType);
            }
        } catch (Exception excp) {
            this.log('Exception: Invalid Conversion of ' + concreteType);
            this.log('Exception: ' + excp.getMessage());
        }
        return result;
    }// end of getType
    /**
     * @description log -- substitute your Logger here!
     * @param  message String
     */
    @TestVisible
    protected virtual void log(String message) {
        if (String.isNotBlank(message)) {
            system.debug(message);
        }
    }  // end of log

    /////////////////////////////////////////////////////////////////
    // Private Methods
    /////////////////////////////////////////////////////////////////
    /**
     * initialize to gloabl context, or default. This is DONE ONCE via ctor
     */
    @TestVisible
    private void initialize() {
        // only once instance of the global context
        if ( cqrs_Resolver.cqrsMDT== null ) {
            // update cqrs
            this.updateCQRSRecords( this.instantiateReader());
        }
    }  // end of initialize
    /**
     * updateCQRSRecords
     * @description update from reader
     * @param  result collection of records
     */
    @TestVisible
    private void updateCQRSRecords(util_MetadataReader reader) {
        Integer count= reader.process();
        // any data to process
        if ( count > 0 ) {
            // could speed up by use cache!
            final Map<String,Map<String,String> > records = reader.theRecords;
            CQRS_ContainerDomain cqrs;
            List<CQRS_ContainerDomain> cqrsList;
            Map<String,String> values;

            // loop thru values
            for ( String key:  records.keySet()) {
                values = records.get(key);
                cqrs = this.newEntry(values);
                // first ensure the item is active
                if ( cqrs.active ) {
                    // keep track of all CQs -- used to find handler
                    // by query/command name
                    ALL_ACTIVE_RECORDS.add(cqrs);
                    // get the proper list, if known
                    cqrsList = this.getListByRequestType(cqrs);
                    cqrsList.add(cqrs);
                }
            }
        }
    }// end of updateCQRSRecords

    /**
     * @description newEntry
     * @param  values Map<String,String>
     * @return CQRS_ContainerDomain
     */
    @TestVisible
    private CQRS_ContainerDomain newEntry(Map<String,String> values){

        CQRS_ContainerDomain cqrs = new CQRS_ContainerDomain();

        cqrs.label =(String)values.get(util_MetadataReader.MASTER_LABEL_KEY);
        cqrs.handlerType = (String)values.get(HANDLER_TYPE);
        cqrs.ConcreteType = (String)values.get(CONCRETE_TYPE);
        cqrs.active = Boolean.valueOf(values.get(ACTIVE_TYPE));

        cqrs.order = Integer.valueOf((String)values.get(ORDER_FIELD));
        cqrs.requestType = (String)values.get(REQUEST_FIELD);
        cqrs.environment = (String)values.get(ENVIRONMENT_FIELD);
       
        return cqrs;
    }  // end of newEntry
    /**
     * @description getListByRequestType
     * @param cqrs CQRS_ContainerDomain
     * @return List<CQRS_ContainerDomain>
     */
    @TestVisible
    private List<CQRS_ContainerDomain> getListByRequestType(CQRS_ContainerDomain cqrs) {
        List<CQRS_ContainerDomain> cqrsList;
        String mlabel=cqrs.label,
               request=cqrs.requestType;
        Boolean isCommand = request.equalsIgnoreCase(COMMAND_TYPE),
                isQuery = request.equalsIgnoreCase(QUERY_TYPE);

        // get the list
        if ( isCommand ) {
            cqrsList = COMMAND_RECORDS_BY_CATEGORY.get(mlabel);
            COMMAND_HANDLER_RECORDS.put(cqrs.handlerType,null);
        } else if ( isQuery ) {
            cqrsList = QRY_RECORDS_BY_CATEGORY.get(mlabel);
            QRY_HANDLER_RECORDS.put(cqrs.handlerType,null);
        } else {
            cqrsList=SERVICE_RECORDS_BY_CATEGORY.get(mlabel);
            // service specific; do not care about the handler
            SERVICE_RECORDS.put(cqrs.concreteType,null);
        }

        // add to record
        if ( cqrsList==null ) {
            cqrsList = new List<CQRS_ContainerDomain>();
            if ( isCommand ) {
                COMMAND_RECORDS_BY_CATEGORY.put( mlabel,cqrsList);
            } else if ( isQuery ) {
                QRY_RECORDS_BY_CATEGORY.put( mlabel,cqrsList);
            } else {
                SERVICE_RECORDS_BY_CATEGORY.put(mlabel,cqrsList);
            }
        }
        return cqrsList;
    }  // end of getListByRequestType


    /**
     * @description get alias Metadata description
     * @return   util_MetadataReader
     */
    @TestVisible
    private util_MetadataReader instantiateReader() {
        // singleton MDT
        if (cqrs_Resolver.cqrsMDT==null ) {
            cqrs_Resolver.cqrsMDT= new util_MetadataReader( Commands_and_Queries__mdt.class,
                                                            // how we organize the metadata
                                                            util_MetadataReader.DEVELOPER_NAME_KEY,
                                                            // runtime environment ( we could get ALL of them)
                                                            // or, this could be done to get the current
                                                            // runtime environment (see "util_MiscHelpers.getEnvironment()" )
                                                            // util_Constants.ALL_CATEGORY
                                                            util_MiscHelpers.getEnvironment());
        }
        return cqrs_Resolver.cqrsMDT;
    }// end of instantiateReader


} // end of cqrs_IResolver