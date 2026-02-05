/**
 * @description Handles account creation logic with proper error handling and validation
 * @author Salesforce Developer
 * @since 2026-01-29
 */
public with sharing class AccountCreationHandler {
    
    /**
     * @description Creates a single account with proper validation
     * @param accountToCreate The account object to be created
     * @return Account The created account record
     */
    public static Account createAccount(Account accountToCreate) {
        // Return early if null
        if (accountToCreate == null) {
            throw new AccountCreationException('Account to create cannot be null');
        }
        
        // Validate required fields
        validateAccountFields(accountToCreate);
        
        // Perform the insert operation
        try {
            Database.SaveResult result = Database.insert(accountToCreate, false);
            
            if (!result.isSuccess()) {
                throw new AccountCreationException('Failed to create account: ' + result.getErrors()[0].getMessage());
            }
            
            return accountToCreate;
        } catch (DmlException e) {
            throw new AccountCreationException('Database error during account creation: ' + e.getMessage());
        }
    }
    
    /**
     * @description Creates multiple accounts with bulk operation
     * @param accountsToCreate List of account objects to be created
     * @return List<Account> The created account records
     */
    public static List<Account> createAccounts(List<Account> accountsToCreate) {
        // Return early if null or empty
        if (accountsToCreate == null || accountsToCreate.isEmpty()) {
            return new List<Account>();
        }
        
        // Validate all accounts
        for (Account acc : accountsToCreate) {
            validateAccountFields(acc);
        }
        
        // Perform bulk insert operation
        try {
            List<Database.SaveResult> results = Database.insert(accountsToCreate, false);
            List<Account> createdAccounts = new List<Account>();
            
            for (Integer i = 0; i < results.size(); i++) {
                Database.SaveResult result = results[i];
                if (result.isSuccess()) {
                    createdAccounts.add(accountsToCreate[i]);
                } else {
                    throw new AccountCreationException('Failed to create account: ' + result.getErrors()[0].getMessage());
                }
            }
            
            return createdAccounts;
        } catch (DmlException e) {
            throw new AccountCreationException('Database error during bulk account creation: ' + e.getMessage());
        }
    }
    
    /**
     * @description Validates required fields for an account
     * @param account The account to validate
     */
    private static void validateAccountFields(Account account) {
        if (String.isBlank(account.Name)) {
            throw new AccountCreationException('Account name is required');
        }
        
        // Additional validations can be added here
        // For example: validate phone number format, email format, etc.
    }
    
    /**
     * @description Creates an account with additional business logic
     * @param accountToCreate The account object to be created
     * @param shouldSetOwner Flag to determine if owner should be set
     * @return Account The created account record
     */
    public static Account createAccountWithLogic(Account accountToCreate, Boolean shouldSetOwner) {
        // Return early if null
        if (accountToCreate == null) {
            throw new AccountCreationException('Account to create cannot be null');
        }
        
        // Set owner if requested
        if (shouldSetOwner && accountToCreate.OwnerId == null) {
            accountToCreate.OwnerId = UserInfo.getUserId();
        }
        
        // Validate required fields
        validateAccountFields(accountToCreate);
        
        // Perform the insert operation
        try {
            Database.SaveResult result = Database.insert(accountToCreate, false);
            
            if (!result.isSuccess()) {
                throw new AccountCreationException('Failed to create account: ' + result.getErrors()[0].getMessage());
            }
            
            return accountToCreate;
        } catch (DmlException e) {
            throw new AccountCreationException('Database error during account creation: ' + e.getMessage());
        }
    }
    
    /**
     * @description Custom exception class for account creation errors
     */
    public class AccountCreationException extends Exception {}
}
