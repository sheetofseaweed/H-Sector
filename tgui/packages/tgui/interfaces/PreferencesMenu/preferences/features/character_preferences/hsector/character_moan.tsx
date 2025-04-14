// THIS IS A HSECTOR UI FILE
import { Button, Stack } from 'tgui-core/components';

import { useBackend } from '../../../../../../backend';
import {
  FeatureChoiced,
} from '../../base';
import { FeatureDropdownInput } from '../../dropdowns';

const FeatureMoanDropdownInput = (props) => {
  const { act } = useBackend();
  return (
    <Stack>
      <Stack.Item grow>
        <FeatureDropdownInput {...props} />
      </Stack.Item>
      <Stack.Item>
        <Button
          onClick={() => {
            act('play_moan');
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
