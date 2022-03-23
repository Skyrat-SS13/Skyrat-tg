//Does the trader accept money for goods
#define TRADER_MONEY (1<<1)
//Does the trader accept goods for goods (barter)
#define TRADER_BARTER (1<<2)

#define TRADER_SELLS_GOODS (1<<3)

#define TRADER_BUYS_GOODS (1<<4)

//Cash amounts the traders get
#define DEFAULT_TRADER_CREDIT_AMOUNT 7000
#define RICH_TRADER_CREDIT_AMOUNT 15000
#define POOR_TRADER_CREDIT_AMOUNT 3500
#define VERY_POOR_TRADER_CREDIT_AMOUNT 1500

//Every time SStrading ticks, if the traders have cash below a threshold they'll gain a small injection of cash
#define TRADER_LOW_CASH_THRESHOLD 50 //In percentage
#define TRADER_PAYCHECK_LOW 500
#define TRADER_PAYCHECK_HIGH 1500

// Extra value margin for the user to make barter trades a bit easier
#define TRADE_BARTER_EXTRA_MARGIN 1.1

#define TRADER_SCREEN_NOTHING 0
#define TRADER_SCREEN_SOLD_GOODS 1
#define TRADER_SCREEN_BOUGHT_GOODS 2
#define TRADER_SCREEN_BOUNTIES 3
#define TRADER_SCREEN_DELIVERIES 4

#define TRADER_THIS_TYPE 1
#define TRADER_TYPES 2
#define TRADER_SUBTYPES 3
#define TRADER_BLACKLIST 4
#define TRADER_BLACKLIST_SUBTYPES 5
#define TRADER_BLACKLIST_TYPES 6

#define TRADER_DISPOSITION_REJECT_HAILS -50

/// What value the traders will round their costs to
#define TRADER_PRICE_ROUNDING 10

/// Percentage threshold of remaining stock at which they should restock that item
#define TRADER_RESTOCK_THRESHOLD 0.35

#define TRADE_HARD_BARGAIN_MARGIN 0.03

#define TRADE_USER_SUFFIX_AI "ai"
#define TRADE_USER_SUFFIX_CYBORG "silicon"
#define TRADE_USER_SUFFIX_GOLEM "golem"
#define TRADE_USER_SUFFIX_ROBOT_PERSON "robotperson"

#define TRADER_COST_MACRO(margin,variance) (1 * margin * ((100 + (rand(-variance,variance)))/100))

/*
hail_generic //When the trader hails the person
hail_deny //When the trader denies the hail
trade_show_goods //What the trader says when showing goods
trade_no_sell_goods //What the trader says when disclaiming that he doesnt sell goods
what_want //When showing what items he buys
trade_no_goods //When disclaiming he doesnt buy items
compliment_deny //When denies a compliment
compliment_accept //When accepts a compliment
insult_bad //When he's pissed off at an inuslt
insult_good //When he doesnt mind the insult much
pad_empty //When you try and conduct barter/selling but your pad is empty
how_much //When he appraises the value of item. ITEM = item name, VALUE = amount of cash worth
appraise_multiple //When he appraises the value of multiple items.  VALUE = amount of cash worth
trade_found_unwanted //When there's only items that they dont want on the pad
out_of_money //When the trader's out of money to pay us for stuff
doesnt_use_cash //When he disclaims that he doesnt use cash
trade_complete //Sentence after a successful trade
hard_bargain //Sentence after the user bargained very closely to the trader's limit
trade_not_enough //Sentence when the trader rejects a haggle or barter offer
too_much_value //When the user tries to sell something for too high of a price
out_of_stock //The trader is out of stock on an item the user wants to buy
user_no_money //When the user doesnt have enough money to perform a trade
only_deal_in_goods //When the user tries to sell items for money, but the trader doesnt deal in money
bounty_fail_claim //When the user tries to turn in a bounty, but doesn't meet the requirements
*/
