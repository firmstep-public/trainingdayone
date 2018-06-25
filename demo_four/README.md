# Demo Four

Clean up the resources!

By default, each AWS account has a limit of 100 buckets, so its always a good practice to remove your test resources.

First we will destroy the s3 objects created in [demo_three](../demo_three), then the bucket created in [demo_two](../demo_two) then the original bucket created in [demo_one](../demo_one) which is holding the state files.

In each of those directories, in that order run:
```bash
make destroy
```


