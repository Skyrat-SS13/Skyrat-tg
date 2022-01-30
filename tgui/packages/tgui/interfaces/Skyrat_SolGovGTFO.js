import { toTitleCase } from 'common/string';
import { map } from 'common/collections';
import { useBackend } from '../backend';
import { Box, Button, LabeledList, Section, Table, NoticeBox } from '../components';
import { Window } from '../layouts';

export const Skyrat_SolGovGTFO = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    lift_status,
    current_call,
    list_of_riders,
  } = data;
  return (
    <Window
      width={315}
      height={440}
      theme="neutral">
      <Window.Content>
        <NoticeBox danger>
          Authorized SolGov personnel only
        </NoticeBox>
        <Section title="SolGov Fastpass™ Lift">
          <LabeledList>
            <LabeledList.Item label="Status">
              {lift_status ? launching : "Lift Inactive."}
            </LabeledList.Item>
            <LabeledList.Item label="Current Call">
              {current_call ? current_call : "No active Emergency Service calls."}
            </LabeledList.Item>
          </LabeledList>
          <Button
            fluid
            content="Activate Lift"
            icon="arrow-up"
            textAlign="center"
            onClick={() => act('activate_lift', {
              user: data.user,
              list_of_riders: get_riders()
            })}
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
              <Table.Row>
                <Table.Cell>
                  TEST LINE A
                </Table.Cell>
                <Table.Cell collapsing textAlign="right">
                  <Box color="label" inline>
                    TEST LINE B
                  </Box>
                </Table.Cell>
              </Table.Row>
          </Table>
        </Section>
      </Window.Content>
    </Window>
  );
};

//{toTitleCase(found_rider.get_authentification_name())} test line A
//{toTitleCase(found_rider.get_assignment())} test line B
