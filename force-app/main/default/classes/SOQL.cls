/**
* The SOQL class serves as a primer into the Salesforce Object Query Language in Apex.
* It covers fundamental aspects such as SELECT statements, WHERE clauses, Relationship queries, and LIMIT keyword.
*
* This class introduces developers to the concept of retrieving data from Salesforce using SOQL. It provides
* a step-by-step guide on how to construct SOQL queries, filter results using WHERE clause, retrieve related
* records, and manage data volume using the LIMIT keyword.
* 
* Topics covered in this class include:
* - Understanding the structure of a SOQL query.
* - Crafting basic SELECT statements in SOQL.
* - Applying filters using the WHERE clause in SOQL.
* - Fetching related records using Relationship queries.
* - Controlling the amount of data retrieved using the LIMIT keyword.
* 
* Users of this class can expect to gain a solid understanding of SOQL in Apex and
* be prepared to handle data retrieval tasks in Salesforce development.
* 
* @author Katende Kinene
*/

public with sharing class SOQL { 
    
    /**
     * Question 1
     * Update/Uncomment the template code to create a method
     * Returns all leads from Salesforce Org
     * @return List of all leads with Id, LastName, Company, Phone, Email
     * Update the corresponding test class and testGetAllLeads method to cover this method
     */
    public static List<Lead> getAllLeads () {
        //  The body of the method
        List<Lead> allLeads =[SELECT Id, LastName, Company, Phone, Email FROM Lead];
        return allLeads;
    }

    /**
     * Question 2
     * Update/Uncomment the template code to create a method
     * Returns all contacts with first name of John.
     * @return A list of Contact records.
     * Update the corresponding test class and testGetContactsByFirstName method to cover this method
     */
    public static List<Contact> getContactsByFirstName (String fName) {
        
        //  The body of the method
        List<Contact> contactRecords=[SELECT Id, FirstName, LastName, Name FROM Contact WHERE FirstName=:fName];
        //System.debug('The result is ' + contactRecords);
        return contactRecords;
    }

    /**
     * Question 3
     * Update/Uncomment the template code to create a method
     * Returns the Contact Id for all contacts with last name of Smith or Jones
     * @return A list of Contact Ids.
     * Update the corresponding test class and testGetContactIdsByLastName method to cover this method
     */
    public static List<Id> getContactIdsByLastName (List <Contact> contacts) { 
        //i don't need the list of contacts... but I am having trouble resolving this
        List <String> lastNamesToSearchFor = new List <String>{'Smith', 'Jones'};
        //  The body of the method
        List<Contact> contactIds = [
            SELECT Id, LastName 
            FROM Contact 
            WHERE LastName IN :lastNamesToSearchFor
        ];

       List<Id> contactIdsList = new List<Id>();
       for (Contact con : contactIds){
               if(con.Id != null){
                    contactIdsList.add(con.Id);
               }
       }
       return contactIdsList;

    }   

    /**
     * Question 4
     * Update/Uncomment the template code to create a method
     * Returns List of closed won opportunities for a specific Account.
     * Example: yourMethodName('001XXXXXXXXXXXX') should return the list of closed won opportunities for the Account with the Id
     * @param accountId The ID of the Account.
     * @return A list of Opportunities with important opportunities fields
     * Update the corresponding test class and testGetClosedWonOpportunityCountByAccount method to cover this method
     */
    public static List<Opportunity> getClosedWonOpportunityCountByAccount (String accountId) {
        //  The body of the method
        //a_type a = new a_type();
        List<Opportunity> closedWonOpps = [
            SELECT AccountId, Name, IsWon, Amount, CloseDate 
            FROM Opportunity 
            WHERE AccountId = :accountId AND IsWon = true
        ];

        return closedWonOpps;
    }

    /**
     * Question 5
     * Update/Uncomment the template code to create a method
     * Returns the total count of Account records.
     * @return The Integer count of Account records.
     * Update the corresponding test class and testGetAccountCount method to cover this method
     */
    public static Integer getAccountCount (List <Account> accounts) {
    //  The body of the method
        Integer acctCount = [
            SELECT COUNT() 
            FROM Account 
            WHERE Id IN :accounts
        ];
    
        return acctCount;
    }

    /**
     * Question 6
     * Update/Uncomment the template code to create a method
     * Return Key Value pair of Task Id and Task records for any tasks due date within the next 7 days.
     * @return A map of Task Ids to Task records.
     * Update the corresponding test class and testGetTasksDueNextWeek method to cover this method
     */
    public static Map<Id, Task> getTasksDueNextWeek  () {
    //  The body of the method
    //The constructor new Map<Id, SObject>(List<SObject>) inherently associates the Id of each object with its respective record. In this case Id with Task Object
        Map<Id, Task> tasksDueNextWeekMap = new Map<Id, Task>(        
            [SELECT Id, ActivityDate, OwnerId, Subject, Status, Priority
            FROM Task
            WHERE ActivityDate <= :Date.today().addDays(7) 
            AND ActivityDate >= :Date.today()]
        );

        return tasksDueNextWeekMap;

        
    }
    

    /**
     * Question 7
     * Update/Uncomment the template code to create a method
     * Retrieves all Contacts that have a example.com domain in their Email.
     * @return A list of Contact records.
     * Update the corresponding test class and testGetContactsByEmailDomain method to cover this method
     */
    public static List<Contact> getContactsByEmailDomain () {
        //  The body of the method
        List <Contact> allContacts = [SELECT Id, FirstName, LastName, Name, Email FROM Contact WHERE Email LIKE '%example.com'];

        return allContacts;
    }

    /**
     * Question 8
     * Retrieves all Opportunities that have a specific keyword in their Name.
     * Example: getOpportunitiesByNameKeyword('keyword') should return all Opportunities that have 'keyword' in their Name.
     * @param keyword The keyword to search for in the Opportunity Name.
     * @return A list of Opportunity records.
     */
    public static List<Opportunity> getOpportunitiesByNameKeyword(String keyword) {

        String searchString='%'+keyword+'%';
        List<Opportunity> keywordOpps =[SELECT Name, StageName, CloseDate, AccountId FROM Opportunity WHERE Name LIKE :searchString];
        return keywordOpps; // Replace null with the variable you used to store the result
    }

    /**
     * Question 9
     * Retrieves all Cases that Case Origin is not Web or Email or Blank
     * @return A list of Case records.
     */
    public static List<Case> getFilterCaseOrigins() {
        List<Case> caseOriginList =[SELECT Status, AccountId, Origin FROM Case WHERE Origin NOT IN ('Web', 'Email' , '') ];
        return caseOriginList; // Replace null with the variable you used to store the result
    }

    /**
     * Question 10
     * Update/Uncomment the template code to create a method
     * Retrieves all Leads that have a specific Lead Source or contain a specific keyword in their Title.
     * Example: yourMethodName('Web', 'Engineer') should return all Leads that have 'Web' in their Lead Source or 'Engineer' in their Title.
     * @param leadSource The Lead Source to search for.
     * @param keyword The keyword to search for in the Lead Title.
     * @return A list of Lead records.
     * Update the corresponding test class and testGetLeadsBySourceOrTitle method to cover this method
     */
    public static List<Lead> getLeadsBySourceOrTitle (String leadSource, String keyWord) {
        String stringToSearchFor ='%'+keyWord+'%';
        //  The body of the method
        List<Lead> leadRecs=[
            SELECT LastName, Company, Phone, Email, LeadSource, Title FROM Lead 
            WHERE leadSource = :leadSource OR Title LIKE :stringToSearchFor
        ];
        //The keyword LIKE can be interpreted as contains when % is used on both sides of a string

        return leadRecs;
    }    

    /**
     * Question 11
     * Returns the names of all Contacts associated with an Account.
     * Example: getContactNamesByAccount('001XXXXXXXXXXXX') should return the list of Contact LastNames for the Account with the Id
     * @param accountId The ID of the Account.
     * @return A list of Contact LastName.
     */
    public static List<String> getContactNamesByAccount(Id accountId) {
        // Create a list to hold the Contact LastNames
        List<String> allLastNames= new List<String>();

        // Query the Contacts
        List<Contact> allAccountContacts=[SELECT LastName FROM Contact WHERE AccountId = :accountId ];
        //Account.Id is incorrect. AccountId is the standard field on Contact object.

        // Loop through each Contact and add the LastName to the list
        for (Contact tempContact: allAccountContacts) {
        //    
            allLastNames.add(tempContact.LastName);
        }

        // Return the list of Contact LastNames
        return allLastNames; // Replace null with the variable you used to store the result
    }

    /**
     * Question 12
     * Returns the total revenue for all Opportunities in a specific Stage or if the amount is greater than 10000.
     * Example: getTotalRevenueByStage('Closed Won') should return the total revenue for the found opportunities
     * @param stage The Stage value to filter Opportunities.
     * @return The total revenue.
     */
    public static Decimal getTotalRevenueByStage(String stage) {
        // Use AggregateQuery to get the total revenue
        //Decimal totalRev=[SELECT SUM(Amount) totalAmount FROM Opportunity WHERE StageName = :stage];
        AggregateResult[] totalRev= [
            SELECT SUM(Amount) totalAmount 
            FROM Opportunity 
            WHERE StageName = :stage OR Amount >10000
        ];
        // Return the total revenue
         // Check if there are any results and handle null values
        if (totalRev != null && totalRev.size() > 0) {
            Object totalAmount = totalRev[0].get('totalAmount');
            
            // Return the total revenue or 0 if null
            return totalAmount != null ? (Decimal)totalAmount : 0;
        }
        return 0; // Default to 0 if no records are found
    }

    /**
     * Question 13
     * Retrieves the first 10 Accounts ordered by Name.
     * @return A list of the first 10 Accounts ordered by Name.
     */
    public static List<Account> getFirstTenAccounts() {
        // Replace null with the variable you used to store the result
        return [
            SELECT ID, Name 
            FROM Account 
            ORDER BY Name 
            LIMIT 10
        ];

    }
    
    /**
     * Question 14
     * Retrieves the Opportunities with an Amount greater than 100,000, ordered by CloseDate, and limited to 5 records.
     * @return A list of Opportunities with an Amount greater than 100,000, ordered by CloseDate, and limited to 5 records.
     */
    public static List<Opportunity> getHighValueOpportunities() {
        List<Opportunity> highOpps =[SELECT Name, Amount, CloseDate
        FROM Opportunity
        WHERE Amount > 100000
        ORDER BY CloseDate ASC
        LIMIT 5];
        return highOpps; // Replace null with the variable you used to store the result
    }
    
    /**
     * Question 15
     * Retrieves the Contacts with the most recent Birthdate, ordered by Birthdate, and limited to 3 records.
     * @return A list of Contacts
     */
    public static List<Contact> getBirthdateContacts() {
        List<Contact> recentBdays =[SELECT Name, Birthdate
        FROM Contact
        WHERE Birthdate <= TODAY
        ORDER BY Birthdate DESC
        LIMIT 3];
        return recentBdays; // Replace null with the variable you used to store the result
    }
    
    /**
     * Question 16
     * Retrieves the Cases in the Open Status, ordered by CreatedDate, and limited to 10 records with an offset of 5.
     * @return A list of Cases
     */
    public static List<Case> getCasesWithStatus() {
        List<Case> openCaseList=[SELECT Status, CreatedDate, CaseNumber
        FROM Case
        WHERE Status != 'Closed'
        ORDER BY CreatedDate ASC
        LIMIT 10 OFFSET 5];
        return openCaseList; // Replace null with the variable you used to store the result
    }

    /**
     * Question 17
     * Returns Set of Case Ids for a specific Account.
     * Example: getCaseIdsByAccount('001XXXXXXXXXXXX') should return the set of Case Ids for the Account with the Id
     * @param accountId The ID of the Account.
     * @return A set of Case Ids.
     */
    public static Set<Id> getCaseIdsByAccount(Id accountId) {
        // Create a set to hold the Case Ids
        Set<Id> holdCaseIds = new Set<Id>();

        // Query the Cases
        List<Case> acctCases=[SELECT AccountId, Id
        FROM Case
        WHERE AccountId = :accountId];
        // Loop through each Case and add the Id to the set
        for (Case tempCase: acctCases) {
        //    
            holdCaseIds.add(tempCase.Id);
        }

        return holdCaseIds; // Replace null with the variable you used to store the result
    }

    /**
     * Question 18
     * Return Map of Account Ids to Account Names Not in a specific Country.
     * Example: getAccountIdsToNamesNotInCountry('United States') should return the map of Account Ids to Account Names for Accounts that are not in the United States.
     * @param country The country to filter Accounts.
     * @return A map of Account Ids to Account Names.
     */
    public static Map<Id, String> getAccountIdsToNamesNotInCountry(String country) {
        // Create a map to hold the Account Ids to Account Names
        Map<Id, String> accountIdsToNames = new Map<Id, String>();

        // Query the Accounts
        List<Account> acctsNotInCountry =[SELECT Id, Name
        FROM Account
        WHERE BillingCountry != :country];
        // Loop through each Account and add the Id and Name to the map
        for(Account tempAcct: acctsNotInCountry){
            accountIdsToNames.put(tempAcct.Id, tempAcct.Name);

        }

        return accountIdsToNames; // Replace null with the variable you used to store the result
    }

    /**
     * Question 19
     * Retrieves the Account Name for a given Contact.
     * Example: getAccountNameForContact('003XXXXXXXXXXXX') should return the Account Name for the Contact with the Id
     * @param contactId The Id of the Contact.
     * @return The Account Name of the Contact.
     */
    public static String getAccountNameForContact(String contactId) {
       /* String acctName='';

        List<Contact> contactInfo=[SELECT Account.Name
        FROM Contact
        WHERE Id = :contactId];
        

        // Check if a contact was found and its Account is not null
        if (!contactInfo.isEmpty() && contactInfo[0].Account != null) {
            acctName = contactInfo[0].Account.Name;            
        }*/

        Contact contactRec = [SELECT Account.Name
                              FROM Contact
                              Where Id = :contactId
                            ]; // Replace null with the variable you used to store the result

        return contactRec.Account != null ? contactRec.Account.Name : 'Account Does not Exist';
    }    

    /**
     * Question 20
     * Returns single Account that has related opportunities in the same query
     * Example: getAccountAndOpportunitiesFromAccountId('001XXXXXXXXXXXX') should return the Account Name for the Account with the Id and all related Opportunities
     * @param accountId The ID of the Account.
     * @return An Account record with related Opportunities.
     */
    public static Account getAccountAndOpportunitiesFromAccountId(Id accountId) {
        Account accountWithOpportunities = [SELECT Id, Name, 
            (SELECT Id, Name, Amount, CloseDate FROM Opportunities)
        FROM Account 
        WHERE Id = :accountId
        LIMIT 1];
        return accountWithOpportunities;
    }

    /**
     * Question 21
     * Retrieves all contacts that have the Mailing State similar to the Account Billing State.
     * Example: getAccountsWithContactsByState('001XXXXXXXXXXXX') should return a list of Contacts that have the same Mailing State as the Account with the Id
     * @param Account Id
     * @return List of contacts with the same Mailing State as the Account Billing State
     */
    public static List<Contact> getAccountsWithContactsByState(Id accountId) {
        // Query the Account
        Account acctBillingState = [SELECT Id, Name, BillingState
    FROM Account
    WHERE Id = :accountId
    LIMIT 1];
        // Store the Account's BillingState
        String billState= acctBillingState.BillingState;
        // Query the Contacts
        List<Contact> contactsMailState= [SELECT Name, Email, MailingState, Id From Contact WHERE MailingState = :billState];
        return contactsMailState; // Replace null with the variable you used to store the result
    }

    /**
     * Question 22
     * Extracts email domains from them leads, then finds Accounts with matching website domains
     * If Lead Email = test@test.com return account with website = www.test.com
     * Example: findAccountsByLeadEmailDomains([set of lead ids]) should return a list of Accounts with matching email domains
     * @param A set of Lead Ids.
     * @return A list of Accounts with matching email domains.
     */
    public static List<Account> findAccountsByLeadEmailDomains(Set<Id> leadIds) {
        // Query the Leads
        List <Lead> listOfLeads = [SELECT Id, Email, Name, Company, LastName, Status, Website FROM Lead WHERE Id IN :leadIds];
        // Create a set of email domains from the Leads 
        Set<String> emailDomains=new Set<String>();
        for(Lead tempLead: listOfLeads){
            if(tempLead.Email!=null){
                String tempLeadDomain = tempLead.Email.substringAfter('@');
                String tempWebsite='www.'+tempLeadDomain;
                emailDomains.add(tempWebsite);
            }
        }
        
        // Loop through each Lead

            // Get the email from the Lead

            // Check if the email is not null

                // Add the email domain to the set

        
        // Query the Accounts
        List<Account> acctDomains=[SELECT Id, Website FROM Account WHERE Website IN :emailDomains];
        return acctDomains; // Replace null with the variable you used to store the result
    }

    /**
     * Question 23
     * Clones and Inserts Opportunity Line Items from an original Opportunity to a list of cloned Opportunities.
     * Adds a randomized number between 1 to 3 to the quantity of each line item.
     * Example: cloneLineItems('001XXXXXXXXXXXX', [list of opportunity ids]) should clone the line items from the Opportunity with the Id to each Opportunity in the list
     * @param Original Opportunity Id
     * @param List of cloned Opportunity Ids
     */
    public static void cloneLineItems(Id origOppId, List<Id> cloneOppIds) {
        // Query the original Opportunity Line Items
        List<OpportunityLineItem> oppLineItems = [
            SELECT Id, OpportunityId, Product2Id, Quantity, UnitPrice, PricebookEntryId
            FROM OpportunityLineItem
            WHERE OpportunityId = :origOppId
        ];

        // Create a list to hold the new line items
        List<OpportunityLineItem> clonedLineItems = new List<OpportunityLineItem>();

        // Generate a random number between 1 and 3
        Integer random1To3 = (Integer)Math.ceil(Math.random() * 3);

        // Loop through each cloned Opportunity Id
        for (Id cloneOppId : cloneOppIds) {
            for (OpportunityLineItem origLineItem : oppLineItems) {
                // Clone the original line item
                OpportunityLineItem newLineItem = (OpportunityLineItem) origLineItem.clone(false, false, false, false);
                
                // Update the cloned line item fields
                newLineItem.OpportunityId = cloneOppId;
                newLineItem.Quantity += random1To3;
                
                // Add the cloned line item to the list
                clonedLineItems.add(newLineItem);
            }
        }

        // Insert the new line items
        if (!clonedLineItems.isEmpty()) {
            insert clonedLineItems;
        }
    }

    
    /**
     * Question 24
     * Retrieves the Opportunity Name, Account Name, and Owner Name for Opportunities that have a Stage of 'Closed Won'.
     * Example: getOpportunityDetailsForClosedWon()
     * @return A list of filtered Opportunity
     */
    /*public static List<Opportunity> getOpportunityDetailsForClosedWon() {    
        List<Opportunity> oppDetailsClosedWon = [
            SELECT Name, AccountId, Account.Name, OwnerId, Owner.Name
            FROM Opportunity
            WHERE StageName = 'Closed Won'
            ];
        return oppDetailsClosedWon; // Replace null with the variable you used to store the result
    }*/
    public static List<Opportunity> getOpportunityDetailsForClosedWon() {    
        List<Opportunity> oppDetailsClosedWon = [
        SELECT Name, AccountId, Account.Name, OwnerId
        FROM Opportunity
        WHERE StageName = 'Closed Won' AND Name = 'Test Opportunity 1'
        ];
        return oppDetailsClosedWon; // Replace null with the variable you used to store the result
    }

    /**
     * Question 25
     * Sets the 'Primary_Contact__c' field for all Closed Won Opportunities to first Contact on the Account.
     * Example: setPrimaryContact() should set the 'Primary_Contact__c' field for every Opportunity in the org
     */
    public static void setPrimaryContact() {
        // Step 1: Use the getOpportunityDetailsForClosedWon() method to get the Opportunities
        List<Opportunity> listOpps=SOQL.getOpportunityDetailsForClosedWon();

        // Step 2: Create a set of Account Ids from the Opportunities
        Set<Id> acctIDs=new Set<Id>();
        for(Opportunity tempOpp: listOpps){
            if(tempOpp.AccountId != null){
                acctIDs.add(tempOpp.AccountId);
            }
        }

        //Step 3 Query the Contacts- Assuming we want the Contact ID's
        List<Contact> oppContactIds=[SELECT AccountId, Id
        FROM Contact
        WHERE AccountId IN :acctIDs];

        // Loop through each Contact and add the Account Id and Contact to the map
        // Create a Map to hold AccountId as key and a list of Contacts as value
        Map<Id, List<Contact>> accountToContactsMap = new Map<Id, List<Contact>>();

        for (Contact tempContact: oppContactIds) {
        //    
            if(tempContact.Id != null){
              
                // Check if the map already contains the AccountId
                if (!accountToContactsMap.containsKey(tempContact.AccountId)) {
                    // If no, create a new list with this contact and put it in the map
                    
                    accountToContactsMap.put(tempContact.AccountId, new List<Contact> ());
                } else {
                    // If yes, add the contact to the existing list
                    accountToContactsMap.get(tempContact.AccountId).add(tempContact);
                }
            }
        }
        // Loop through each Opportunity
        for (Opportunity tempOpp : listOpps) {
            // Check if the Opportunity's AccountId exists in the map
            if (accountToContactsMap.containsKey(tempOpp.AccountId)) {
                // Get the list of Contacts for the Account
                List<Contact> contactsForAccount = accountToContactsMap.get(tempOpp.AccountId);

                //System.debug('List of Contacts '+ contactsForAccount);

                // Check if the list is not empty
                if (!contactsForAccount.isEmpty()) {
                    // Update the Opportunity's Primary Contact field
                    // Assuming Primary_Contact__c is a custom lookup field on Opportunity for Contact
                   // System.debug('tempOpp.Primary '+ tempOpp.Primary_Contact__c);
                    tempOpp.Primary_Contact__c = contactsForAccount[0].Id; // Assign the first Contact's Id
                }
            }
        }

        // Perform DML to update the opportunities
        if (!listOpps.isEmpty()) {
            update listOpps; // Save the updated Opportunities
        }
    }
    
}