
Task 1 : 
Powershell - Firewall
-------------------------------------------
script "task1firewall.ps1" that blocks connections from the client 
via http, https, dns protocols (80443 tcp ports, 53 udp).
All rules are taken from the firewallportlist.csv.
Name: Incoming/Outgoing: Accept/Block: protocol: port.
Configuration Command: New-NetFirewallRule
===========================================
