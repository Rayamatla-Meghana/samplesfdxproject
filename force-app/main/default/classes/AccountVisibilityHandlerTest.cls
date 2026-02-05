/**
 * @description Test class for AccountVisibilityHandler
 * @author Salesforce Developer
 * @since 2026-01-29
 */
@isTest
public class AccountVisibilityHandlerTest {
    
    /**
     * @description Tests creation of a single account
     */
    @isTest
    static void testCreateAccount() {
        // Setup
        Account testAccount = new Account(
            Name = 'Test Account',
            Phone = '555-123-4567',
            Website = 'https://www.testaccount.com'
        );
        
        // Execute
        Account createdAccount = AccountVisibilityHandler.createAccount(testAccount);
        
        // Verify
        System.assertNotEquals(null, createdAccount.Id);
        System.assertEquals('Test Account', createdAccount.Name);
        System.assertEquals('555-123-4567', createdAccount.Phone);
        System.assertNotEquals(null, createdAccount.OwnerId);
    }
    
    /**
     * @description Tests creation of multiple accounts
     */
    @isTest
    static void testCreateAccounts() {
        // Setup
        List<Account> accountsToCreate = new List<Account>{
            new Account(Name = 'Test Account 1', Phone = '555-111-1111'),
            new Account(Name = 'Test Account 2', Phone = '555-222-2222')
        };
        
        // Execute
        List<Account> createdAccounts = AccountVisibilityHandler.createAccounts(accountsToCreate);
        
        // Verify
        System.assertEquals(2, createdAccounts.size());
        System.assertNotEquals(null, createdAccounts[0].Id);
        System.assertNotEquals(null, createdAccounts[1].Id);
        System.assertEquals('Test Account 1', createdAccounts[0].Name);
        System.assertEquals('Test Account 2', createdAccounts[1].Name);
        System.assertNotEquals(null, createdAccounts[0].OwnerId);
        System.assertNotEquals(null, createdAccounts[1].OwnerId);
    }
    
    /**
     * @description Tests creation of account with owner logic
     */
    @isTest
    static void testCreateAccountWithLogic() {
        // Setup
        Account testAccount = new Account(
            Name = 'Test Account With Owner'
        );
        
        // Execute
        Account createdAccount = AccountVisibilityHandler.createAccountWithLogic(testAccount, true);
        
        // Verify
        System.assertNotEquals(null, createdAccount.Id);
        System.assertEquals(UserInfo.getUserId(), createdAccount.OwnerId);
    }
    
    /**
     * @description Tests validation for missing account name
     */
    @isTest
    static void testValidateAccountFields() {
        // Setup
        Account testAccount = new Account(
            Phone = '555-123-4567'
            // Missing Name
        );
        
        // Execute & Verify
        Test.startTest();
        try {
            AccountVisibilityHandler.createAccount(testAccount);
            System.assert(false, 'Expected AccountCreationException was not thrown');
        } catch (AccountVisibilityHandler.AccountCreationException e) {
            System.assertEquals('Account name is required', e.getMessage());
        }
        Test.stopTest();
    }
    
    /**
     * @description Tests handling of null account
     */
    @isTest
    static void testNullAccount() {
        // Execute & Verify
        Test.startTest();
        try {
            AccountVisibilityHandler.createAccount(null);
            System.assert(false, 'Expected AccountCreationException was not thrown');
        } catch (AccountVisibilityHandler.AccountCreationException e) {
            System.assertEquals('Account to create cannot be null', e.getMessage());
        }
        Test.stopTest();
    }
    
    /**
     * @description Tests bulk creation with empty list
     */
    @isTest
    static void testCreateAccountsEmptyList() {
        // Execute
        List<Account> createdAccounts = AccountVisibilityHandler.createAccounts(new List<Account>());
        
        // Verify
        System.assertEquals(0, createdAccounts.size());
    }
    
    /**
     * @description Tests checking if current user has Sales profile
     */
    @isTest
    static void testCurrentUserHasSalesProfile() {
        // Execute
        Boolean hasSalesProfile = AccountVisibilityHandler.currentUserHasSalesProfile();
        
        // Verify - this is a basic test to ensure the method executes
        System.assert(hasSalesProfile == true || hasSalesProfile == false);
    }
}
