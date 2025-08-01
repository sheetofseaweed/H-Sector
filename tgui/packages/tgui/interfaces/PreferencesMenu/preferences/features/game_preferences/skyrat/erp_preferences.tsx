// THIS IS A SKYRAT UI FILE
import { CheckboxInput, type FeatureToggle } from '../../base';

/* export const master_erp_pref: FeatureToggle = {
  name: 'Show/Hide Erotic Roleplay Preferences',
  category: 'ERP',
  description: 'This shows/hides ERP preferences.',
  component: CheckboxInput,
};*/

export const defiance_pref: FeatureToggle = {
  name: 'Defiance',
  category: 'ERP',
  description:
    'With this toggled off, you will not be able to change your preferences in-game, and will lose the ablity to use your safe-word.',
  component: CheckboxInput,
};

export const erp_sounds_pref: FeatureToggle = {
  name: 'ERP sounds',
  category: 'ERP',
  description: 'Toggles if you want to hear sounds from ERP mechanics.',
  component: CheckboxInput,
};

export const erp_mob_sex_pref: FeatureToggle = {
  name: 'Mob ERP interactions',
  category: 'ERP',
  description: 'Toggles if you want to ERP-interact with mobs.',
  component: CheckboxInput,
};

export const afk_erp_pref: FeatureToggle = {
  name: 'AFK character interaction',
  category: 'ERP',
  description:
    'Toggles if you want your character to be interacted with when you are AFK or SSD.',
  component: CheckboxInput,
};
export const bimbofication_pref: FeatureToggle = {
  name: 'Bimbofication',
  category: 'ERP',
  description:
    'Toggles if you are able to react to the effects of bimbofication.',
  component: CheckboxInput,
};

export const aphro_pref: FeatureToggle = {
  name: 'Aphrodisiacs',
  category: 'ERP',
  description:
    'Toggles whether you wish to receive the effects of aphrodisiacs',
  component: CheckboxInput,
};

/* export const sextoy_pref: FeatureToggle = {
  name: 'Sex toy interaction',
  category: 'ERP',
  description: 'When enabled, you will be able to interact with sex toys.',
  component: CheckboxInput,
};

export const sextoy_sounds_pref: FeatureToggle = {
  name: 'Sex toy sounds',
  category: 'ERP',
  description: 'Toggles if you will hear sounds from sex toys.',
  component: CheckboxInput,
}; */

export const vore_enable_pref: FeatureToggle = {
  name: 'Enable Mechanical Vore',
  category: 'ERP',
  description: 'Toggles if you are able to use vore mechanics.',
  component: CheckboxInput,
};

// BUBBER EDIT START: MECHANICAL HYPNOSIS PREF
export const hypnosis_pref: FeatureToggle = {
  name: 'Hypnosis',
  category: 'ERP',
  description:
    'Determines if you wish to allow hypnosis/hypnosis chemicals in a lewd manner.',
  component: CheckboxInput,
};
// BUBBER EDIT END

export const breast_enlargement_pref: FeatureToggle = {
  name: 'Breast enlargement',
  category: 'ERP',
  description:
    'Determines if you wish to receive the effects of breast enlargement chemicals.',
  component: CheckboxInput,
};

export const breast_shrinkage_pref: FeatureToggle = {
  name: 'Breast shrinkage',
  category: 'ERP',
  description:
    'Determines if you wish to receive the effects of breast shrinkage chemicals.',
  component: CheckboxInput,
};

export const breast_removal_pref: FeatureToggle = {
  name: 'Complete breast shrinkage',
  category: 'ERP',
  description:
    'Determines if you wish to receive the full effects of breast shrinkage chemicals.',
  component: CheckboxInput,
};

export const penis_enlargement_pref: FeatureToggle = {
  name: 'Penis enlargement',
  category: 'ERP',
  description:
    'Determines if you wish to receive the effects of penis enlargement chemicals.',
  component: CheckboxInput,
};

export const autocum_pref: FeatureToggle = {
  name: 'Autocum',
  category: 'ERP',
  description:
    'Toggles whether you automatically cum using the arousal system, or if you need to do it manually.',
  component: CheckboxInput,
};

export const autoemote_pref: FeatureToggle = {
  name: 'Auto Emote',
  category: 'ERP',
  description:
    'Toggles whether you automatically emote using the arousal system, or if you need to do it manually.',
  component: CheckboxInput,
};

export const penis_shrinkage_pref: FeatureToggle = {
  name: 'Penis shrinkage',
  category: 'ERP',
  description:
    'Determines if you wish to receive the effects of penis shrinkage chemicals.',
  component: CheckboxInput,
};

export const gender_change_pref: FeatureToggle = {
  name: 'Forced gender change',
  category: 'ERP',
  description: 'Determines if you wish to allow forced gender changing.',
  component: CheckboxInput,
};

export const sex_jitter_pref: FeatureToggle = {
  name: 'Sex Jitter',
  category: 'ERP',
  description: 'Toggles whether you automatically shake and jitter during sex.',
  component: CheckboxInput,
};

export const horny_virus_imm_pref: FeatureToggle = {
  name: 'Horny Viruses',
  category: 'ERP',
  description:
    'Toggles whether you are immune or not to lewd illnesses and viruses.',
  component: CheckboxInput,
};

export const erp_event_participation_pref: FeatureToggle = {
  name: 'ERP Event Participation',
  category: 'ERP',
  description:
    'This shows admins that you are willing to participate in horny events.',
  component: CheckboxInput,
};

/* SPLURT EDIT REMOVAL - No
export const erp_sexuality_pref: FeatureChoiced = {
  name: 'Sexuality Preference',
  category: 'ERP',
  description:
    'Determines what sexual content you see, limited use. None will show all content.',
  component: FeatureDropdownInput,
};
*/ // SPLURT EDIT REMOVAL END

export const genitalia_removal_pref: FeatureToggle = {
  name: 'ERP Genitalia Removal',
  category: 'ERP',
  description:
    'If checked, allows drugs to remove existing genitalia on your character.',
  component: CheckboxInput,
};

export const new_genitalia_growth_pref: FeatureToggle = {
  name: 'ERP New Genitalia Growth',
  category: 'ERP',
  description:
    'If checked, allows drugs to grow new genitalia on your character.',
  component: CheckboxInput,
};

export const vore_overlays: FeatureToggle = {
  name: 'Vore Overlays',
  category: 'ERP',
  description:
    'When enabled, will you be shown fullscreen vore overlays while inside of a soulcatcher?',
  component: CheckboxInput,
};

export const vore_overlay_options: FeatureToggle = {
  name: 'Vore Overlay Options',
  category: 'ERP',
  description:
    'Do you want to see fullscreen vore overlays as an option for soulcatcher overlays?',
  component: CheckboxInput,
};
