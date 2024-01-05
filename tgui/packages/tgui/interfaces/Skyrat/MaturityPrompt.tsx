import { useBackend, useLocalState } from '../../backend';
import { Autofocus, Box, Section, Stack } from '../../components';
import { Window } from '../../layouts';
import { Loader } from '../common/Loader';

type MaturityPromptData = {
  year: number;
  month: number;
  day: number;
  title: string;
  message: string;
  timeout: number;
};

export const MaturityPromptModal = (props) => {
  const { act, data } = useBackend<MaturityPromptData>();
  const { title, message, timeout } = data;
  const [selected, setSelected] = useLocalState<number>('selected', 0);
  // Dynamically sets window dimensions
  const windowHeight =
    115 +
    (message.length > 30 ? Math.ceil(message.length / 4) : 0);
  const windowWidth = 325;

  return (
    <Window height={windowHeight} title={title} width={windowWidth}>
      {!!timeout && <Loader value={timeout} />}
      <Window.Content>
        <Section fill>
          <Stack fill vertical>
            <Stack.Item grow m={1}>
              <Box color="label" overflow="hidden">
                {message}
              </Box>
            </Stack.Item>
            <Stack.Item>
              <Autofocus />
              <ButtonDisplay selected={selected} />
            </Stack.Item>
          </Stack>
        </Section>
      </Window.Content>
    </Window>
  );
};
