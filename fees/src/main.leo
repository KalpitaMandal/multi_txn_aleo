// The 'fees' program.
program fees.aleo {

    mapping account: address => u64;

    record balance {
        // The token owner.
        owner: address,
        // The token amount.
        amount: u64,
    }
    
    transition fees(public fee: u64) {
        assert_neq(fee, 0u64);
        return then finalize(self.caller, fee);
    }

    finalize fees (public caller: address, public fee: u64) {
        let caller_balance: u64 = Mapping::get_or_use(account, caller, 0u64);
        Mapping::set(account, caller, caller_balance - fee);
    }

    transition fees_private(sender_balance: balance, public fee: u64) -> balance {
        assert_neq(fee, 0u64);

        let sender_out: balance = balance {
            owner: sender_balance.owner,
            amount: sender_balance.amount - fee,
        };

        return sender_out;
    }
}
