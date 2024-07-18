# Powershell script to detect a Hardware error event and send an Email.

![HardwareAlert](https://github.com/user-attachments/assets/77a91e0b-f020-4888-bca8-d3f2d4579c83)

### Configuration.
**Script:** alert.ps1

a) Add email address

b) Task Scheduler

       - create task
       - Triggers: Begin the Task --> On an Event
       - Custom --> New Event Filter
       -            Choose event level (Critical, Error, etc)
                    By Source -->  Choose of 'WHEA'  listings.  [Windows Hardware Error Architecture (WHEA)]

       Action:
           Program script:  C:\Windows\System32\WindowsPowerShell\v1.0\powershell_ise.exe
           Adda arguments:    alert.ps1
