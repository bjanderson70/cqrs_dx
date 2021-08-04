/**
 * @description       : Interface for user context
 * @author            : Bill Anderson
 * @group             : Interface
 * @last modified on  : 08-03-2021
 * @last modified by  : Bill Anderson
 * Modifications Log
 * Ver   Date         Author          Modification
 * 1.0   07-30-2021   Bill Anderson   Initial Version
 **/
public interface util_IUserContext {
    // user profile id
    String profileId();
    // user role id
    String roleId();
    // user first name
    String firstname();
    // user last name
    String lastname();
    // user id
    String userId();
    // user org ir
    String orgId();
}
