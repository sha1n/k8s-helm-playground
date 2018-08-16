# Sample upgrade/install command

```bash
$NSNAME=XXX

helm upgrade --install --set config.test=v1 --set namespace.name=$NSNAME echo-server-$NSNAME charts/echo-server/echo-server-0.1.8.tgz
```

# Sample upgrade command that forces pod recreation

```bash
$NSNAME=XXX

helm upgrade --recreate-pods --set namespace.name=$NSNAME echo-server-$NSNAME charts/echo-server/echo-server-0.1.8.tgz
```
