# MyOps Twilio Module

This module provides support for sending text messages using [Twilio](https://twilio.com)
in [MyOps](https://myops.io). To use this in your MyOps installation just follow the instructions below.

## Installation

Add `myops-twilio` plus required configuration to your MyOps configuration file at `/opt/myops/config/myops.yml`.

```yaml
modules:
  -
    name: myops-twilio
    config:
      account_sid: xxx
      auth_token: xxx
      messaging_service_sid: xxx
```

Once, you've done this you can reinitize the application and restart it.

```
$ myops update-modules
$ myops restart
```
