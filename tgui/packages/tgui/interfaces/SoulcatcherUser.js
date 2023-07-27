import { useBackend } from '../backend';
import { Window } from '../layouts';
import { BlockQuote, Button, Divider, Box, Flex, Collapsible, LabeledList, Section } from '../components';

export const SoulcatcherUser = (props, context) => {
  const { act, data } = useBackend(context);
  const { current_room, user_data, souls = [] } = data;

  return (
    <Window width={520} height={400} resizable>
      <Window.Content scrollable>
        <Section
          key={current_room.key}
          title={
            <span style={{ color: current_room.color }}>
              {current_room.name}
            </span>
          }>
          <BlockQuote preserveWhitespace>
            {' '}
            {current_room.description}
          </BlockQuote>
          <br />
          <Box textAlign="center" fontSize="15px" opacity={0.8}>
            <b>{user_data.name} </b>
            {!user_data.scan_needed && user_data.able_to_rename ? (
              <>
                <Button
                  color="green"
                  icon="pen"
                  tooltip="Change your name."
                  onClick={() => act('change_name', {})}
                />
                <Button
                  color="red"
                  icon="arrow-rotate-left"
                  tooltip="Reset your name."
                  onClick={() => act('reset_name', {})}
                />
              </>
            ) : (
              <> </>
            )}
          </Box>
          <Divider />
          <Collapsible title="Flavor Text">
            <BlockQuote preserveWhitespace>{user_data.description}</BlockQuote>
          </Collapsible>
          <Collapsible title="OOC Notes">
            <BlockQuote preserveWhitespace>{user_data.ooc_notes}</BlockQuote>
          </Collapsible>
          <Collapsible title="Soul Info">
            <LabeledList textAlign>
              <LabeledList.Item label="Ability to see outside">
                {user_data.outside_sight ? 'Enabled' : 'Disabled'}
              </LabeledList.Item>
              <LabeledList.Item label="Ability to hear outside">
                {user_data.outside_hearing ? 'Enabled' : 'Disabled'}
              </LabeledList.Item>
              <LabeledList.Item label="Ability to see inside">
                {user_data.internal_sight ? 'Enabled' : 'Disabled'}
              </LabeledList.Item>
              <LabeledList.Item label="Ability to hear inside">
                {user_data.internal_hearing ? 'Enabled' : 'Disabled'}
              </LabeledList.Item>
              <LabeledList.Item label="Ability to speak">
                {user_data.able_to_speak ? 'Enabled' : 'Disabled'}
              </LabeledList.Item>
              <LabeledList.Item label="Ability to emote">
                {user_data.able_to_emote ? 'Enabled' : 'Disabled'}
              </LabeledList.Item>
              <LabeledList.Item label="Ability to change name">
                {user_data.able_to_rename && !user_data.scan_needed
                  ? 'Enabled'
                  : 'Disabled'}
              </LabeledList.Item>
              <LabeledList.Item label="Body Scan Needed">
                {user_data.scan_needed ? 'True' : 'False'}
              </LabeledList.Item>
            </LabeledList>
          </Collapsible>

          {souls && user_data.internal_sight ? (
            <>
              <br />
              <Box textAlign="center" fontSize="15px" opacity={0.8}>
                <b>Souls</b>
              </Box>
              <Divider />
              <Flex direction="column">
                {souls.map((soul) => (
                  <Flex.Item key={soul.key}>
                    <Collapsible title={soul.name}>
                      <Box textAlign="center" fontSize="13px" opacity={0.8}>
                        <b>Flavor Text</b>
                      </Box>
                      <Divider />
                      <BlockQuote preserveWhitespace>
                        {soul.description}
                      </BlockQuote>
                      <br />
                      <Box textAlign="center" fontSize="13px" opacity={0.8}>
                        <b>OOC Notes</b>
                      </Box>
                      <Divider />
                      <BlockQuote preserveWhitespace>
                        {soul.ooc_notes}
                      </BlockQuote>
                    </Collapsible>
                  </Flex.Item>
                ))}
              </Flex>
            </>
          ) : (
            <> </>
          )}
        </Section>
      </Window.Content>
    </Window>
  );
};
