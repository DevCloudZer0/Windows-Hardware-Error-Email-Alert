# Powershell script
# When a hardware error (critical /error) occur on the event logger an email is sent.
# Configuration:
#  1) Task Scheduler
#       - create task
#       - Triggers: Begin the Task --> On an Event
#       - Custom --> New Event Filter
#       -            Choose event level (Critical, Error, etc)
#                    By Source -->  Choose of 'WHEA'  listings.  [Windows Hardware Error Architecture (WHEA)]
#
#       Action:
#           Program script:  C:\Windows\System32\WindowsPowerShell\v1.0\powershell_ise.exe
#           Adda arguments:    alert.ps1




#Define Query

$xml = @'
<QueryList>
  <Query Id="0" Path="System">
    <Select Path="System">*[System[Provider[@Name='Microsoft-Windows-Kernel-WHEA' or @Name='Microsoft-Windows-WHEA-Logger'] and (Level=1  or Level=2)]]</Select>
  </Query>
</QueryList>
'@ 


# Get Last Event
$A = Get-WinEvent -MaxEvents 1  -filterXml  $xml
$EventID = $A.Id
$MachineName = $A.MachineName
$Source = $A.ProviderName
$Message = $A.Message

# Please change email details below. Below is configured for gmail.

$EmailFrom = "myEmail@gmail.com"
$EmailTo = "myEmail@gmail.com"
$Subject ="Alert: Critical|Error Event From $MachineName"
$Body = "EventID: $EventID`nSource: $Source`nMachineName: $MachineName `nMessage: $Message"
$SMTPServer = "smtp.gmail.com"
$SMTPClient = New-Object Net.Mail.SmtpClient($SmtpServer, 587)
$SMTPClient.EnableSsl = $true
$SMTPClient.Credentials = New-Object System.Net.NetworkCredential("myEmail@gmail.com", "**********");
$SMTPClient.Send($EmailFrom, $EmailTo, $Subject, $Body)


# END