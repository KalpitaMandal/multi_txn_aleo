import helper.aleo;
import fees.aleo;
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
    call helper.aleo/verify_balance self.caller r3 into r6;
    call helper.aleo/transfer_relayer self.caller r2 into r7;
    call fees.aleo/fees 1u64 4475150356817606778589882704590642323349436680698264689983438181844155595696field into r8 r9;
    cast r0 r1 into r10 as balance.record;
    async transfer_public r5 r6 r7 r9 self.caller r0 r1 into r11;
    output r10 as balance.record;
    output r11 as multi_txn_t1.aleo/transfer_public.future;

finalize transfer_public:
    input r0 as helper.aleo/mint_public.future;
    input r1 as helper.aleo/verify_balance.future;
    input r2 as helper.aleo/transfer_relayer.future;
    input r3 as fees.aleo/fees.future;
    input r4 as address.public;
    input r5 as address.public;
    input r6 as u64.public;
    await r0;
    await r1;
    await r2;
    await r3;
    get.or_use account[r4] 0u64 into r7;
    sub r7 r6 into r8;
    set r8 into account[r4];
    get.or_use account[r5] 0u64 into r9;
    add r9 r6 into r10;
    set r10 into account[r5];
