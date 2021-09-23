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
 * @description       : Command / Query Result
 * @author            : Bill Anderson
 * @group             : CQRS
 * @last modified on  : 09-20-2021
 * @last modified by  : Bill Anderson
 * Modifications Log
 * Ver   Date         Author          Modification
 * 1.0   07-31-2021   Bill Anderson   Initial Version
 **/
@SuppressWarnings('PMD.ClassNamingConventions')
public virtual inherited sharing class cqrs_Result implements cqrs_IResult {

    //////////////////////////////////////////
    // Data Members
    //////////////////////////////////////////
    // any exception
    Exception resultException;
    // are we successful
    Boolean successful;

    //////////////////////////////////////////
    // Ctors
    //////////////////////////////////////////

    public cqrs_Result() {
        this(true,null);
    }
    public cqrs_Result(Boolean isSuccess) {
        this(isSuccess,null);
    }
    public cqrs_Result(Exception usrException) {
        this(usrException==null,usrException);

    }
    public cqrs_Result(Boolean iSuccess, Exception usrException) {
        this.success(iSuccess);
        this.theException(usrException);

    }

    //////////////////////////////////////////
    // Public Methods
    //////////////////////////////////////////

    public Boolean hasException() {
        return this.theException() != null;
    }
    public Exception theException() {
        return this.resultException;
    }

    public void  theException(Exception excp) {
        this.resultException=excp;
        // only set the success status, if the
        // excp is non-null
        if ( excp != null ) {
            this.success( false);
        }
    }
    public Boolean success() {
        return this.successful;
    }

    public void success(Boolean result) {
        this.successful=result;
    }
}// end of Result
