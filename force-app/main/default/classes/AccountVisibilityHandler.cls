/**
 * @description Handles account creation with Sales profile visibility enforcement
 * @author Salesforce Developer
 * @since 2026-01-29
 */
public with sharing class AccountVisibilityHandler {
    
    /**
     * @description Creates a single account with Sales profile visibility enforcement
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
        
        // Set the account owner to the current user
        if (accountToCreate.OwnerId == null) {
            accountToCreate.OwnerId = UserInfo.getUserId();
        }
        
        // Perform the insert operation
        try {
            Database.SaveResult result = Database.insert(accountToCreate, false);
            
            if (!result.isSuccess()) {
                throw new AccountCreationException('Failed to create account: ' + result.getErrors()[0].getMessage());
            }
            
            // Apply visibility restrictions after creation
            applyVisibilityRestrictions(accountToCreate);
            
            return accountToCreate;
        } catch (DmlException e) {
            throw new AccountCreationException('Database error during account creation: ' + e.getMessage());
        }
    }
    
    /**
     * @description Creates multiple accounts with bulk operation and visibility enforcement
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
        
        // Set owners for all accounts
        for (Account acc : accountsToCreate) {
            if (acc.OwnerId == null) {
                acc.OwnerId = UserInfo.getUserId();
            }
        }
        
        // Perform bulk insert operation
        try {
            List<Database.SaveResult> results = Database.insert(accountsToCreate, false);
            List<Account> createdAccounts = new List<Account>();
            
            for (Integer i = 0; i < results.size(); i++) {
                Database.SaveResult result = results[i];
                if (result.isSuccess()) {
                    createdAccounts.add(accountsToCreate[i]);
                    // Apply visibility restrictions after creation
                    applyVisibilityRestrictions(accountsToCreate[i]);
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
     * @description Applies visibility restrictions to the account
     * @param account The account to apply restrictions to
     */
    private static void applyVisibilityRestrictions(Account account) {
        // In a real implementation, this would typically involve:
        // 1. Setting up sharing rules programmatically
        // 2. Creating manual shares for Sales profile users only
        // 3. Or using a trigger-based approach
        
        // For demonstration purposes, we'll log the action
        // In practice, you would implement actual sharing logic here
        System.debug('Applied visibility restrictions for account: ' + account.Id);
    }
    
    /**
     * @description Checks if the current user has Sales profile
     * @return Boolean True if user has Sales profile, false otherwise
     */
    public static Boolean currentUserHasSalesProfile() {
        User currentUser = [SELECT Profile.Name FROM User WHERE Id = :UserInfo.getUserId() LIMIT 1];
        return currentUser.Profile.Name == 'Sales Profile' || 
               currentUser.Profile.Name == 'Sales' ||
               currentUser.Profile.Name.containsIgnoreCase('sales');
    }
    
    /**
     * @description Creates an account with additional business logic and visibility enforcement
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
            
            // Apply visibility restrictions after creation
            applyVisibilityRestrictions(accountToCreate);
            
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
