import { BooleanLike } from 'common/react';

import { useBackend } from '../backend';
import {
  Box,
  Button,
  Collapsible,
  NumberInput,
  Section,
} from '../components';
import { Window } from '../layouts';

type Data = {
  playing: BooleanLike;
  max_repeats: number;
  repeat: number;
  bpm: number;
  lines: LineData[];
  max_line_chars: number;
  max_lines: number;
};

type InstrumentData = {
  name: string;
  id: string;
};

type LineData = {
  line_count: number;
  line_text: string;
};

export const SongEditor = (props) => {
  const { data } = useBackend<Data>();

  return (
    <Window width={750} height={500}>
      <Window.Content scrollable>
        <SongSettings />
        <Collapsible open title="Music Editor" icon="pencil">
          <EditingSettings />
        </Collapsible>
        <Collapsible title="Help Section" icon="question">
          <HelpSection />
        </Collapsible>
      </Window.Content>
    </Window>
  );
};

const SongSettings = (props) => {
  const { act, data } = useBackend<Data>();
  const { playing, repeat, max_repeats, lines } = data;

  /*  const instrument_id_by_name = (name) => {
    return possible_instruments.find((instrument) => instrument.name === name)
      ?.id;
  };*/

  return (
    <Section title="Settings">
      {lines.length > 0 && (
        <Box fontSize="16px">
          <Button onClick={() => act('sing')}>
            {playing ? 'Stop Music' : 'Start Playing'}
          </Button>
        </Box>
      )}
      <Box>
        Repeats Left:
        <NumberInput
          step={1}
          minValue={0}
          disabled={playing}
          maxValue={max_repeats}
          value={repeat}
          onChange={(value) =>
            act('set_repeat_amount', {
              amount: value,
            })
          }
        />
      </Box>
    </Section>
  );
};

const EditingSettings = (props) => {
  const { act, data } = useBackend<Data>();
  const { bpm, lines } = data;

  return (
    <Section>
      <Box>
        <Button onClick={() => act('start_new_song')}>Start a New Song</Button>
        <Button onClick={() => act('import_song')}>Import a Song</Button>
      </Box>
      <Box>
        Tempo:{' '}
        <Button
          onClick={() => act('tempo', { tempo_change: 'increase_speed' })}
        >
          -
        </Button>{' '}
        {bpm} BPM{' '}
        <Button
          onClick={() => act('tempo', { tempo_change: 'decrease_speed' })}
        >
          +
        </Button>
      </Box>
      <Box>
        {lines.map((line, index) => (
          <Box key={index} fontSize="11px">
            Line {index}:
            <Button
              onClick={() =>
                act('modify_line', { line_editing: line.line_count })
              }
            >
              Edit
            </Button>
            <Button
              onClick={() =>
                act('delete_line', { line_deleted: line.line_count })
              }
            >
              X
            </Button>
            {line.line_text}
          </Box>
        ))}
      </Box>
      <Box>
        <Button onClick={() => act('add_new_line')}>Add Line</Button>
      </Box>
    </Section>
  );
};

const HelpSection = (props) => {
  const { data } = useBackend<Data>();
  const { max_line_chars, max_lines } = data;

  return (
    <Section>
      <Box>Lines are</Box>
    </Section>
  );
};
