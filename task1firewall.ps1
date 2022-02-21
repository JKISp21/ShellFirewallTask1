$data=Import-Csv "C:\Users\Administrator\Downloads\firewallportlist.csv" -Header port,tcpudp,action,description
$remote_host=New-PSSession -ComputerName 192.168.0.2 -Credential Render
foreach ($str in $data)
{
   Invoke-Command -ScriptBlock{
      New-NetFirewallRule -DisplayName "Stop firewall INcoming traffic" -Direction Inbound -LocalPort $Using:str.port -Protocol $Using:str.tcpudp -Action $Using:str.action -Description $Using:str.description | Out-Null
      New-NetFirewallRule -DisplayName "Stop firewall OUTgoing traffic" -Direction Outbound -LocalPort $Using:str.port -Protocol $Using:str.tcpudp -Action $Using:str.action -Description $Using:str.description | Out-Null
          
      Write-Host "Port number "$Using:str.port" firewall stopped INcoming and OUTgoing traffic" -BackgroundColor DarkRed

    } -Session $remote_host
}


Invoke-Command -ScriptBlock{
Write-Host "You can delete created firewall rulle with name:" -ForegroundColor Red
Write-Host "'Stop firewall INcoming traffic' and 'Stop firewall OUTgoing traffic'" 
$yn=Read-Host "Enter some value: y/n "

    switch($yn){
        "y" {
            Remove-NetFirewallRule -DisplayName "Stop firewall INcoming traffic"
            Remove-NetFirewallRule -DisplayName "Stop firewall OUTgoing traffic"
            Write-Host  "firewall rulle with name:" 
            Write-Host " 'Stop firewall INcoming traffic'" -ForegroundColor Green " - was removed"
            Write-Host " 'Stop firewall OUTgoing traffic'" -ForegroundColor Green " - was removed"
          }

        default{
            Write-Host  "Warning! firewall rulle with name:" 
            Write-Host " 'Stop firewall INcoming traffic'" -ForegroundColor Green " - was removed"
            Write-Host " 'Stop firewall OUTgoing traffic'" -ForegroundColor Green " - was removed"
                }
        
    }
} -Session $remote_host
