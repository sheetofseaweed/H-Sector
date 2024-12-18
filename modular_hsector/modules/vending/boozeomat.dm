/obj/machinery/vending/boozeomat/Initialize()
	var/list/extra_product_cats = list(
		list(
			"name" = "Non-Alcoholic",
			"icon" = "bottle-water",
			"products" = list(
				/obj/item/reagent_containers/cup/glass/bottle/vampire_bottle = 10,
			),
		),
	)
	LAZYADD(products, extra_product_cats)
	. = ..()
