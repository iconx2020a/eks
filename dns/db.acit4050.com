$TTL    604800
@       IN      SOA     ns1.acit4050.com. root.acit4050.com. (
                  3       ; Serial
             604800     ; Refresh
              86400     ; Retry
            2419200     ; Expire
             604800 )   ; Negative Cache TTL
;
; name servers - NS records
       IN      NS      ns1.acit4050.com.

; name servers - A records
ns1.acit4050.com.          IN      A      172.20.0.2
host1.acit4050.com.        IN      A      172.20.0.3
host2.acit4050.com.        IN      A      172.20.0.4
