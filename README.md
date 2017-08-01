# JBADMIN
- Admin Utility for WEB & CommandLine
- CLI is currently to keep track of and ping servers
- WEB can list and reformat data from google sheets and also ping servers

## Specs
- Ruby 2.4.0


## Production
```
# Using Thin Server - With Upstream in Nginx
bundle exec thin start -s3 -a 127.0.0.1


upstream    jbadmin {
   server 127.0.0.1:3000;
   server 127.0.0.1:3001;
   server 127.0.0.1:3002;
}

```
