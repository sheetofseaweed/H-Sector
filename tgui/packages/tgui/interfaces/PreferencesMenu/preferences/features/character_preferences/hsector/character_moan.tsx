// THIS IS A HSECTOR UI FILE
import { Button, Stack } from '../../../../../../components';
import {
  FeatureChoiced,
  FeatureChoicedServerData,
  FeatureValueProps,
} from '../../base';
import { FeatureDropdownInput } from '../../dropdowns';

const FeatureMoanDropdownInput = (
  props: FeatureValueProps<string, string, FeatureChoicedServerData>,
) => {
  return (
    <Stack>
      <Stack.Item grow>
        <FeatureDropdownInput {...props} />
      </Stack.Item>
      <Stack.Item>
        <Button
          onClick={() => {
            props.act('play_moan');
          }}
          icon="play"
          width="100%"
          height="100%"
        />
      </Stack.Item>
    </Stack>
  );
};

export const character_moan: FeatureChoiced = {
  name: 'Character Moan',
  component: FeatureMoanDropdownInput,
};

export const character_voice_type: FeatureChoiced = {
  name: 'Character Voice Type',
  description:
    'This option selects which screams and moans your character will use.',
  component: FeatureDropdownInput,
};
