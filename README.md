Kong Nexudus Webhook Hmac
====================

See Nexudus' [Verifying Webhooks Crerated via the API](https://web.archive.org/web/20240306131321/https://help.nexudus.com/v3/docs/verifying-webhooks-created-via-the-api).


Python equivalent:
```python3
import json
import hmac
import hashlib

SECRET = 'your_nexudus_wh_secret'

with open('payload.json', 'rb') as f:
    data = f.read().decode('utf-8').rstrip('\n').encode('utf-8')
h = hmac.new(SECRET.encode('ascii'), data, hashlib.sha256)
sig = h.digest().hex().upper()
print(sig)
```
