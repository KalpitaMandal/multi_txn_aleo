// The 'fees' program.
program fees.aleo {

    mapping account: address => u64;

    record credits {
        // The token owner.
        owner: address,
        // The token amount.
        microcredits: u64,
    }
    
    transition fees(public fee: u64, public chksm: field) -> credits {
        assert_neq(fee, 0u64);
        assert_neq(chksm, 0field);
        return credits {
            owner: self.caller,
            microcredits: fee
        } then finalize(self.caller, fee);
    }

    finalize fees (public caller: address, public fee: u64) {
        let caller_balance: u64 = Mapping::get_or_use(account, caller, 0u64);
        Mapping::set(account, caller, caller_balance - fee);
    }
}
