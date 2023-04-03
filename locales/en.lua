local Translations = {
    error = {
        negative = 'Trying to deposit a negative amount?',
        no_items = 'Not enough items',
        no_license = 'You do not have %{value} license'
    },
    success = {
        sold = 'You have Deposited %{value} x %{value2} for $%{value3}',
    },
    info = {
        title = 'KnifeBank',
        Deposit = 'Deposit',
        Deposit_to = 'Deposit in the KnifeBank',
        buy = 'Buy items',
        buy_from = 'Buy items from Knife Bank',
        back = '⬅ Go Back',
        max = 'Max Amount %{value}',
        close = 'Close'
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})