import { useBackend } from '../backend';
import { Stack, Section, Box, Button } from '../components';
import { Window } from '../layouts';
import { Minimap } from './Minimap';

export const DispatchConsole = () => {
  return (
    <Window
      width={1280}
      height={720}>
      <Window.Content>
        <DispatchContent />
      </Window.Content>
    </Window>
  );
};

const DispatchContent = (props, context) => {
  const { act, data } = useBackend(context);
  return (
    <Stack fill>
      <Stack.Item width="30%">
        <Section fill title="Officers" scrollable>
          <Stack vertical>
            {Object.keys(data.officer_icons).map(item => (
              <Stack.Item key={item}>
                <Button
                  fluid
                  onClick={() => {
                    act('ping_officer', { ref: item });
                  }}
                  display="inline-block"
                  word-wrap="break-word"
                  textAlign="center"
                >
                  <Stack vertical fontSize="15px">
                    <Stack.Item>
                      <img src={data.officer_icons[item]} />
                    </Stack.Item>
                    <Stack.Item>
                      {data.officer_names[item]}
                    </Stack.Item>
                  </Stack>
                </Button>
              </Stack.Item>
            ))}
          </Stack>
        </Section>
      </Stack.Item>
      <Stack.Item width="70%">
        <Section fill overflow="hidden" position="relative" title="Minimap">
          <Box overflow="hidden" position="relative" width="100%" height="100%">
            <Minimap
              map_name={data.map_name}
              map_size_x={data.map_size_x}
              map_size_y={data.map_size_y}
              coord_data={data.coord_data}
              icon_size={data.icon_size}
            />
          </Box>
        </Section>
      </Stack.Item>
    </Stack>
  );
};
