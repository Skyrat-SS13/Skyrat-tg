import { useBackend } from '../backend';
import {
  Autofocus,
  Box,
  Button,
  LabeledControls,
  NumberInput,
  Section,
  Stack,
} from '../components';
import { Window } from '../layouts';
import { Loader } from './common/Loader';

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
  const { year, month, day, title, message, timeout } = data;
  // Dynamically sets window dimensions
  const windowHeight =
    115 + (message.length > 30 ? Math.ceil(message.length / 4) : 0);
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
            <LabeledControls>
              <LabeledControls.Item ml={0.5} label="Year">
                <NumberInput
                  value={year}
                  minValue={1900}
                  maxValue={2020}
                  step={1}
                  stepPixelSize={5}
                />
              </LabeledControls.Item>
              <LabeledControls.Item ml={0.5} label="Month">
                <NumberInput
                  value={month}
                  minValue={1}
                  maxValue={12}
                  step={1}
                  stepPixelSize={5}
                />
              </LabeledControls.Item>
              <LabeledControls.Item ml={0.5} label="Day">
                <NumberInput
                  value={day}
                  minValue={1}
                  maxValue={31}
                  step={1}
                  stepPixelSize={5}
                />
              </LabeledControls.Item>
            </LabeledControls>
            <Stack.Item>
              <Autofocus />
              <Button
                content="Submit"
                onClick={() =>
                  act('submit', {
                    year: year,
                    month: month,
                    day: day,
                  })
                }
              />
            </Stack.Item>
          </Stack>
        </Section>
      </Window.Content>
    </Window>
  );
};
