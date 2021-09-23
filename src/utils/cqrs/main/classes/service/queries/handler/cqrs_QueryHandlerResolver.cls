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
 * @description       : Resolver for Query Handler
 * @author            : Bill Anderson
 * @group             : CQRS
 * @last modified on  : 09-20-2021
 * @last modified by  : Bill Anderson
 * Modifications Log
 * Ver   Date         Author          Modification
 * 1.0   07-31-2021   Bill Anderson   Initial Version
 **/
@SuppressWarnings('PMD.ClassNamingConventions')
public inherited sharing class cqrs_QueryHandlerResolver extends cqrs_HandlerResolverBase implements cqrs_IQueryHandlerResolver {

    //////////////////////////////////////////////////////////////////////////
    // Public Methods
    //////////////////////////////////////////////////////////////////////////
    /**
     * @description resolve to a query handler
     * @param  query   cqrs_IQuery
     * @return cqrs_IQueryHandler
     */
    public cqrs_IQueryHandler resolve(cqrs_IQuery query) {
        return (cqrs_IQueryHandler) super.resolve(query.name(),
                                                  cqrs_Resolver.CommandRequestTypeEnum.QUERY);

    }  // end of resolve
}// end of cqrs_QueryHandlerResolver