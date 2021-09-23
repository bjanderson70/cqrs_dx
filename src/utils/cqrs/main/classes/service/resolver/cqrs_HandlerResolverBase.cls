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
 * @description       : Base Resolve Handler
 * @author            : Bill Anderson
 * @group             : CQRS
 * @last modified on  : 09-20-2021
 * @last modified by  : Bill Anderson
 * Modifications Log
 * Ver   Date         Author          Modification
 * 1.0   08-01-2021   Bill Anderson   Initial Version
 **/
@SuppressWarnings('PMD.ClassNamingConventions')
public virtual inherited sharing class cqrs_HandlerResolverBase {

    //////////////////////////////////////////////////////////////////
    // Data Members
    //////////////////////////////////////////////////////////////////
    //-- HACK !!!
    // we do not need to do this way, as the handler ALREADY exists
    // in the metadata ... I only did it this way to FORCE one to
    // name their handlers with this extension. However, it could
    // still be enforce by comparing the name + "Hander" w/ the metadata
    // handlere value
    public static final String EXPECTED_HANDLER_EXTENSION = 'Handler';
    // our resolver
    private static cqrs_IResolver theResolver = null;

    //////////////////////////////////////////////////////////////////
    // Protected Ctors
    //////////////////////////////////////////////////////////////////
    /**
     * @description cqrs_HandlerResolverBase default ctor for children
     */
    @TestVisible
    protected cqrs_HandlerResolverBase() {
    }
    //////////////////////////////////////////////////////////////////
    // Protected Methods
    //////////////////////////////////////////////////////////////////


    /**
     * @description resolve
     * @param  name   name
     * @param  cqType CommandRequestTypeEnum (Command || Query)
     * @return Object cqrs_ICommandHandler or cqrs_IQueryHandler
     */
    @SuppressWarnings('sf:ConfusingTernary')
    @TestVisible
    protected virtual Object resolve(String name,
                                     cqrs_Resolver.CommandRequestTypeEnum cqType) {
        Object result=null;
        Boolean isService =  cqType ==cqrs_Resolver.CommandRequestTypeEnum.SERVICE;
        String handlerName = !isService ? this.ensureCorrectHandlerName(name):name;

        // we have a handler name
        if (String.isNotBlank(handlerName) ) {
            if ( cqType ==cqrs_Resolver.CommandRequestTypeEnum.COMMAND ) {
                result= this.getResolver().getCommandHandler(handlerName);
            } else if ( cqType ==cqrs_Resolver.CommandRequestTypeEnum.QUERY ) {
                result= this.getResolver().getQueryHandler(handlerName);
            } else {
                result= this.getResolver().getService(handlerName);
            }
        }
        return result;
    }// end of resolve
    /**
     * @description get Service by name
     * @param  name service name
     * @return cqrs_IService
     */
    public virtual cqrs_IService getService(String name) {
        return (cqrs_IService)this.getResolver().getService(name);
    }
    /**
     * @description ensureCorrectHandlerName
     * @param  name name description
     * @return String (Correct handler name)
     */
    @TestVisible
    protected virtual String ensureCorrectHandlerName(String name) {
        String handlerName = name;

        // get the handler name from the command/query name
        if ( string.isNotBlank(name)) {
            String found=this.getResolver().findCQHandlerNameByCQName(name);
            // if not found, reset to the name
            if ( found != null ) {
                handlerName=found;
            }
        }

        return handlerName;
    }// end of ensureCorrectHandlerName

    /**
     * @description get Resolver
     * @return cqrs_Resolver
     */
    @TestVisible
    protected virtual cqrs_IResolver getResolver() {
        // create once, when needed
        if ( cqrs_HandlerResolverBase.theResolver==null ) {
            cqrs_HandlerResolverBase.theResolver = cqrs_Resolver.newInstance();
        }
        return cqrs_HandlerResolverBase.theResolver;
    }// end of getResolver

}// end of cqrs_HandlerResolverBase