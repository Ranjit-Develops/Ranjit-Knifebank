local Translations = {
    error = {
        negative = 'Versuchen Sie, einen negativen Betrag einzuzahlen?',
        no_items = 'Nicht genug Gegenstände',
        no_license = 'Sie haben keine %{value} Lizenz'
    },
    success = {
        sold = 'Sie haben %{value} x %{value2} für $%{value3} eingezahlt',
    },
    info = {
        title = 'Knife Bank',
        Deposit = 'Einzahlen',
        Deposit_to = 'Einzahlen in die Knife Bank',
        buy = 'Gegenstand kaufen',
        buy_from = 'Gegenstand von Knife Bank kaufen',
        back = '⬅ Zurück',
        max = '%{value} Maximalbetrag',
        close = 'Schließen'
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})