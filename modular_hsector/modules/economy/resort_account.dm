GLOBAL_LIST_INIT(startingmoneylist, list(
	"Bankrupt" = 0,
	"In debt" = 400,
	"Average wealth" = 1500,
	"With savings" = 4000,
	"Rich" = 10000
	))

/datum/bank_account/resort
	var/is_resort_account = TRUE

/datum/bank_account/resort/payday(amount_of_paychecks, free = FALSE, starting_money_amount = 800) //It's all hacky as hell, but whatever, we ball.

	if(is_resort_account)
		if(!account_job)
			return
		if(amount_of_paychecks == 1)
			return FALSE
		var/money_to_transfer = starting_money_amount
		adjust_money(money_to_transfer, "Nanotrasen: Shift Payment")
		SSblackbox.record_feedback("amount", "free_income", money_to_transfer)
		SSeconomy.station_target += money_to_transfer
		log_econ("[money_to_transfer] credits were given to [src.account_holder]'s account from income.")
		return TRUE
	. = ..()


/datum/preference/choiced/starting_cash_amount
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "starting_cash_amount"

/datum/preference/choiced/starting_cash_amount/init_possible_values()
	return GLOB.startingmoneylist

/datum/preference/choiced/starting_cash_amount/create_default_value()
	return "Average wealth"

/datum/preference/choiced/starting_cash_amount/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE
