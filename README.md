# crypto_slack_notif
Use a cron to track a list of crypto by sending messages by slack.



You will receive a message like this one : 

## Filecoin
<img src="./slack_msg_filecoin.png" alt="Result"/>

## Bitecoin
<img src="./slack_msg_bitcoin.png" alt="Result"/>

# 1. Create a slack app
It's important to create a slack app to receive a message, you can easily do it : https://api.slack.com/messaging/webhooks

# 2. Export slack hook
You can add to your bash,zsh.. or other, the line :

```bash
# example : https://hooks.slack.com/services/XXXX/YYYYY/ZZZZ
export SLACK_HOOK="YOU_SLACK_HOOK"
```
# 3.Clone the projet or simply copy the script
if you copy the script, don't forget chmod +x coinslacknotif.sh
# 4.Setup the cron
Very simple to do, for exap to run the script [every 4h](https://crontab.guru/every-4-hours)

```bash
# ~/bashScripts/coinbashSlack.sh => path to the script
0 */4 * * * ~/bashScripts/coinbashSlack.sh "bitecoin"
```