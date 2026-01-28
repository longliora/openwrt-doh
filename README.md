# How to using Nextdns on openwrt, xwrt , padavan ,... with http dns proxy

1. ssh to router (you can use terminal , termux ( android) , termius ( android) , cmd, ...)
copy & paste this command :
```
mkdir /opt/nextdns/ && cd /opt/nextdns/ && wget https://raw.githubusercontent.com/cuongctb/Nextdns_openwrt_http_dns_proxy/main/nextdns.sh
```

2. after running the above command , continue copying and pasting this command:
```
chmod +x nextdns.sh && vi nextdns_ids.txt 
```
3. after vi editor pops up, go to nextdns.io  login and create new profile copy & paste id .

![image](https://github.com/user-attachments/assets/76f92ae3-f473-4b77-8378-cb9960d4a883)

The vi editor appears like the image above.

![Screenshot_20241024-085853~3](https://github.com/user-attachments/assets/445a9243-b246-49c1-9761-e7222f8d95f6)

ID is in the position as shown in the picture.

 ![image](https://github.com/user-attachments/assets/2720117d-ca61-474b-a6e6-6b546504c967)

Paste the ID like the image above. 
4. Press Esc to return command and type " :wq " and press enter.
  ***One ID can perform up to 300k queries. You can create multiple accounts so you can do more searches. Just create an account and paste the id into the vi nextdns_ids.txt file.***
 *Note that each line must only have one ID.*

5. Run
  Just copy and pass the command line
```
/opt/nextdns/nextdns.sh
```
  

  ![image](https://github.com/user-attachments/assets/a72e3fc6-3747-4669-bea5-3d2dcd42a055)

The white part in the image is the nextdns ID you entered in the nextdns_ids.txt file,
  If it does not appear, check to see if the nextdns_ids.txt file has been added to the nextdns ID )

  ![image](https://github.com/user-attachments/assets/e3105c72-282e-4bf1-a23b-3ee5fc5e0110)
  
  Now on your https://my.nextdns.io/ page it will say "All good!
  This device is using NextDNS with this profile. " . This means that nextdns is active in your network .
  
  6. nextdns runs at startup

   you just need to add command enter cron .:
```
  @reboot opt/nextdns/nextdns.sh
```
   If you use openwrt, xwrt, you just need to access the router's admin page, then follow the steps: System > startup > Local Startup and paste the command 
 ```
   opt/nextdns/nextdns.sh 
 ```
   or you can ssh into the router and enter the command:
```
    vi /etc/rc.local
```

   paste the command: 
```
 opt/nextdns/nextdns.sh
``` 
   then press Esc and enter
" :wq " and you're done.

Các server nextdns ở Việt Nam 

Hồ Chí Minh:
hostname: greencloud-sgn-1.edge.nextdns.io
ips:
      103.186.65.82,
      2400:6ea0::1236:0:0:0:d6e2

hostname:
lightnode-sgn-1.edge.nextdns.io
    ips:  38.60.253.211
 
Hà Nội:
hostname: greencloud-han-1.edge.nextdns.io
ips: 
      103.199.17.192

 hostname:
lightnode-han-1.edge.nextdns.io
 ips: 
      38.54.31.178
