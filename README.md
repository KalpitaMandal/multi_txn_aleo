# multi_txn_t1.aleo

## .env file 
The private key can be obtained by using the `leo account` command.

```
NETWORK=testnet3
PRIVATE_KEY={PRIVATE_KEY}
```

## Build Guide

To compile this Aleo program, run:
```bash
leo build
```

To execute this Aleo program, run:

```bash
leo run transfer_public aleo1rn636g94mx3qqhf7m79nsne3llv4dqs25707yhwcrk92p0kwrc9qe392wg 3u64 2u64
```

```bash
leo run transfer_private aleo1rn636g94mx3qqhf7m79nsne3llv4dqs25707yhwcrk92p0kwrc9qe392wg 3u64 2u64
```
