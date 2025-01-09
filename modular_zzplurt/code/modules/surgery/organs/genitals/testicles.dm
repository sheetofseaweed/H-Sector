/obj/item/organ/external/genital/testicles/build_from_dna(datum/dna/DNA, associated_key)
	. = ..()
	if(DNA.features["testicles_fluid"])
		internal_fluid_datum = DNA.features["testicles_fluid"]
