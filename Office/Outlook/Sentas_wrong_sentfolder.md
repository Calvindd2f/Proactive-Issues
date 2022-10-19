    I have a user(call him user A) who has Send As and Read and Manage rights on another users mailbox(Call him user B). 
    When User A sends an email as User B, the message does not save in the sent folder of User B, but instead saves in User A's sent folder. 
    
    + I need to have these sent messages save in user B's sent folder.
    
    
      PS: C:\> ipmo exchangeonlinemanagement
      PS: C:\> Connect-ExchangeOnline
      PS C:> Set-Mailbox userB@domain.lol -MessageCopyForSentAsEnabled $True
      PS C:> Disconnect-ExchangeOnline
      
      
      Can also be done for 'Send on behalf of
