import { BooleanLike } from 'common/react';
import { useBackend } from '../backend';
import { Box, Button, LabeledList, NoticeBox, Section, Stack } from '../components';
import { Window } from '../layouts';

type Data = {
  proper_name: string;
  wires: Wire[];
  status: string[];
};

type Wire = {
  color: string;
  cut: BooleanLike;
  wire: string;
  disabled: BooleanLike;
};

export const WirePuzzle = (props, context) => {
  const { data } = useBackend<Data>(context);
  const { proper_name, status = [], wires = [] } = data;
  const dynamicHeight = wires.length * 30 + (proper_name ? 30 : 0);

  return (
    <Window width={350} height={dynamicHeight} theme="ntos">
      <Window.Content>
        <Stack fill vertical>
          {!!proper_name && (
            <Stack.Item>
              <NoticeBox textAlign="center">
                {proper_name} Wire Configuration
              </NoticeBox>
            </Stack.Item>
          )}
          <Stack.Item grow>
            <Section fill>
              <WireMap />
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

/** Returns a labeled list of wires */
const WireMap = (props, context) => {
  const { act, data } = useBackend<Data>(context);
  const { wires } = data;

  return (
    <LabeledList>
      {wires.map((wire) => (
        <LabeledList.Item
          key={wire.color}
          className="candystripe"
          label={wire.color}
          labelColor={wire.color}
          color={wire.color}
          buttons={
            <>
              <Button
                content="Cut"
                disabled={wire.disabled}
                onClick={() =>
                  act('cut', {
                    wire: wire.wire,
                  })
                }
              />
              <Button
                content="Pulse"
                disabled={wire.disabled}
                onClick={() =>
                  act('pulse', {
                    wire: wire.wire,
                  })
                }
              />
            </>
          }>
          {!!wire.wire && <i>({wire.color})</i>}
        </LabeledList.Item>
      ))}
    </LabeledList>
  );
};
