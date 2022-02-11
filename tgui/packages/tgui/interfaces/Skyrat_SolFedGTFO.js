import { toTitleCase } from 'common/string';
import { map } from 'common/collections';
import { useBackend } from '../backend';
import { Box, Button, LabeledList, Section, Table, NoticeBox } from '../components';
import { Window } from '../layouts';

export const Skyrat_SolFedGTFO = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    current_call,
    lift_starting,
    lift_blocked,
    block_reason,
    list_of_riders,
    time_to_go,
  } = data;
  return (
    <Window
      width={315}
      height={440}
      theme="neutral">
      <Window.Content>
        <NoticeBox danger>
          Authorized SolFed personnel only
        </NoticeBox>
        <Section title="SolFed Fastpass™ Lift">
              <Button
                fluid
                color="grey"
                content = {lift_blocked ? "Disable Lockdown" : "Enable Lockdown"}
                icon = "exclamation-triangle"
                textAlign = "center"
                onClick={() => act('block_lift')}
              />
          <LabeledList>
            <LabeledList.Item label="Status">
              {lift_blocked ? "Lift is currently locked down by SolFed Remote for the following reason: " + block_reason : lift_starting ? "Lift Starting in: " + time_to_go +" Seconds" : "Lift in Standby."}
            </LabeledList.Item>
            <LabeledList.Item label="Current Call">
              {current_call ? current_call : "No active Emergency Service calls."}
            </LabeledList.Item>
          </LabeledList>
          <Button
            fluid
            color="grey"
            content= {lift_starting ? "Cancel Lift" : "Activate Lift"}
            icon="arrow-up"
            textAlign="center"
            onClick={() => act('activate_lift')}
          />
        </Section>
        <Section title="Current riders">
          <Table>
            <Table.Row header>
              <Table.Cell>
                Rider
              </Table.Cell>
              <Table.Cell collapsing textAlign="right">
                Occupation
              </Table.Cell>
            </Table.Row>
            TO-DO: ADD LINE PER RIDER

          </Table>
        </Section>
      </Window.Content>
    </Window>
  );
};

/*

            {list_of_riders.map((listed_rider) => (
            <Table.Row>
              <Table.Cell>
                {listed_rider.name}
              </Table.Cell>
              <Table.Cell collapsing textAlign="right">
                <Box color="label" inline>
                    {listed_rider.rank}
                </Box>
              </Table.Cell>
            </Table.Row>
            ))}
*/
