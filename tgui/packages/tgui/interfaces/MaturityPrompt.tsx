import { useState } from 'react';

import { useBackend } from '../backend';
import {
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
  timeout: number;
  current_year: number;
  current_month: number;
  current_day: number;
};

export const MaturityPrompt = (props) => {
  const { act, data } = useBackend<MaturityPromptData>();
  const { current_year, current_month, current_day, timeout } = data;
  const [set_year, setYear] = useState(current_year);
  const [set_month, setMonth] = useState(current_month);
  const [set_day, setDay] = useState(current_day);
  const [buttonClicked, setButtonClicked] = useState(false);

  const windowHeight = 210;
  const windowWidth = 280;

  const handleButtonClick = () => {
    if (buttonClicked) {
      // If button has already been clicked once, perform the submit action
      act('submit', {
        year: set_year,
        month: set_month,
        day: set_day,
      });
    } else {
      // If button hasn't been clicked yet, set it to clicked state
      setButtonClicked(true);
    }
  };

  return (
    <Window height={windowHeight} title={'Are you 18+?'} width={windowWidth}>
      {!!timeout && <Loader value={timeout} />}
      <Window.Content>
        <Section fill>
          <Stack fill vertical>
            <Stack.Item grow m={1}>
              <Box color="label" overflow="hidden">
                {
                  'This is a community with a minimum age requirement. Please submit your date of birth.\
                   We only retain the year and month, the day is discarded after the initial check.'
                }
              </Box>
            </Stack.Item>
            <Stack.Item align="center">
              <LabeledControls width="150px">
                <LabeledControls.Item label="Year">
                  <NumberInput
                    value={set_year}
                    minValue={1900}
                    maxValue={current_year}
                    step={1}
                    stepPixelSize={5}
                    onChange={(value) => setYear(value)}
                  />
                </LabeledControls.Item>
                {'-'}
                <LabeledControls.Item label="Month">
                  <NumberInput
                    value={set_month}
                    minValue={1}
                    maxValue={12}
                    step={1}
                    stepPixelSize={5}
                    onChange={(value) => setMonth(value)}
                  />
                </LabeledControls.Item>
                {'-'}
                <LabeledControls.Item label="Day">
                  <NumberInput
                    value={set_day}
                    minValue={1}
                    maxValue={31}
                    step={1}
                    stepPixelSize={5}
                    onChange={(value) => setDay(value)}
                  />
                </LabeledControls.Item>
              </LabeledControls>
            </Stack.Item>
            <Stack.Item>
              <Button
                width="100%"
                align="center"
                color={buttonClicked ? 'red' : 'green'}
                content={buttonClicked ? 'Confirm' : 'Submit'}
                icon="calendar"
                onClick={handleButtonClick}
              />
            </Stack.Item>
          </Stack>
        </Section>
      </Window.Content>
    </Window>
  );
};
