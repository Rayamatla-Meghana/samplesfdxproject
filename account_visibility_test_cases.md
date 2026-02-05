# Test Cases: Account Visibility for Sales Profile Users

## Requirement
"When an Account is created, it should be visible only to users with Sales profile."

## Test Case 1: Account Creation by Sales User - Access Verification
**Description**: Verify that an account created by a user with Sales profile is accessible to Sales users
**Preconditions**: 
- User with Sales profile exists
- Account creation functionality is implemented
**Steps**:
1. Log in as a user with Sales profile
2. Create a new Account record
3. Verify account is accessible in the UI/list views
4. Verify account is accessible via API calls
**Expected Result**: Account is visible and accessible to Sales users

## Test Case 2: Account Creation by Non-Sales User - Access Restriction
**Description**: Verify that an account created by a user without Sales profile is not visible to them
**Preconditions**:
- User without Sales profile exists
- Account creation functionality is implemented
**Steps**:
1. Log in as a user without Sales profile
2. Create a new Account record
3. Attempt to access the account as the same user
4. Verify account is not visible in UI/list views
5. Verify account is not accessible via API calls
**Expected Result**: Account is not visible to non-Sales users who created it

## Test Case 3: Account Access by Sales User - Cross-User Access
**Description**: Verify that Sales users can access accounts created by non-Sales users
**Preconditions**:
- Sales user exists
- Non-Sales user exists
- Account exists in system
**Steps**:
1. Log in as non-Sales user
2. Create a new Account record
3. Log in as Sales user
4. Attempt to access the account created by non-Sales user
5. Verify account is accessible
**Expected Result**: Account is accessible to Sales users regardless of who created it

## Test Case 4: Account Access by Non-Sales User - Cross-User Access
**Description**: Verify that non-Sales users cannot access accounts created by Sales users
**Preconditions**:
- Sales user exists
- Non-Sales user exists
- Account exists in system
**Steps**:
1. Log in as Sales user
2. Create a new Account record
3. Log in as non-Sales user
4. Attempt to access the account created by Sales user
5. Verify account is not accessible
**Expected Result**: Account is not accessible to non-Sales users who did not create it

## Test Case 5: Sharing Rule Configuration Validation
**Description**: Verify that sharing rules properly enforce Sales profile visibility
**Preconditions**:
- Sharing rules exist for Sales profile
- Account creation functionality is implemented
**Steps**:
1. Check sharing rules configuration in Setup
2. Create account as Sales user
3. Verify sharing rules applied correctly
4. Test access by different profile users
**Expected Result**: Sharing rules correctly restrict access to Sales profile users only

## Test Case 6: Bulk Account Creation with Profile Validation
**Description**: Verify bulk account creation respects profile visibility rules
**Preconditions**:
- Multiple users with different profiles exist
- Bulk account creation functionality is implemented
**Steps**:
1. Create multiple accounts via bulk operation with different user profiles
2. Verify access by different profile users
3. Validate that visibility rules apply consistently
**Expected Result**: Bulk creation respects visibility rules for all accounts

## Test Case 7: Account Ownership vs Visibility Separation
**Description**: Verify that account ownership does not override visibility rules
**Preconditions**:
- Different users with different profiles exist
- Account creation functionality is implemented
**Steps**:
1. Create account owned by non-Sales user
2. Verify access by Sales user
3. Verify access by non-Sales user
4. Confirm visibility rules override ownership
**Expected Result**: Visibility rules take precedence over ownership for access control

## Test Case 8: Permission Set Impact on Visibility
**Description**: Verify that Sales permission sets affect account visibility
**Preconditions**:
- Sales permission set exists
- User assigned to Sales permission set
**Steps**:
1. Assign Sales permission set to user
2. Create account as user with Sales permission set
3. Verify access by user with Sales permission set
4. Verify access by user without Sales permission set
**Expected Result**: Permission set assignment affects visibility appropriately

## Test Case 9: API Access Restrictions
**Description**: Verify API access respects profile visibility rules
**Preconditions**:
- API integration exists
- Account creation functionality is implemented
**Steps**:
1. Create account via API as Sales user
2. Access account via API as Sales user
3. Access account via API as non-Sales user
4. Verify access restrictions
**Expected Result**: API access respects visibility rules based on user profile

## Test Case 10: Edge Case - No Profile Assigned
**Description**: Verify behavior when user has no profile assigned
**Preconditions**:
- User with no profile assigned exists
- Account creation functionality is implemented
**Steps**:
1. Attempt to create account with user having no profile
2. Verify account access behavior
3. Check system behavior for profile-less users
**Expected Result**: Proper error handling or default behavior for profile-less users

## Test Case 11: Record Type Specific Visibility
**Description**: Verify visibility rules work with record types
**Preconditions**:
- Account record types exist
- Sharing rules configured for record types
**Steps**:
1. Create account with specific record type
2. Verify access by different profile users
3. Confirm record type doesn't interfere with visibility rules
**Expected Result**: Record type doesn't override visibility rules

## Test Case 12: Field-Level Security Impact
**Description**: Verify that field-level security doesn't interfere with visibility
**Preconditions**:
- Field-level security settings exist
- Account creation functionality is implemented
**Steps**:
1. Create account with restricted fields
2. Verify access by different profile users
3. Confirm field-level security doesn't override visibility rules
**Expected Result**: Field-level security doesn't override visibility rules
