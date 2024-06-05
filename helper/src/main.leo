// The 'helper' program.
program helper.aleo {
    mapping account: address => u64;

    record balance {
        // The token owner.
        owner: address,
        // The token amount.
        amount: u64,
    }

    transition mint_private(receiver: address, amount: u64)-> balance {
        return balance {
            owner: receiver,
            amount: amount
        };
    }

    transition mint_public(public receiver: address, public amount: u64)-> balance {
        return balance {
            owner: receiver,
            amount: amount
        } then finalize(receiver,amount);
    }

    finalize mint_public(public receiver: address, public amount: u64) {
        let receiver_balance: u64 = Mapping::get_or_use(account, receiver, amount);
        Mapping::set(account, receiver, receiver_balance + amount);
    }

    transition verify_balance_private(sender_balance: balance) {
        assert_neq(sender_balance.amount, 0u64);
    }

    transition verify_balance(public sender: address, public amount: u64) {
        return then finalize(sender, amount);
    }

    finalize verify_balance(public sender: address, public amount: u64) {
        let sender_balance: u64 = Mapping::get_or_use(account, sender, 0u64);
        assert_neq(sender_balance, 0u64);
    }

    transition transfer_relayer_private(fees: u64, sender_balance: balance)-> (balance, balance) {
        assert_eq(fees, 1u64);
        let remaining: u64 = sender_balance.amount - fees;
        let relayer: address = aleo1va0hzrcsj569gz0gd0mvue7xk54vku626nsmvl86s7j490x7yupq89l82z; // address
        
        let relayer_out: balance = balance {
            owner: relayer,
            amount: fees
        };

        let sender_out: balance = balance {
            owner: sender_balance.owner,
            amount: remaining
        };
        return (relayer_out, sender_out);
    }

    transition transfer_relayer(public sender: address, public fees: u64) {
        let relayer: address = aleo1va0hzrcsj569gz0gd0mvue7xk54vku626nsmvl86s7j490x7yupq89l82z; // address
        assert_eq(fees, 1u64);
        return then finalize(sender, relayer, fees);
    }

    finalize transfer_relayer(public sender: address, public relayer: address, public fees: u64) {
        let sender_amount: u64 = Mapping::get_or_use(account, sender, 0u64);
        Mapping::set(account, sender, sender_amount - fees);

        let relay_amount: u64 = Mapping::get_or_use(account, relayer, 0u64);
        Mapping::set(account, relayer, relay_amount + fees);
    }
}
