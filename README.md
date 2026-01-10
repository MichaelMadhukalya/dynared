### Introduction
Cloud native `persistent` KV (Key Value) store. The structural topology is similiar to what is used by Redis: sharding over a fixed number of slots (16384). 
Compute and storage is delegated to `DynamoDB_local`. 
For high availability configuration, every instance will have a secondary replica available as `standby`.