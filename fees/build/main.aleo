program fees.aleo;

record credits:
    owner as address.private;
    microcredits as u64.private;


mapping account:
	key as address.public;
	value as u64.public;

function fees:
    input r0 as u64.public;
    input r1 as field.public;
    assert.neq r0 0u64;
    assert.neq r1 0field;
    cast self.caller r0 into r2 as credits.record;
    async fees self.caller r0 into r3;
    output r2 as credits.record;
    output r3 as fees.aleo/fees.future;

finalize fees:
    input r0 as address.public;
    input r1 as u64.public;
    get.or_use account[r0] 0u64 into r2;
    sub r2 r1 into r3;
    set r3 into account[r0];
