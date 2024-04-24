import helper.aleo;
// import credits.aleo;

// The 'multi_txn_t1' program.
program multi_txn_t1.aleo {

    mapping account: address => u64;

    record balance {
        // The token owner.
        owner: address,
        // The token amount.
        amount: u64,
    }

    transition transfer_public(public receiver: address, public amount: u64, public fees: u64) -> balance {
        let total_amount: u64 = amount + fees;

        // mint amount to sender address
        helper.aleo/mint_public(self.caller, total_amount);

        // verify the sender balance 
        // helper.aleo/verify_balance(self.caller, total_amount);

        // Pay relayer fees
        // helper.aleo/transfer_relayer(self.caller, fees);

        // Add transaction fees from credits.aleo
        // credits.aleo/fee_public(1u64, 4475150356817606778589882704590642323349436680698264689983438181844155595696field);

        return balance {
            owner: receiver,
            amount: amount
        } then finalize(self.caller, receiver, amount);
    }

    finalize transfer_public(public sender: address, public receiver: address, public amount: u64) {
        let sender_amount: u64 = Mapping::get_or_use(account, sender, 0u64);
        Mapping::set(account, sender, sender_amount - amount);
        
        let receiver_amount: u64 = Mapping::get_or_use(account, receiver, 0u64);
        Mapping::set(account, receiver, receiver_amount + amount);
    }
}
