## Collect Security EventID 4769 (Kerberos Service Ticket Operations) from Security Event logs. ##
## Alert/notify IT Administrators or IT Security group for possible Kerberoasting attack. ##

## Collect EventID 4769 from last 2 minutes event triggered. ##
$kerberoastEvent = Get-EventLog -LogName Security -InstanceId 4769 -After ((get-date).AddMinutes(-2))

## Verify each EventID 4769 to match string "0x17"=RC4-HMAC Ticket Encryption Type. ##
foreach ($krbroast in $kerberoastEvent) {
    if (($krbroast | % { $_.Message.Split("`n")[17]}) -match "0x17") {
    ## Set variables for each part of eventlog to rewrite simple log file. ##
    ## used split and replace to trim strings ##
    $logtime = $krbroast.TimeGenerated
    $eventID = $krbroast.EventID
    $accName =  $krbroast | % { $_.Message.Split("`n")[3] -replace '\s',''}
    $sourceIP = $krbroast | % { $_.Message.Split("`n")[12] -replace '::ffff:','' -replace '\s'}
    $encval = $krbroast | % { $_.Message.Split("`n")[17] -replace '\s',''}
    $failcode = $krbroast | % { $_.Message.Split("`n")[18] -replace '\s',''}
    $targetacc = $krbroast | % { $_.Message.Split("`n")[8] -replace '\s',''}
    
    ## Construct a simplified event report for Kerberoasting Attack. ##
    $data = @"
Source IP Address / Attacker account:
    $accName
    $sourceIP

Target Account:
    $targetacc

Other Info: (RC4-HMAC Ticket Encryption Type Detected!)
    $encval
    TimeGenerated:$logtime
    EventID:$eventID
"@
    
    ## Export simplified event report to local drive. ##
    $filename = "C:\Temp\KerberoastEvent-"+$krbroast.EventID+"_Index"+$krbroast.Index+".txt"
    $data | Out-File $filename
    
    ## Prompt msgbox alert to all loggedon users in the local machine. ##
    msg.exe * "Possible Kerberoast Attack Detected!
    Please check $filename"
    
    ## Send email notification with the simplified event report. ##
    Send-MailMessage -From "machineName@youremail.address" -To "to@recipient.address" -Attachments $filename -Subject "Possible Kerberoast Attack Detected!" -Body "Please check $filename" -BodyAsHtml -SmtpServer "yourMailserverAddress"
    }
}
