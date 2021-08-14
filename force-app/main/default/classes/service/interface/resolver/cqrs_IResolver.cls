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
 * @description       : Resolver Interface
 *                      Candidate for Refactoring!
 * @author            : Bill Anderson
 * @group             : Interface
 * @last modified on  : 08-14-2021
 * @last modified by  : Bill Anderson
 * Modifications Log
 * Ver   Date         Author          Modification
 * 1.0   07-30-2021   Bill Anderson   Initial Version
 **/
public interface cqrs_IResolver {
    /**
     * @description getCommandHandler description
     * @param  label label description
     * @return cqrs_ICommandHandler
     */
    cqrs_ICommandHandler getCommandHandler(String handler);
    /**
     * @description get Query Handler
     * @param  handler String
     * @return cqrs_IQueryHandler
     */
    cqrs_IQueryHandler getQueryHandler(String handler);
    /**
     * @description get Command Chain
     * @param  label String
     * @return  List<cqrs_ICommand>
     */
    List<cqrs_ICommand> getCommandChain(String label);
    /**
     * @description get Query Chain
     * @param  label label description
     * @return   List<cqrs_IQuery>
     */
    List<cqrs_IQuery> getQueryChain(String label);
    /**
     * @description find the Handler Name from the Command or Query Name
     * @param  commandOrQueryName the command or Query name
     * @return String the Handler name
     */
    String findCQHandlerNameByCQName(String commandOrQueryName);
    /**
     * @description get Service by name (could extend this interface TBD)
       (best to segregate out TBD ... "cqrs_IServiceProvider")
     * @param  name service name
     * @return cqrs_IService
     */
    cqrs_IService getService(String name);
} // end of cqrs_IResolver