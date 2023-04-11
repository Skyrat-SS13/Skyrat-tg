import { Box, Button, Flex, Stack, Section, ProgressBar, AnimatedNumber, Table } from '../components';
import { toFixed } from 'common/math';
import { BooleanLike } from 'common/react';
import { useBackend } from '../backend';
import { Window } from '../layouts';

type GlassData = {
  hasGlass: BooleanLike;
  inUse: BooleanLike;
  glass: Glass;
};

type Glass = {
  chosenItem: CraftItem;
  stepsRemaining: RemainingSteps;
  timeLeft: number;
  totalTime: number;
  isFinished: BooleanLike;
};

type CraftItem = {
  name: string;
  type: string;
};

type RemainingSteps = {
  blow: number;
  spin: number;
  paddle: number;
  shear: number;
  jacks: number;
};

export const GlassBlowing = (props, context) => {
  const { act, data } = useBackend<GlassData>(context);
  const { glass, inUse } = data;

  return (
    <Window width={335} height={325}>
      <Window.Content scrollable>
        <Section
          title={glass && glass.timeLeft ? 'Molten Glass' : 'Cooled Glass'}
          buttons={
            <Button
              icon={glass && glass.isFinished ? 'check' : 'arrow-right'}
              color={glass && glass.isFinished ? 'good' : 'red'}
              content={glass && glass.isFinished ? 'Complete Craft' : 'Remove'}
              disabled={!glass || inUse}
              onClick={() => act('Remove')}
            />
          }
        />
        {glass && !glass.chosenItem && (
          <Section title="Pick a craft">
            <Stack fill vertical>
              <Stack.Item>
                <Box>What will you craft?</Box>
              </Stack.Item>

              <Stack.Item>
                <Button
                  content="Plate"
                  disabled={!glass || inUse}
                  onClick={() => act('Plate')}
                />
                <Button
                  content="Bowl"
                  tooltipPosition="bottom"
                  disabled={!glass || inUse}
                  onClick={() => act('Bowl')}
                />
                <Button
                  content="Globe"
                  disabled={!glass || inUse}
                  onClick={() => act('Globe')}
                />
                <Button
                  content="Cup"
                  disabled={!glass || inUse}
                  onClick={() => act('Cup')}
                />
                <Button
                  content="Lens"
                  tooltipPosition="bottom"
                  disabled={!glass || inUse}
                  onClick={() => act('Lens')}
                />
                <Button
                  content="Bottle"
                  disabled={!glass || inUse}
                  onClick={() => act('Bottle')}
                />
              </Stack.Item>
            </Stack>
          </Section>
        )}
        {glass && glass.chosenItem && (
          <Section title="Steps Remaining:">
            <Stack fill vertical>
              <Stack.Item>
                <Box>
                  You are crafting a {glass.chosenItem.name}.
                  <br />
                  <br />
                </Box>
              </Stack.Item>
              <Table>
                <Stack.Item>
                  <Table.Cell>
                    <Button
                      content="Blow"
                      icon="fire"
                      color="orange"
                      disabled={!glass || inUse || !glass.timeLeft}
                      tooltipPosition="bottom"
                      tooltip={
                        glass.timeLeft === 0 ? 'Needs to be glowing hot.' : ''
                      }
                      onClick={() => act('Blow')}
                    />
                    x{glass.stepsRemaining.blow}
                  </Table.Cell>
                  <Table.Cell>
                    <Button
                      content="Spin"
                      icon="fire"
                      color="orange"
                      disabled={!glass || inUse || !glass.timeLeft}
                      tooltipPosition="bottom"
                      tooltip={
                        glass.timeLeft === 0 ? 'Needs to be glowing hot.' : ''
                      }
                      onClick={() => act('Spin')}
                    />
                    x{glass.stepsRemaining.spin}
                  </Table.Cell>
                  <Table.Cell>
                    <Button
                      content="Paddle"
                      disabled={inUse}
                      tooltipPosition="bottom"
                      tooltip={'You need to use a paddle.'}
                      onClick={() => act('Paddle')}
                    />
                    x{glass.stepsRemaining.paddle}
                  </Table.Cell>
                  <Table.Cell>
                    <Button
                      content="Shears"
                      disabled={inUse}
                      tooltipPosition="bottom"
                      tooltip={'You need to use shears.'}
                      onClick={() => act('Shear')}
                    />
                    x{glass.stepsRemaining.shear}
                  </Table.Cell>
                  <Table.Cell>
                    <Button
                      content="Jacks"
                      disabled={inUse}
                      tooltipPosition="bottom"
                      tooltip={'You need to use jacks.'}
                      onClick={() => act('Jacks')}
                    />
                    x{glass.stepsRemaining.jacks}
                  </Table.Cell>
                </Stack.Item>
              </Table>
            </Stack>
          </Section>
        )}
        {glass && glass.chosenItem && (
          <Section title>
            <Flex direction="row-reverse">
              <Flex.Item>
                <Button
                  icon="times"
                  color="orange"
                  content="Cancel craft"
                  disabled={!glass || inUse}
                  onClick={() => act('Cancel')}
                />
              </Flex.Item>
            </Flex>
          </Section>
        )}
        {glass && glass.timeLeft !== 0 && (
          <Section title="Heat level">
            <ProgressBar
              value={glass.timeLeft / glass.totalTime}
              ranges={{
                red: [0.8, Infinity],
                orange: [0.65, 0.8],
                yellow: [0.3, 0.65],
                blue: [0.05, 0.3],
                black: [-Infinity, 0.05],
              }}
              style={{
                'background-image':
                  'linear-gradient(to right, blue, yellow, red)',
              }}>
              <AnimatedNumber
                value={glass.timeLeft}
                format={(value) => toFixed(value, 1)}
              />
              {'/' + glass.totalTime.toFixed(1)}
            </ProgressBar>
          </Section>
        )}
        {glass && glass.timeLeft === 0 && (
          <Section title="Heat level">
            <ProgressBar
              value={0 / 0}
              ranges={{}}
              style={{
                'background-image': 'grey',
              }}>
              <AnimatedNumber value={0} />
            </ProgressBar>
          </Section>
        )}
      </Window.Content>
    </Window>
  );
};
