# KerberoastDetectNAlert
It detects possible Kerberoasting Attack and alert IT Administrators/IT Security team. This Powershell script get "Event ID 4769" and check "Ticket Encryption Type" if match to "0x17" value. If the condition is True, it will save simplified report and alert administrators. 


## Screenshots
### Simulated Kerberoast Attack to a domain controller.
![testberberoast](https://user-images.githubusercontent.com/32608046/214414763-93b674d3-f67b-4be6-83d2-aa525d64f4be.png)

### Event 4769 triggered and automatic msgBox alerted.
![alert-msg](https://user-images.githubusercontent.com/32608046/214415183-4e086f11-79b5-40cb-8cd4-39413b7ad5d8.png)

### Simplified Event report saved.
![sample-logs](https://user-images.githubusercontent.com/32608046/214415537-ae2a34a7-42d9-40af-8908-9a807c04be33.png)


## How to setup
1. Download kerberoast-checker.ps1 
2. Create new scheduled Task and set the Triggers and Actions settings below.
    ![tasksettings1](https://user-images.githubusercontent.com/32608046/214419128-7ebc1ecc-f05d-4870-86ec-5ec0f4d97ade.png)
    ![setactions](https://user-images.githubusercontent.com/32608046/214432199-ae491b34-a09f-456f-9677-3548e0676f7c.png)
4. Create honey-user and SPN account.
    ![setspn](https://user-images.githubusercontent.com/32608046/214421728-033adb29-1a40-45cf-9118-1648d28b37e6.png)
4. Important: Simulate Kerberoast attack to confirm your KerberoastDetectNAlert works. (see Screenshots)

## Addional Features:.
- You can enable option to send email notification to IT/Security admins email group.
  > Uncomment the "#Send-MailMessage" line and set your SMTP, From and To email address(es), Subject, Body, and Attachment file.
  ![email-option2](https://user-images.githubusercontent.com/32608046/214428377-f4cbf4d2-7471-40bb-947d-1cf0e9e46258.png)
