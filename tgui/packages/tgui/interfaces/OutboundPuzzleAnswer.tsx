import { useBackend } from '../backend';
import { Box, LabeledList, NoticeBox, Section, Stack } from '../components';
import { Window } from '../layouts';

type Data = {
  proper_name: string;
  all_puzzles: Puzzle[];
  status: string[];
};

type Puzzle = {
  puzzname: string;
  desc: string;
};

export const OutboundPuzzleAnswer = (props, context) => {
  const { data } = useBackend<Data>(context);
  const { proper_name, status = [], all_puzzles = [] } = data;
  const dynamicHeight = all_puzzles.length * 300 + (proper_name ? 30 : 0);

  return (
    <Window width={350} height={dynamicHeight} theme="ntos">
      <Window.Content>
        <Stack fill vertical>
          {!!proper_name && (
            <Stack.Item>
              <NoticeBox textAlign="center">
                {proper_name} Puzzle Configuration
              </NoticeBox>
            </Stack.Item>
          )}
          <Stack.Item grow>
            <Section fill>
              <GuideMap />
            </Section>
          </Stack.Item>
          {!!status.length && (
            <Stack.Item>
              <Section>
                {status.map((status) => (
                  <Box key={status}>{status}</Box>
                ))}
              </Section>
            </Stack.Item>
          )}
        </Stack>
      </Window.Content>
    </Window>
  );
};

/** Returns a labeled list of all_puzzles */
const GuideMap = (props, context) => {
  const { act, data } = useBackend<Data>(context);
  const { all_puzzles } = data;

  return (
    <LabeledList>
      {all_puzzles.map((puzzle) => (
        <Section title={puzzle.puzzname}>
          <Box color="label" mt="3px" mb="5px">
            {puzzle.desc}
          </Box>
        </Section>
      ))}
    </LabeledList>
  );
};
