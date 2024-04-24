import helper.aleo;
program multi_txn_t1.aleo;

record balance:
    owner as address.private;
    amount as u64.private;


mapping account:
	key as address.public;
	value as u64.public;

function transfer_public:
    input r0 as address.public;
    input r1 as u64.public;
    input r2 as u64.public;
    add r1 r2 into r3;
    call helper.aleo/mint_public self.caller r3 into r4 r5;
    cast r0 r1 into r6 as balance.record;
    async transfer_public r5 self.caller r0 r1 into r7;
    output r6 as balance.record;
    output r7 as multi_txn_t1.aleo/transfer_public.future;

finalize transfer_public:
    input r0 as helper.aleo/mint_public.future;
    input r1 as address.public;
    input r2 as address.public;
    input r3 as u64.public;
    await r0;
    get.or_use account[r1] 0u64 into r4;
    sub r4 r3 into r5;
    set r5 into account[r1];
    get.or_use account[r2] 0u64 into r6;
    add r6 r3 into r7;
    set r7 into account[r2];
